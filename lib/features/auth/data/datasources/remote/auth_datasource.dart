import 'package:clean_blog/core/errors/exceptions.dart';
import 'package:clean_blog/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class RemoteAuthDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
  Session? get currentSession;
}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final SupabaseClient client;
  RemoteAuthDataSourceImpl(this.client);

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentSession == null) return null;
      final userData = await client
          .from('profiles')
          .select('*')
          .eq('id', currentSession!.user.id);
      return UserModel.fromJson(userData.first)
          .copyWith(email: currentSession!.user.email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) throw ServerException(message: 'User is Null');

      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentSession!.user.email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        password: password,
        email: email,
        data: {'username': name},
      );
      if (response.user == null) throw ServerException(message: 'User is Null');
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentSession!.user.email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Session? get currentSession => client.auth.currentSession;
}
