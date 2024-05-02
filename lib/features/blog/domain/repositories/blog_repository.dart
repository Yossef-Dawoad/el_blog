import 'dart:io';

import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<BaseFailure, BlogEntity>> uploadBlog({
    required String authorId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  });
  Future<Either<BaseFailure, List<BlogEntity>>> getAllBlogs();
}
