import 'package:getx_hacker_news_api/app/data/api/api.dart';

abstract class ArticlesLocalDatasource {
  Future<bool> initDb();
  Future<bool> deleteDb();
  Future<bool> insertArticles(List<ArticleModel> articles);
  Future<bool> deleteAllArticles();
  Future<List<ArticleModel>> getArticles();
}
