import 'package:clean_blog/core/common/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:clean_blog/core/errors/failure.dart';

typedef EitherUser = Either<BaseFailure, UserEntity>;

abstract interface class AuthRepository {
  Future<EitherUser> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<EitherUser> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<EitherUser> currentUser();
}
