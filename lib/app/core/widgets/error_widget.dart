import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ],
    ));
  }
}
