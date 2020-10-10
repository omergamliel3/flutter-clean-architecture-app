import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final VoidCallback callback;
  const FAB({this.callback});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: callback,
        backgroundColor: Colors.amber,
        icon: const Icon(
          Icons.refresh,
          color: Colors.black,
        ),
        label: const Text(
          'REFRESH',
          style: TextStyle(color: Colors.black),
        ));
  }
}
