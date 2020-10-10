import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();
}

class GetData extends ArticlesEvent {
  const GetData();
  @override
  List<Object> get props => [];
}
