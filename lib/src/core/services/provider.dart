// import 'dart:io';

// import 'package:aladdin_franchise/src/configs/app.dart';
// import 'package:aladdin_franchise/src/core/services/firestore.dart';
// import 'package:aladdin_franchise/src/models/app_update.dart';
// import 'package:aladdin_franchise/src/models/restaurant_config.dart';
// import 'package:aladdin_franchise/src/utils/app_log.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final appUpdateProvider = StreamProvider.autoDispose<AppUpdateModel?>(
//   (ref) async* {
//     if (kEnableFirebaseAppWindowOnly == false) {
//       throw "Thiết bị không hỗ trợ cập nhật từ máy chủ này!";
//     }
//     showLog("load", flags: 'appUpdateProvider');
//     final appUpdateSnapshots = FirestoreService().getAppUpdateRef().snapshots();
//     await for (final DocumentSnapshot<Map<String, dynamic>> value
//         in appUpdateSnapshots) {
//       if (value.data() == null) {
//         yield null;
//       }
//       yield AppUpdateModel.fromJson(value.data()!);
//     }
//   },
// );

// final restaurantConfigsProvider =
//     StreamProvider.autoDispose<List<RestaurantConfigModel>>(
//   (ref) async* {
//     if (kEnableFirebaseAppWindowOnly == false) {
//       throw "Thiết bị không hỗ trợ lấy dữ liệu từ máy chủ này!";
//     }
//     showLog("load", flags: 'restaurantConfigsProvider');
//     final restaurantsSnapshots = FirestoreService()
//         .getRestaurantConfigsRef()
//         .where("active", isEqualTo: true)
//         .snapshots();

//     await for (final QuerySnapshot<Map<String, dynamic>> value
//         in restaurantsSnapshots) {
//       if (value.docs.isEmpty) {
//         yield [];
//         continue;
//       }
//       final List<RestaurantConfigModel> restaurants = value.docs
//           .map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
//               RestaurantConfigModel.fromJson(e.data()))
//           .toList();
//       // kDebugMode kReleaseMode

//       if (kReleaseMode) {
//         restaurants.removeWhere((element) => element.isLocal ?? false);
//       }
//       //restaurants.removeWhere((element) => (element.active ?? false) == false);
//       yield restaurants;
//     }
//   },
// );
