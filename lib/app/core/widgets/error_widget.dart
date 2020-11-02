import 'package:flutter/material.dart';

const DEFAULT_MESSAGE = 'Something went wrong';

class ErrorWidget extends StatelessWidget {
  final String message;
  const ErrorWidget([this.message]);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      message ?? DEFAULT_MESSAGE,
      style: const TextStyle(
        fontSize: 24,
        color: Colors.black,
      ),
    ));
  }
}
