// import 'dart:convert';
// import 'dart:io';

// import 'package:aladdin_franchise/src/configs/api.dart';
// import 'package:aladdin_franchise/src/configs/app.dart';
// import 'package:aladdin_franchise/src/core/network/app_exception.dart';
// import 'package:aladdin_franchise/src/core/storages/local.dart';
// import 'package:aladdin_franchise/src/models/device_remote.dart';
// import 'package:aladdin_franchise/src/models/error_log.dart';
// import 'package:aladdin_franchise/src/models/restaurant.dart';
// import 'package:aladdin_franchise/src/utils/app_log.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:collection/collection.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:uuid/uuid.dart';

// import 'package:http/http.dart' as http;

// class FirestoreService {
//   DocumentReference<Map<String, dynamic>> getAppUpdateRef() =>
//       FirebaseFirestore.instance
//           .collection('app')
//           .doc(kDebugMode ? 'test_update' : 'update');
//   CollectionReference<Map<String, dynamic>> getRestaurantConfigsRef() =>
//       FirebaseFirestore.instance.collection('configs');

//   static checkRestaurant(RestaurantModel? restaurant) async {
//     try {
//       final snapshot =
//           await FirebaseFirestore.instance.collection('restaurants').get();
//       if (snapshot.docs.firstWhereOrNull(
//               (element) => element.id == restaurant?.id.toString()) ==
//           null) {
//         await FirebaseFirestore.instance
//             .collection('restaurants')
//             .doc("${restaurant?.id}")
//             .set(
//           {
//             'id': restaurant?.id,
//             'logo': restaurant?.logo,
//             'name': restaurant?.name,
//             'active': true,
//           },
//         );
//         showLog("create new");
//       }
//     } catch (ex) {
//       showLog(ex, flags: 'checkRestaurant');
//     }
//   }

//   static Future<void> checkDevices() async {
//     if (kEnableFirebaseAppWindowOnly == false) {
//       throw AppException.fromMessage("Thiết bị không được hỗ trợ");
//     }
//     try {
//       final snapshot =
//           await FirebaseFirestore.instance.collection('devices').get();
//       // check devices
//       final List<DeviceRemoteModel> devices =
//           snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
//         return DeviceRemoteModel.fromJson(e.data());
//       }).toList();
//       final current = devices.firstWhereOrNull((element) => element.id == '-1');
//       if (current != null) {
//         var token = await FirebaseMessaging.instance.getToken();
//         if (token == null) {
//           throw AppException.fromMessage(
//               "Không lấy được token thiết bị\nVui lòng thử lại!");
//         }
//         final deviceId = LocalStorage.getDeviceId();
//         final device =
//             devices.firstWhereOrNull((element) => element.token == token);
//         final newCurrent = current.value + 1;
//         if (device == null) {
//           // Nếu device chưa có thì tạo mới theo mã thiết bị tiếp theo
//           await FirebaseFirestore.instance
//               .collection('devices')
//               .doc("current")
//               .set(current.copyWith(value: newCurrent).toJson());
//           var newIdDevice = const Uuid().v1();
//           await FirebaseFirestore.instance
//               .collection('devices')
//               .doc(newIdDevice)
//               .set({
//             'id': newIdDevice,
//             'token': token,
//             'value': newCurrent,
//           });
//           await LocalStorage.setDeviceId(newCurrent);
//         } else {
//           // Nếu như device đã có mà thiết bị chưa lưu thì cập nhật trên firebase
//           if (deviceId == null) {
//             await FirebaseFirestore.instance
//                 .collection('devices')
//                 .doc(device.id)
//                 .set(device.copyWith(value: newCurrent).toJson());
//             await LocalStorage.setDeviceId(newCurrent);
//           } else {
//             await LocalStorage.setDeviceId(device.value);
//           }
//         }
//       }
//     } catch (ex) {
//       if (ex is AppException) rethrow;
//       throw AppException(message: ex.toString());
//     }
//   }

//   static Future<void> checkDeviceAppUpdate() async {
//     showLog("checkDeviceAppUpdate", flags: "checkDeviceAppUpdate");
//     try {
//       if (kEnableFirebaseAppWindowOnly == false) return;
//       final deviceAppUpdate = LocalStorage.getDeviceAppUpdate();
//       if (deviceAppUpdate == null || deviceAppUpdate != AppConfig.appVersion) {
//         await FirebaseFirestore.instance.collection('devices_update').add(
//           {
//             "version": AppConfig.appVersion,
//             "make_device_id": LocalStorage.getMakeDeviceId(),
//             "device_id": LocalStorage.getDeviceId(),
//             "time": Timestamp.now(),
//             "restaurant_id": LocalStorage.getKeepRestaurantId(),
//           },
//         );
//         await LocalStorage.setDeviceAppUpdate();
//       }
//     } catch (ex) {
//       //
//     }
//   }
// }
