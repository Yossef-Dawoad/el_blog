import 'package:clean_blog/core/common/blocs/app_user/app_user_bloc.dart';
import 'package:clean_blog/core/common/services/cloud_services/cloud_storage_base.dart';
import 'package:clean_blog/core/secrets/supabase_sec.dart';
import 'package:clean_blog/core/utils/network/network_manager.dart';
import 'package:clean_blog/features/auth/data/datasources/remote/auth_datasource.dart';
import 'package:clean_blog/features/auth/data/repositories/authuentication_repo_impl.dart';
import 'package:clean_blog/features/auth/domain/repositories/authuentication_repo.dart';
import 'package:clean_blog/features/auth/domain/usecases/get_current_user.dart';
import 'package:clean_blog/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_blog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:clean_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_blog/features/blog/data/datasources/local/blog_local_source.dart';
import 'package:clean_blog/features/blog/data/datasources/remote/blog_remote_db_store_service.dart';
import 'package:clean_blog/features/blog/data/datasources/remote/blog_remote_source.dart';
import 'package:clean_blog/features/blog/data/datasources/remote/blog_remote_storage_service.dart';
import 'package:clean_blog/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:clean_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_blog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:clean_blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:clean_blog/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;
Future<void> initializeDependancies() async {
  // init supabase client
  final supabase = await Supabase.initialize(
    url: SupaBaseSecrets.SUPABASE_URL,
    anonKey: SupaBaseSecrets.SUPABASE_ANON_KEY,
  );

  // init Hive Box
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  sl.registerLazySingleton(() => Hive.box(name: 'blogs'));

  sl.registerFactory(() => Connectivity());
  sl.registerFactory<NetworkManager>(() => NetworkManagerImpl(sl()));
  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);

  _setupAuthDependancies();
  _setupBlogDependancies();
}

void _setupAuthDependancies() {
  //-------------------//services//-------------------//
  sl.registerLazySingleton(() => AuthenticatedUserBloc());
  //-------------------//dataSources//-------------------//
  sl.registerFactory<RemoteAuthDataSource>(
    () => RemoteAuthDataSourceImpl(),
  );
  //-------------------//repositories//-------------------//
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
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
        appUserBloc: sl()),
  );
}

void _setupBlogDependancies() {
  //-------------------//Services//-------------------//
  sl.registerLazySingleton<CloudBlogStoreDBBase>(
    () => CloudStoreBlogImpl(sl()),
  );
  sl.registerLazySingleton<CloudStorageBase>(
    () => CloudStorageBlogImpl(sl()),
  );
  //-------------------//dataSources//-------------------//
  sl.registerFactory<BlogRemoteSource>(
    () => BlogRemoteSourceImpl(sl(), sl()),
  );
  sl.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(sl()),
  );
  //-------------------//repositories//-------------------//
  sl.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(sl(), sl(), sl()),
  );

  //-------------------//useCases//-------------------//
  sl.registerFactory(() => UploadBlogUseCase(sl()));
  sl.registerFactory(() => GetAllBlogsUseCase(sl()));

//--------------------//Controller//-------------------//
  sl.registerLazySingleton(
    () => BlogBloc(getAllUseUseCase: sl(), uploadUseCase: sl()),
  );
}
