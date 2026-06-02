import 'dart:io';

import 'package:get/get.dart';


// class PermissionService extends GetxService {
//   Future<bool> requestCamera() async {
//     final status = await Permission.camera.request();
//     if (status.isGranted) return true;
//     return false;
//   }
//
//   Future<bool> requestGallery() async {
//     if (Platform.isIOS) {
//       final status = await Permission.photos.request();
//       return status.isGranted || status.isLimited;
//     }
//
//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//       final sdk = androidInfo.version.sdkInt;
//
//       if (sdk >= 33) {
//         final status = await Permission.photos.request();
//         return status.isGranted || status.isLimited;
//       }
//
//       final status = await Permission.storage.request();
//       return status.isGranted;
//     }
//
//     return true;
//   }
//
//   Future<void> openSettings() => openAppSettings();
// }

