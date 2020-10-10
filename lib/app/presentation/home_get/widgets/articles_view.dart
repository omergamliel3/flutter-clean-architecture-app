import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../domain/entities/article.dart';

import '../../../core/widgets/index.dart' as core_widgets;

import '../../../core/utils/launcher.dart';

class ArticlesView extends StatelessWidget {
  final List<Article> articles;
  final Function fetch;
  const ArticlesView({this.articles, this.fetch});

  @override
  Widget build(BuildContext context) {
    if (articles.length == 0) {
      return core_widgets.ErrorWidget(
        'Can not find articles :(',
      );
    }

    var targetHeight = Get.mediaQuery.size.height * 0.3;
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
                width: Get.mediaQuery.size.width,
                child: Card(
                  elevation: 4.0,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      article.urlToImage != null
                          ? core_widgets.ImageHandlerWidget(
                              url: article.urlToImage,
                              targetHeight: targetHeight)
                          : core_widgets.AssetImageWidget(
                              targetHeight: targetHeight,
                            ),
                      Text(
                        article.title ?? '',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ).paddingAll(4.0),
                      Text(
                        article.content ?? '',
                        style: TextStyle(fontSize: 18),
                      ).paddingAll(4.0),
                    ],
                  )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
