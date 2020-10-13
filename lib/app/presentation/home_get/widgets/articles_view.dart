import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/article.dart';

import '../../../core/widgets/index.dart' as core_widgets;

import '../../../core/utils/launcher.dart';

class ArticlesView extends StatelessWidget {
  final List<Article> articles;
  final Function fetch;
  const ArticlesView({this.articles, this.fetch});

  Widget buildArticleTile(Article article) {
    var formattedTime =
        DateFormat('dd MMM - HH:mm').format(article.publishedAt);
    return Row(
      children: [
        core_widgets.ImageHandlerWidget(urlToImage: article.urlToImage),
        SizedBox(
          width: 16.0,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formattedTime),
              Text(
                article.title ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    if (articles.length == 0) {
      return core_widgets.ErrorWidget(
        'Can not find articles :(',
      );
    }

    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          await fetch();
        },
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            var article = articles[index];
            return GestureDetector(
              onTap: () => launch(article.url),
              child: Container(
                height: 100,
                child: buildArticleTile(article),
              ),
            );
          },
        ),
      ),
    );
  }
}
