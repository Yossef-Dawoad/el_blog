import 'package:clean_blog/features/blog/data/datasources/remote/blog_remote_db_store_service.dart';
import 'package:clean_blog/features/blog/data/datasources/remote/blog_remote_storage_service.dart';
import 'package:mocktail/mocktail.dart';

class MockCloudStoreBlogImpl extends Mock implements CloudStoreBlogImpl {}

class MockCloudStorageBlogImpl extends Mock implements CloudStorageBlogImpl {}
