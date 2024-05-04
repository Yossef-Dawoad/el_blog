import 'dart:io';

import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';

import 'package:clean_blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'get_all_blogs_test.mocks.dart';

@GenerateNiceMocks([MockSpec<File>()])
import 'upload_blog_test.mocks.dart';

void main() {
  late UploadBlogUseCase uploadBlogUseCase;
  late MockBlogRepository mockBlogRepository;

  provideDummyBuilder<Either<BaseFailure, List<BlogEntity>>>(
    (parent, invocation) => switch (invocation.memberName) {
      #call => const Right(<BlogEntity>[]),
      _ => Left(BaseFailure('')),
    },
  );

  setUp(() {
    mockBlogRepository = MockBlogRepository();
    uploadBlogUseCase = UploadBlogUseCase(mockBlogRepository);
  });

  group('UploadBlogUseCase', () {
    const authorId = 'authorId';
    const title = 'title';
    const content = 'content';
    final image = MockFile();
    const topics = ['topic1', 'topic2'];

    test('should call uploadBlog from repository', () async {
      // Arrange
      when(mockBlogRepository.uploadBlog(
              authorId: authorId,
              title: title,
              content: content,
              image: image,
              topics: topics))
          .thenAnswer((_) async => Right(BlogEntity(
                id: const Uuid().v4(),
                authorId: authorId,
                content: content,
                title: title,
                topics: topics,
                imageUrl: image.path,
                updatedAt: DateTime.now(),
              )));

      // Act
      final result = await uploadBlogUseCase(UploadBlogParams(
          userId: authorId,
          title: title,
          content: content,
          image: image,
          topics: topics));

      // Assert
      expect(result, isA<Right<BaseFailure, BlogEntity>>());
      verify(mockBlogRepository.uploadBlog(
          authorId: authorId,
          title: title,
          content: content,
          image: image,
          topics: topics));
      verifyNoMoreInteractions(mockBlogRepository);
    });

    test('should return BaseFailure when repository throws exception',
        () async {
      // Arrange
      when(mockBlogRepository.uploadBlog(
              authorId: authorId,
              title: title,
              content: content,
              image: image,
              topics: topics))
          .thenThrow(Exception());

      // Act
      final result = await uploadBlogUseCase(UploadBlogParams(
          userId: authorId,
          title: title,
          content: content,
          image: image,
          topics: topics));

      // Assert
      expect(result, isA<Left<BaseFailure, BlogEntity>>());
      verify(mockBlogRepository.uploadBlog(
          authorId: authorId,
          title: title,
          content: content,
          image: image,
          topics: topics));
      verifyNoMoreInteractions(mockBlogRepository);
    });
  });
}
