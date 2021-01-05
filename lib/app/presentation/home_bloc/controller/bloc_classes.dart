import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:getx_hacker_news_api/app/domain/entities/article.dart';

part 'bloc_classes.freezed.dart';

@freezed
abstract class ArticlesState with _$ArticlesState {
  const factory ArticlesState.initial() = Initial;
  const factory ArticlesState.loading() = Loading;
  const factory ArticlesState.success(List<Article> articles) = Success;
  const factory ArticlesState.error(Failure failure) = Error;
}

@freezed
abstract class ArticlesEvent with _$ArticlesEvent {
  const factory ArticlesEvent.getData() = GetData;
}
