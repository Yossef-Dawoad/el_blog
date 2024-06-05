import 'dart:io';

import 'package:clean_blog/core/common/services/cloud_services/cloud_storage_base.dart';
import 'package:clean_blog/core/errors/exceptions.dart';
import 'package:clean_blog/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'blog_remote_db_store_service.dart';

abstract interface class BlogRemoteSource {
  Future<List<BlogModel>> getAllBlogsfromCloud();
  Future<BlogModel> saveBlogtoCloud(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required String blogId,
  });
}

class BlogRemoteSourceImpl implements BlogRemoteSource {
  // final _client = Supabase.instance.client;
  final CloudBlogStoreDBBase _cloudStoreDBService;
  final CloudStorageBase _cloudStorageService;

  BlogRemoteSourceImpl(this._cloudStoreDBService, this._cloudStorageService);

  @override
  Future<BlogModel> saveBlogtoCloud(BlogModel blog) async {
    try {
      return await _cloudStoreDBService.saveToCloud(blog);
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
      return await _cloudStorageService.uploadFileToCloud(blogId, image);
    } on StorageException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogsfromCloud() async {
    try {
      return await _cloudStoreDBService.fetchAllFromCloud();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
