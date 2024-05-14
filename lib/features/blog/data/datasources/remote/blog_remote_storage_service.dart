import 'dart:io';

import 'package:clean_blog/core/common/services/cloud_services/cloud_storage_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CloudStorageBlogImpl implements CloudStorageBase {
  final SupabaseClient _client;

  CloudStorageBlogImpl(this._client);

  @override
  String get storagePath => 'blog_images';

  @override
  Future<String> uploadFileToCloud(String fileId, File file) async {
    await _client.storage.from(storagePath).upload(fileId, file);
    return _client.storage.from(storagePath).getPublicUrl(fileId);
  }
}
