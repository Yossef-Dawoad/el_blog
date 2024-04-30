import 'package:clean_blog/core/secrets/supabase_sec.dart';
import 'package:clean_blog/features/auth/data/datasources/remote/auth_datasource.dart';
import 'package:clean_blog/features/auth/data/repositories/authuentication_repo_impl.dart';
import 'package:clean_blog/features/auth/domain/repositories/authuentication_repo.dart';
import 'package:clean_blog/features/auth/domain/usecases/get_current_user.dart';
import 'package:clean_blog/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_blog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:clean_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;
Future<void> initializeDependancies() async {
  // init supabase client
  final supaBaseClient = await Supabase.initialize(
    url: SupaBaseSecrets.SUPABASE_URL,
    anonKey: SupaBaseSecrets.SUPABASE_ANON_KEY,
  );
  sl.registerLazySingleton<SupabaseClient>(() => supaBaseClient.client);
  _setupAuthDependancies();
}

void _setupAuthDependancies() {
  sl.registerFactory<RemoteAuthDataSource>(
    () => RemoteAuthDataSourceImpl(sl()),
  );
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()));
  //-------------------//useCases//-------------------//
  sl.registerFactory(() => UserSignUpUsecase(sl()));
  sl.registerFactory(() => UserSignInWithPasswordUsecase(sl()));
  sl.registerFactory(() => GetCurrentUser(sl()));
  //--------------------//Controller//-------------------//
  sl.registerLazySingleton(
    () => AuthBloc(
      signUpUsecase: sl(),
      signInWithPasswordUsecase: sl(),
      getCurrentUser: sl(),
    ),
  );
}
