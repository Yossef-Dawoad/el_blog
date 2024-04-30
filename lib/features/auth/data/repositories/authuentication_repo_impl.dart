import 'package:clean_blog/core/errors/exceptions.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/auth/data/datasources/remote/auth_datasource.dart';
import 'package:clean_blog/features/auth/domain/repositories/authuentication_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource dataSource;
  const AuthRepositoryImpl(this.dataSource);

  @override
  Future<EitherUser> currentUser() async {
    try {
      final user = await dataSource.getCurrentUserData();
      if (user == null) return left(BaseFailure('No user found'));
      return right(user);
    } catch (e) {
      return left(BaseFailure(e.toString()));
    }
  }

  @override
  Future<EitherUser> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await dataSource.loginWithEmailPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(BaseFailure(e.message));
    }
  }

  @override
  Future<EitherUser> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await dataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(BaseFailure(e.message));
    }
  }
}
