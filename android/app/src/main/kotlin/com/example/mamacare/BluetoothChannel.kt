package com.example.mamacare

import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.io.IOException
import java.util.*

class BluetoothChannel : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
    private var btSocket: BluetoothSocket? = null
    private val uuid: UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")
    private var readJob: Job? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "bluetooth_channel")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getBondedDevices" -> getBondedDevices(result)
            "connect" -> {
                val address = call.argument<String>("address")
                if (address != null) connectToDevice(address, result)
                else result.error("INVALID_ARGS", "Bluetooth address is null", null)
            }
            "sendData" -> {
                val data = call.argument<String>("data")
                if (data != null) sendData(data, result)
                else result.error("INVALID_ARGS", "Data is null", null)
            }
            "disconnect" -> {
                disconnect()
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    @SuppressLint("MissingPermission")
    private fun getBondedDevices(result: MethodChannel.Result) {
        if (bluetoothAdapter == null) {
            result.error("NO_ADAPTER", "Bluetooth not supported", null)
            return
        }

        val devices = bluetoothAdapter.bondedDevices.map { device ->
            mapOf(
                "name" to (device.name ?: "Unknown"),
                "address" to device.address
            )
        }
        result.success(devices)
    }

    @SuppressLint("MissingPermission")
    private fun connectToDevice(address: String, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val device: BluetoothDevice = bluetoothAdapter?.getRemoteDevice(address)
                    ?: throw IOException("Device not found")

                btSocket = device.createRfcommSocketToServiceRecord(uuid)
                btSocket?.connect()
                startReading()

                withContext(Dispatchers.Main) {
                    result.success("Connected to ${device.name}")
                }
            } catch (e: Exception) {
                e.printStackTrace()
                withContext(Dispatchers.Main) {
                    result.error("CONNECT_FAILED", e.message, null)
                }
            }
        }
    }

    private fun sendData(data: String, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val finalData = "$data\n"
                btSocket?.outputStream?.write(finalData.toByteArray())
                btSocket?.outputStream?.flush()
                withContext(Dispatchers.Main) { result.success(true) }
            } catch (e: IOException) {
                e.printStackTrace()
                withContext(Dispatchers.Main) {
                    result.error("SEND_FAILED", e.message, null)
                }
            }
        }
    }

    private fun startReading() {
        readJob?.cancel()
        readJob = CoroutineScope(Dispatchers.IO).launch {
            try {
                val inputStream = btSocket?.inputStream ?: return@launch
                val buffer = ByteArray(256)
                var bytes: Int

                while (true) {
                    bytes = inputStream.read(buffer)
                    val message = String(buffer, 0, bytes)
                    withContext(Dispatchers.Main) {
                        channel.invokeMethod("onDataReceived", message)
                    }
                }
            } catch (e: IOException) {
                e.printStackTrace()
                withContext(Dispatchers.Main) {
                    channel.invokeMethod("onConnectionLost", e.message ?: "Connection lost")
                }
            }
        }
    }

    private fun disconnect() {
        readJob?.cancel()
        try {
            btSocket?.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        disconnect()
    }
}
