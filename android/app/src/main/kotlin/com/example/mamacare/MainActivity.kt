package com.example.mamacare

import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.io.OutputStream
import java.util.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.mamacare/bluetooth"
    private var bluetoothSocket: BluetoothSocket? = null
    private var outputStream: OutputStream? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {

                    // List paired devices
                    "getPairedDevices" -> {
                        val adapter = BluetoothAdapter.getDefaultAdapter()
                        if (adapter == null) {
                            result.error("UNAVAILABLE", "Bluetooth not supported on this device", null)
                            return@setMethodCallHandler
                        }

                        val bondedDevices: Set<BluetoothDevice>? = adapter.bondedDevices
                        val devicesList = bondedDevices?.map { device ->
                            mapOf(
                                "name" to device.name,
                                "address" to device.address
                            )
                        } ?: emptyList<Map<String, String>>()

                        result.success(devicesList)
                    }

                    // Connect
                    "connect" -> {
                        val address = call.argument<String>("address")
                        if (address != null) {
                            val connectResult = connectToDevice(address)
                            result.success(connectResult)
                        } else {
                            result.error("INVALID", "No address provided", null)
                        }
                    }

                    // Send data
                    "sendData" -> {
                        val message = call.argument<String>("message")
                        message?.let { sendData(it) }
                        result.success(null)
                    }

                    // Disconnect
                    "disconnect" -> {
                        disconnect()
                        result.success(null)
                    }
                    
                    // scanDevices
                    "scanDevices" -> {
                        val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                        val devices = bluetoothAdapter.bondedDevices.map {
                            mapOf("name" to it.name, "address" to it.address)
                        }
                        result.success(devices)
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun connectToDevice(address: String): String {
        val adapter = BluetoothAdapter.getDefaultAdapter()
        val device: BluetoothDevice = adapter.getRemoteDevice(address)
        val uuid = device.uuids?.firstOrNull()?.uuid ?: UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")

        return try {
            bluetoothSocket = device.createRfcommSocketToServiceRecord(uuid)
            bluetoothSocket?.connect()
            outputStream = bluetoothSocket?.outputStream
            "Connected to $address"
        } catch (e: IOException) {
            e.printStackTrace()
            "Connection failed: ${e.message}"
        }
    }

    private fun sendData(message: String) {
        try {
            outputStream?.write(message.toByteArray())
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }

    private fun disconnect() {
        try {
            outputStream?.close()
            bluetoothSocket?.close()
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }
}
