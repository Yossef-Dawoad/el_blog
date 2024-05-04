import 'dart:io';

abstract interface class CloudStorageBase {
  Future<String> uploadToCloud(String fileId, File file);
  // Future<bool> downloadFromCloud(String fileId, String localPath);

  String get storagePath => '';
}
