import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () => BlocProvider.of<ArticlesBloc>(context).add(GetData()),
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
