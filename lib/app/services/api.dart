import 'dart:math';

import 'package:dartz/dartz.dart';

class Api {
  final endpoint = '';
  Future<Either<Failure, List<String>>> fetchArticles() async {
    await Future.delayed(Duration(seconds: 2));
    var random = Random();
    var generatedData =
        List.generate(random.nextInt(10), (index) => 'Article ${index + 1}');
    if (generatedData.length < 5) {
      return Left(Failure('some api error'));
    }
    return Right(generatedData);
  }
}

class Failure {
  Failure(this.text);
  final String text;
  @override
  String toString() {
    return '$text';
  }
}
