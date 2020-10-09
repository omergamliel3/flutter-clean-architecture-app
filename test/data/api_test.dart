import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:getx_hacker_news_api/app/core/models/failure.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:getx_hacker_news_api/app/data/network/api.dart';

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
      var api = Api(client: client);
      when(client.get(api.endpoint)).thenAnswer(
          (realInvocation) => Future.value(http.Response(fakeData, 200)));
      Map<String, dynamic> data;
      var res = await api.getArticles();
      res.fold((failure) => null, (res) => data = res);
      expect(data, json.decode(fakeData));
    });

    test(
        '''when call getArticles with expection should return failure object with 'Someting went wrong message''',
        () async {
      var api = Api(client: client);
      when(client.get(api.endpoint)).thenThrow(Exception('http error'));
      Map<String, dynamic> data;
      Failure failure;
      var res = await api.getArticles();
      res.fold((fail) => failure = fail, (res) => data = res);
      expect(failure.message, 'Something went wrong');
      expect(data, null);
    });

    test(
        '''when call getArticles with status code other than 200 should return failure object with the response error message''',
        () async {
      final errorMsg = 'bad request';
      var api = Api(client: client);
      when(client.get(api.endpoint)).thenAnswer((realInvocation) =>
          Future.value(http.Response('{"message": "$errorMsg"}', 404)));
      Map<String, dynamic> data;
      Failure failure;
      var res = await api.getArticles();
      res.fold((fail) => failure = fail, (res) => data = res);
      expect(failure.message, errorMsg);
      expect(data, null);
    });
  });
}
