import 'package:clean_blog/core/common/usecase/usecase_base.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:clean_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUseCase implements UseCaseBase<List<BlogEntity>, NoParams> {
  final BlogRepository _repository;

  GetAllBlogsUseCase(this._repository);

  @override
  Future<Either<BaseFailure, List<BlogEntity>>> call(NoParams params) async {
    return await _repository.getAllBlogs();
  }
}
