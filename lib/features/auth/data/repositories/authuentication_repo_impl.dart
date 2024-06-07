import 'package:clean_blog/core/common/entities/user_entity.dart';
import 'package:clean_blog/core/errors/exceptions.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/core/utils/logs/logger.dart';
import 'package:clean_blog/core/utils/network/network_manager.dart';
import 'package:clean_blog/features/auth/data/datasources/remote/auth_datasource.dart';
import 'package:clean_blog/features/auth/data/models/user_model.dart';
import 'package:clean_blog/features/auth/domain/repositories/authuentication_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource dataSource;
  final NetworkManager networkManager;
  const AuthRepositoryImpl(this.dataSource, this.networkManager);

  @override
  Future<EitherUser> currentUser() async {
    try {
      bool hasNetwork = await (networkManager.hasInternetAccess);
      if (!hasNetwork) {
        final session = dataSource.currentSession;
        if (session == null) return left(BaseFailure('User not Logged In!'));
        return right(
          UserModel(
            id: session.user.id,
            username: '',
            email: session.user.email ?? '',
          ),
        );
      }
      final user = await dataSource.getCurrentUserData();
      logger.i('The Current User of Data Source', error: user);
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
    return await _errorHandller(
      () async => await dataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<EitherUser> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _errorHandller(
      () async => await dataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<EitherUser> _errorHandller(
    ValueGetter<Future<UserEntity>> func,
  ) async {
    try {
      if (!await (networkManager.hasInternetAccess)) {
        //TODO should we make InterNet Failure
        return left(BaseFailure('No internet connection!'));
      }
      return right(await func());
    } on ServerException catch (e) {
      logger.e('Server exception Error', error: e);
      return left(BaseFailure(e.message));
    }
  }
}
