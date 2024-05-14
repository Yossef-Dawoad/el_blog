import 'package:clean_blog/core/common/usecase/usecase_base.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/core/common/entities/user_entity.dart';
import 'package:clean_blog/features/auth/domain/repositories/authuentication_repo.dart';
import 'package:fpdart/fpdart.dart';

class SignInUserParams {
  final String email;
  final String password;

  SignInUserParams({
    required this.email,
    required this.password,
  });
}

class UserSignInWithPasswordUsecase
    implements UseCaseBase<UserEntity, SignInUserParams> {
  final AuthRepository repository;

  UserSignInWithPasswordUsecase(this.repository);
  @override
  Future<Either<BaseFailure, UserEntity>> call(SignInUserParams params) async {
    return await repository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}
