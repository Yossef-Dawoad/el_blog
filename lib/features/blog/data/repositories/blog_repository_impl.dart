import 'dart:io';

import 'package:clean_blog/core/errors/exceptions.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/blog/data/datasources/remote/blog_remote_soutce.dart';
import 'package:clean_blog/features/blog/data/models/blog_model.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:clean_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<BaseFailure, BlogEntity>> uploadBlog({
    required String authorId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  }) async {
    try {
      final blogId = const Uuid().v4();
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blogId: blogId,
      );
      final blogModel = BlogModel(
        id: blogId,
        authorId: authorId,
        title: title,
        content: content,
        imageUrl: imageUrl,
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final result = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(result);
    } on ServerException catch (e) {
      return left(BaseFailure(e.message));
    }
  }

  @override
  Future<Either<BaseFailure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final result = await blogRemoteDataSource.getAllBlogs();
      return right(result);
    } on ServerException catch (e) {
      return left(BaseFailure(e.message));
    }
  }
}
