import 'dart:io';

import 'package:clean_blog/core/errors/exceptions.dart';
import 'package:clean_blog/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<List<BlogModel>> getAllBlogs();
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required String blogId,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  // final _client = Supabase.instance.client;
  final SupabaseClient _client;

  BlogRemoteDataSourceImpl(this._client);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await _client.from('blogs').insert(blog.toMap()).select();
      return BlogModel.fromMap(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required String blogId,
  }) async {
    try {
      await _client.storage.from('blog_images').upload(blogId, image);
      return _client.storage.from('blog_images').getPublicUrl(blogId);
    } on StorageException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await _client.from('blogs').select('*, profiles (username)');
      return blogs
          .map((blog) => BlogModel.fromMap(blog)
              .copyWith(author: blog['profiles']['username']))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
