import 'package:clean_blog/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:clean_blog/core/errors/failure.dart';

typedef EitherUser = Either<BaseFailure, User>;

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
