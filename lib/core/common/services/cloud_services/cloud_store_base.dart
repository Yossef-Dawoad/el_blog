abstract interface class CloudStoreBase<T> {
  Future<T> saveToCloud(T model);
  Future<T?> updateInCloud(T model);
  Future<List<T>> fetchAllFromCloud();
  Future<T?> fetchFromCloud(String id);
  Future<bool> deleteFromCloud(String id);
  String get collectionPath => '';
}
