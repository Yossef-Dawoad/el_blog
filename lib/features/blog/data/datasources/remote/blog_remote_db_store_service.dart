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
    // get all blogs, for each blog fetch it's profile username
    final blogs = await _client.from(collectionPath).select('*, profiles (username)');
    return blogs
        .map((blog) => BlogModel.fromMap(blog).copyWith(author: blog['profiles']['username']))
        .toList();
  }

  @override
  Future<BlogModel> saveToCloud(BlogModel model) async {
    final blogData = await _client.from(collectionPath).insert(model.toMap()).select();
    return BlogModel.fromMap(blogData.first);
  }

  @override
  Future<bool> deleteFromCloud(String id) async {
    final response = await _client.from(collectionPath).delete().match({'id': id});
    //TODO CHeck on this Not Sure if it has .error property
    if (response.error == null) return true;
    return false;
  }

  @override
  Future<BlogModel?> fetchFromCloud(String id) async {
    // filter blogs table based on the id and return Single row
    // Note if Data ever retun more than one row throw EXCEPTION
    final data = await _client.from(collectionPath).select('id').eq('id', id).maybeSingle();
    if (data != null) return BlogModel.fromMap(data);
    return null;
  }

  @override
  Future<BlogModel?> updateInCloud(BlogModel model) async {
    final data = await _client.from(collectionPath).update(model.toMap()).select().maybeSingle();
    if (data != null) return BlogModel.fromMap(data);
    return null;
  }
}
