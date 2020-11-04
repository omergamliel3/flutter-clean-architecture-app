import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        key: const ValueKey('FAB'),
        onPressed: () => BlocProvider.of<ArticlesCubit>(context).getArticles(),
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
