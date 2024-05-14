import 'dart:io';

import 'package:clean_blog/core/errors/exceptions.dart';
import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/core/utils/network/network_manager.dart';
import 'package:clean_blog/features/blog/data/datasources/local/blog_local_source.dart';
import 'package:clean_blog/features/blog/data/datasources/remote/blog_remote_source.dart';
import 'package:clean_blog/features/blog/data/models/blog_model.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:clean_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final NetworkManager networkManager;
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.networkManager,
  );

  @override
  Future<Either<BaseFailure, BlogEntity>> uploadBlog({
    required String authorId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  }) async {
    try {
      if (!await (networkManager.hasInternetAccess)) {
        return left(BaseFailure('No internet connection'));
      }
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
      final result = await blogRemoteDataSource.saveBlogtoCloud(blogModel);
      return right(result);
    } on ServerException catch (e) {
      return left(BaseFailure(e.message));
    }
  }

  @override
  Future<Either<BaseFailure, List<BlogEntity>>> getAllBlogs() async {
    try {
      if (!await (networkManager.hasInternetAccess)) {
        final blogs = await blogLocalDataSource.getBlogsfromStorage();
        if (blogs.isNotEmpty) return right(blogs);
        return left(BaseFailure('No internet connection'));
      }
      final result = await blogRemoteDataSource.getAllBlogsfromCloud();
      await blogLocalDataSource.saveBlogtoStorage(result);
      return right(result);
    } on ServerException catch (e) {
      return left(BaseFailure(e.message));
    }
  }
}
