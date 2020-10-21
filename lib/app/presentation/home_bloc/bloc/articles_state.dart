import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/article.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';

@immutable
abstract class ArticlesState extends Equatable {
  const ArticlesState();
}

class Initial extends ArticlesState {
  const Initial();

  @override
  List<Object> get props => [];
}

class Loading extends ArticlesState {
  const Loading();

  @override
  List<Object> get props => [];
}

class Success extends ArticlesState {
  final List<Article> articles;
  const Success(this.articles);

  @override
  List<Object> get props => [articles];
}

class Error extends ArticlesState {
  final Failure failure;
  const Error(this.failure);

  @override
  List<Object> get props => [failure];
}
