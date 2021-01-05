import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'event.freezed.dart';

@freezed
abstract class ArticlesEvent with _$ArticlesEvent {
  const factory ArticlesEvent.getData() = GetData;
}
