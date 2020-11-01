import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/article.dart';

import '../../../core/widgets/index.dart' as core_widgets;
import '../../../core/utils/launcher.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';

class ArticlesView extends StatelessWidget {
  final List<Article> articles;
  const ArticlesView({@required this.articles});

  Widget buildArticleTile(Article article) {
    final formattedTime =
        DateFormat('dd MMM - HH:mm').format(article.publishedAt);
    return Row(
      children: [
        core_widgets.ImageHandlerWidget(
          urlToImage: article.urlToImage,
        ),
        const SizedBox(
          width: 16.0,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formattedTime ?? ''),
              Text(
                article.title ?? '',
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                article.content ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    ).paddingAll(5.0);
  }

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const core_widgets.ErrorWidget(
        'Can not find articles :(',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ArticlesCubit>(context).getArticles();
      },
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () => launch(article.url),
            child: Container(
              height: 100,
              child: buildArticleTile(article),
            ),
          );
        },
      ),
    );
  }
}
