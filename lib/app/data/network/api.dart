import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../core/models/failure.dart';
import '../../../private/keys.dart';

class Api {
  final Client client;
  Api({@required this.client});
  // api endpoint
  final String endpoint =
      'https://newsapi.org/v2/top-headlines?language=en&pageSize=100&apiKey=$newsApiKey';
  final errorMsg = 'Something went wrong';

  /// get articles from api endpoint
  /// return Failure if catch error or status code is not 200
  /// return decoded data as Map if status code is 200
  Future<Either<Failure, Map<String, dynamic>>> getArticles() async {
    try {
      var response = await client.get(endpoint);
      if (response.statusCode != 200) {
        var error = json.decode(response.body)['message'] as String ?? errorMsg;
        return Left(Failure(error));
      }
      var data = json.decode(response.body) as Map<String, dynamic>;
      return Right(data);
    } on Exception catch (_) {
      return Left(Failure(errorMsg));
    }
  }
}
