// import 'package:flutter_test/flutter_test.dart';
// import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
// import 'package:getx_hacker_news_api/app/data/api/api.dart';
// import 'package:mockito/mockito.dart';

// import 'package:getx_hacker_news_api/app/data/datasources/articles_remote_datasource.dart';

// import 'fake_data.dart';

// class RestClientMock extends Mock implements RestClient {}

// void main() {
//   group('api tests -', () {
//     RestClientMock client;
//     setUp(() {
//       client = RestClientMock();
//     });
//     test(
//         '''when call getArticles with status code 200 should return decoded data map object''',
//         () async {
//       final remoteDatasource = ArticlesRemoteDatasource(client: client);
//       when(client.get(remoteDatasource.endpoint)).thenAnswer(
//           (realInvocation) => Future.value(http.Response(fakeData, 200)));
//       List<ArticleModel> data;
//       final res = await remoteDatasource.getArticles();
//       res.fold((failure) => null, (res) => data = res);
//       expect(data.length, 2);
//     });

//     test(
//         '''when call getArticles with expection should return failure object with "Someting went wrong message"''',
//         () async {
//       final remoteDatasource = ArticlesRemoteDatasource(client: client);
//       when(client.get(remoteDatasource.endpoint))
//           .thenThrow(Exception('http error'));
//       List<ArticleModel> data;
//       Failure failure;
//       final res = await remoteDatasource.getArticles();
//       res.fold((fail) => failure = fail, (res) => data = res);
//       expect(failure.message, 'Something went wrong');
//       expect(data, null);
//     });

//     test(
//         '''when call getArticles with status code other than 200 should return failure object with the response error message''',
//         () async {
//       const errorMsg = 'bad request';
//       final remoteDatasource = ArticlesRemoteDatasource(client: client);
//       when(client.get(remoteDatasource.endpoint)).thenAnswer((realInvocation) =>
//           Future.value(http.Response('{"message": "$errorMsg"}', 404)));
//       List<ArticleModel> data;
//       Failure failure;
//       final res = await remoteDatasource.getArticles();
//       res.fold((fail) => failure = fail, (res) => data = res);
//       expect(failure.message, errorMsg);
//       expect(data, null);
//     });
//   });
// }
