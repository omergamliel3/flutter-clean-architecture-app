import 'package:flutter_test/flutter_test.dart';
import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:getx_hacker_news_api/app/data/models/articles_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:getx_hacker_news_api/app/data/datasources/articles_remote_datasource.dart';

import 'fake_data.dart';

class HttpClinetMock extends Mock implements http.Client {}

void main() {
  group('api tests -', () {
    HttpClinetMock client;
    setUp(() {
      client = HttpClinetMock();
    });
    test(
        '''when call getArticles with status code 200 should return decoded data map object''',
        () async {
      var remoteDatasource = ArticlesRemoteDatasource(client: client);
      when(client.get(remoteDatasource.endpoint)).thenAnswer(
          (realInvocation) => Future.value(http.Response(fakeData, 200)));
      List<ArticleModel> data;
      var res = await remoteDatasource.getArticles();
      res.fold((failure) => null, (res) => data = res);
      expect(data.length, 2);
    });

    test(
        '''when call getArticles with expection should return failure object with "Someting went wrong message"''',
        () async {
      var remoteDatasource = ArticlesRemoteDatasource(client: client);
      when(client.get(remoteDatasource.endpoint))
          .thenThrow(Exception('http error'));
      List<ArticleModel> data;
      Failure failure;
      var res = await remoteDatasource.getArticles();
      res.fold((fail) => failure = fail, (res) => data = res);
      expect(failure.message, 'Something went wrong');
      expect(data, null);
    });

    test(
        '''when call getArticles with status code other than 200 should return failure object with the response error message''',
        () async {
      final errorMsg = 'bad request';
      var remoteDatasource = ArticlesRemoteDatasource(client: client);
      when(client.get(remoteDatasource.endpoint)).thenAnswer((realInvocation) =>
          Future.value(http.Response('{"message": "$errorMsg"}', 404)));
      List<ArticleModel> data;
      Failure failure;
      var res = await remoteDatasource.getArticles();
      res.fold((fail) => failure = fail, (res) => data = res);
      expect(failure.message, errorMsg);
      expect(data, null);
    });
  });
}
