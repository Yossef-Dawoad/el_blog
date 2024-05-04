import 'package:clean_blog/core/common/services/cloud_services/cloud_store_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/blog_model.dart';

typedef CloudBlogStoreDBBase = CloudStoreBase<BlogModel>;

class CloudStoreBlogImpl implements CloudBlogStoreDBBase {
  final SupabaseClient _client;

  CloudStoreBlogImpl(this._client);

  @override
  String get collectionPath => 'blogs';

  @override
  Future<List<BlogModel>> fetchAllFromCloud() async {
    final blogs =
        await _client.from(collectionPath).select('*, profiles (username)');
    return blogs
        .map((blog) => BlogModel.fromMap(blog)
            .copyWith(author: blog['profiles']['username']))
        .toList();
  }

  @override
  Future<BlogModel> saveToCloud(BlogModel model) async {
    final blogData =
        await _client.from(collectionPath).insert(model.toMap()).select();
    return BlogModel.fromMap(blogData.first);
  }

  @override
  Future<bool> deleteFromCloud(String id) {
    // TODO: implement deleteFromCloud
    throw UnimplementedError();
  }

  @override
  Future<BlogModel> fetchFromCloud(String id) {
    // TODO: implement fetchFromCloud
    throw UnimplementedError();
  }

  @override
  Future<BlogModel> updateInCloud(BlogModel model) {
    // TODO: implement updateInCloud
    throw UnimplementedError();
  }
}
