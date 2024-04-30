import 'package:clean_blog/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCaseBase<RetType, Param> {
  Future<Either<BaseFailure, RetType>> call(Param param);
}

class NoParams {}
