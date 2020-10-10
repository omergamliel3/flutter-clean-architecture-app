import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final Widget actionWidget;
  CustomAppBar({this.actionWidget});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 8.0,
      backgroundColor: Colors.yellow,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.adb,
            color: Colors.black,
          ),
          const SizedBox(
            width: 6.0,
          ),
          const Text(
            'NewsReader',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ).paddingAll(4.0),
      actions: [actionWidget.paddingOnly(right: 10.0)],
    );
  }
}
