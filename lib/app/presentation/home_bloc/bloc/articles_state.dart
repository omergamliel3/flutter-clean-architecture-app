import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/article.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ArticlesState extends Equatable {
  const ArticlesState();
}

class ArticlesInitial extends ArticlesState {
  const ArticlesInitial();

  @override
  List<Object> get props => [];
}

class ArticlesLoading extends ArticlesState {
  const ArticlesLoading();

  @override
  List<Object> get props => [];
}

class ArticlesSuccess extends ArticlesState {
  final List<Article> articles;
  ArticlesSuccess(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticlesError extends ArticlesState {
  final Failure failure;
  const ArticlesError(this.failure);

  List<Object> get props => [failure];
}
