import 'package:clean_blog/features/blog/data/datasources/remote/blog_remote_source.dart';
import 'package:clean_blog/features/blog/data/models/blog_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'datasource_mock.dart';

void main() {
  late MockCloudStoreBlogImpl mockCloudStoreBlogImpl;
  late MockCloudStorageBlogImpl mockCloudStorageBlogImpl;
  late BlogRemoteSourceImpl blogRemoteSource;

  setUp(() {
    mockCloudStoreBlogImpl = MockCloudStoreBlogImpl();
    mockCloudStorageBlogImpl = MockCloudStorageBlogImpl();
    blogRemoteSource = BlogRemoteSourceImpl(
      mockCloudStoreBlogImpl,
      mockCloudStorageBlogImpl,
    );
  });

  group('BlogRemoteSource - ', () {
    test(
      'given BlogRemoteSource when getAllBlogs Called then a List of BlogModel is returned',
      () async {
        // Act
        when(() => mockCloudStoreBlogImpl.fetchAllFromCloud())
            .thenAnswer((_) async => <BlogModel>[]);
        // Arrange
        final result = await blogRemoteSource.getAllBlogsfromCloud();
        // Assert
        expect(result, isA<List<BlogModel>>());
        verify(() => mockCloudStoreBlogImpl.fetchAllFromCloud()).called(1);
        verifyNoMoreInteractions(mockCloudStoreBlogImpl);
      },
    );
  });
}
