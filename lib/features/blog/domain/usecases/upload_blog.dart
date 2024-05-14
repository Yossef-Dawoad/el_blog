import 'dart:io';

import 'package:clean_blog/core/common/usecase/usecase_base.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/blog_entity.dart';

class UploadBlogParams {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}

class UploadBlogUseCase implements UseCaseBase<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUseCase(this.blogRepository);

  @override
  Future<Either<BaseFailure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      authorId: params.userId,
      title: params.title,
      content: params.content,
      image: params.image,
      topics: params.topics,
    );
  }
}
