// floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           try {
//             // Minta permission runtime sebelum akses Bluetooth
//             final status = await Permission.bluetoothConnect.request();
//             if (!status.isGranted) {
//               Get.snackbar("Permission", "Bluetooth permission ditolak");
//               return;
//             }

//             // Ambil daftar device yang sudah paired
//             var devices = await controller.getPairedDevices();

//             if (devices.isEmpty) {
//               Get.snackbar("Info", "Tidak ada device yang sudah dipasangkan");
//               return;
//             }

//             //  Tampilkan bottom sheet list device
//             Get.bottomSheet(
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Pilih Device",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     ...devices.map(
//                       (device) => ListTile(
//                         title: Text(device.name ?? "Unknown"),
//                         subtitle: Text(device.address),
//                         onTap: () {
//                           Get.back(); // Tutup bottom sheet
//                           controller.connectAndSend(
//                             device,
//                           ); // Connect + kirim data
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } catch (e) {
//             Get.snackbar("Error", "Terjadi error: $e");
//             logger.d("error : $e");
//           }
//         },
//         backgroundColor: AppColors.yellow1,
//         child: Obx(
//           () => controller.isConnecting.value
//               ? CircularProgressIndicator(color: Colors.black)
//               : Icon(Icons.send, color: Colors.black),
//         ),
//       ),