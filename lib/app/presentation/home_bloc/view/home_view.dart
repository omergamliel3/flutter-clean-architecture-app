import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getx_hacker_news_api/injector.dart';
import '../controller/index.dart';

import '../../../core/widgets/index.dart' as core_widgets;

import '../widgets/widgets.dart';

class HomeViewBloc extends StatelessWidget {
  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 8.0,
      backgroundColor: Colors.yellow,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.adb,
            color: Colors.black,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(
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
        return state.when(
          initial: () => core_widgets.LoadingWidget(),
          loading: () => core_widgets.LoadingWidget(),
          success: (articles) => ArticlesView(articles: articles),
          error: (failure) => core_widgets.ErrorWidget(failure.message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (_) => Injector.resolve<ArticlesBloc>()..add(const GetData()),
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
