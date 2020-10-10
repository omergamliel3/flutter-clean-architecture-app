import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

// ignore: one_member_abstracts
abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}
