import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';

import '../../../core/widgets/index.dart' as core_widgets;

import '../widgets/widgets.dart';

class HomeViewBloc extends StatelessWidget {
  Widget appBar() {
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
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {
        if (state is Initial) {
          return core_widgets.LoadingWidget();
        }
        if (state is Loading) {
          return core_widgets.LoadingWidget();
        }
        if (state is Error) {
          return core_widgets.ErrorWidget(state.failure.message);
        }
        if (state is Success) {
          return ArticlesView(articles: state.articles);
        }
        // default widget
        return core_widgets.ErrorWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (_) => Get.find<ArticlesBloc>()..add(GetData()),
        child: Scaffold(
          backgroundColor: Colors.yellow,
          appBar: appBar(),
          body: buildBody(context),
          floatingActionButton: FAB(),
        ),
      ),
    );
  }
}
