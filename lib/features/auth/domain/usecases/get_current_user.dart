import 'package:clean_blog/core/common/usecase/usecase_base.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/auth/domain/entities/user_entity.dart';
import 'package:clean_blog/features/auth/domain/repositories/authuentication_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements UseCaseBase<User, NoParams> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<BaseFailure, User>> call(NoParams params) async {
    return await repository.currentUser();
  }
}
