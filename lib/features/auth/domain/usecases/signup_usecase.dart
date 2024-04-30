import 'package:clean_blog/core/common/usecase/usecase_base.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/auth/domain/entities/user_entity.dart';
import 'package:clean_blog/features/auth/domain/repositories/authuentication_repo.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUserParams {
  final String name;
  final String email;
  final String password;

  SignUpUserParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

class UserSignUpUsecase implements UseCaseBase<User, SignUpUserParams> {
  final AuthRepository repository;

  UserSignUpUsecase(this.repository);
  @override
  Future<Either<BaseFailure, User>> call(SignUpUserParams params) async {
    return await repository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}
