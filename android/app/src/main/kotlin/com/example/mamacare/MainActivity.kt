package com.example.mamacare

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import android.content.pm.PackageManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.io.OutputStream
import java.util.*
import com.google.gson.Gson


@Suppress("DEPRECATION")
class MainActivity : FlutterActivity() {
    private val channel = "channel/bluetooth"
    private var bluetoothSocket: BluetoothSocket? = null
    private var outputStream: OutputStream? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                when (call.method) {

                    // List paired devices
                    "getPairedDevices" -> {
                        val adapter = BluetoothAdapter.getDefaultAdapter()
                        if (adapter == null) {
                            result.error("UNAVAILABLE", "Bluetooth not supported on this device", null)
                            return@setMethodCallHandler
                        }

                        try {
                            // Check permission for Android 12+
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                                if (context.checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                                    result.error("PERMISSION_DENIED", "Bluetooth permission not granted", null)
                                    return@setMethodCallHandler
                                }
                            }

                            val bondedDevices: Set<BluetoothDevice>? = adapter.bondedDevices
                            val devicesList = bondedDevices?.map { device ->
                                mapOf(
                                    "name" to device.name,
                                    "address" to device.address
                                )
                            } ?: emptyList()

                            result.success(devicesList)
                        } catch (e: SecurityException) {
                            result.error("SECURITY_EXCEPTION", "Permission required to access Bluetooth", e)
                        }
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
//                    "sendData" -> {
//                        val messageMap = call.argument<Map<String, Any>>("message")
//                        if (messageMap != null) {
//                            val gson = Gson()
//                            val jsonString = gson.toJson(messageMap) + "\n"  // send JSON + newline
//                            try {
//                                outputStream?.write(jsonString.toByteArray())
//                                outputStream?.flush()
//                                result.success("Data sent")
//                            } catch (e: IOException) {
//                                result.error("SEND_FAILED", "Failed to send data: ${e.message}", null)
//                            }
//                        } else {
//                            result.error("INVALID_DATA", "Message is null", null)
//                        }
//                    }


                    "sendData" -> {
                        val messageMap = call.argument<Map<String, Any>>("message")
                        if (messageMap != null) {
                            sendJsonData(messageMap) { res ->
                                result.success(res)
                            }
                        } else {
                            result.error("INVALID_DATA", "Message is null", null)
                        }
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
            ?: return "Bluetooth not supported on this device"

        try {
            // Check permission for Android 12+
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                if (context.checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                    return "Permission BLUETOOTH_CONNECT not granted"
                }
            }

            val device: BluetoothDevice = adapter.getRemoteDevice(address)
            val uuid = device.uuids?.firstOrNull()?.uuid
                ?: UUID.fromString("00001101-0000-1000-8000-00805F9B34FB") // Default SPP UUID

            bluetoothSocket = device.createRfcommSocketToServiceRecord(uuid)
            bluetoothSocket?.connect()
            outputStream = bluetoothSocket?.outputStream
            return "Connected to $address"

        } catch (e: SecurityException) {
            e.printStackTrace()
            return "Connection failed: Permission required to access Bluetooth"
        } catch (e: IOException) {
            e.printStackTrace()
            return "Connection failed: ${e.message}"
        }
    }


    private fun sendJsonData(messageMap: Map<String, Any>, resultCallback: (String) -> Unit) {
        Thread {
            try {
                val gson = Gson()
                val jsonString = gson.toJson(messageMap) + "\n"
                outputStream?.write(jsonString.toByteArray())
                outputStream?.flush()
                resultCallback("Data sent")
            } catch (e: IOException) {
                e.printStackTrace()
                resultCallback("Failed to send data: ${e.message}")
            }
        }.start()
    }


//    private fun sendData(data: Data) {
//        try {
//            val gson = Gson()
//            val jsonString = gson.toJson(data) // Convert Data -> JSON
//            outputStream?.write(jsonString.toByteArray()) // Send JSON
//            outputStream?.flush()
//        } catch (e: IOException) {
//            e.printStackTrace()
//        }
//    }

    private fun disconnect() {
        try {
            outputStream?.close()
            bluetoothSocket?.close()
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }
}


