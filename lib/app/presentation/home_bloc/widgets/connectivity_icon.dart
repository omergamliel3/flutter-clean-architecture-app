// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import 'package:get/get.dart';
// import 'package:connectivity/connectivity.dart';

// class ConnectivityIcon extends StatelessWidget {
//   final HomeController controller;
//   const ConnectivityIcon({@required this.controller});
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       switch (controller.connectvityResult.value) {
//         case ConnectivityResult.none:
//           return const Icon(
//             Icons.signal_wifi_off,
//             color: Colors.black,
//           );
//           break;
//         case ConnectivityResult.mobile:
//           return const Icon(
//             Icons.network_cell,
//             color: Colors.black,
//           );
//         case ConnectivityResult.wifi:
//           return const Icon(
//             Icons.wifi,
//             color: Colors.black,
//           );
//         default:
//           return Container();
//       }
//     });
//   }
// }
