import 'dart:io';

import 'package:clean_blog/core/errors/failure.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';

import 'package:clean_blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import 'usecases_mocks.dart';

void main() {
  late MockBlogRepository mockBlogRepository;
  late UploadBlogUseCase uploadBlogUseCase;

  setUp(() {
    mockBlogRepository = MockBlogRepository();
    uploadBlogUseCase = UploadBlogUseCase(mockBlogRepository);
  });

  group('UploadBlogUseCase', () {
    const authorId = 'authorId';
    const title = 'title';
    const content = 'content';
    final image = File('');
    const topics = ['topic1', 'topic2'];

    final tBlogEntity = BlogEntity(
      id: const Uuid().v4(),
      authorId: authorId,
      content: content,
      title: title,
      topics: topics,
      imageUrl: image.path,
      updatedAt: DateTime.now(),
    );

    test('should call uploadBlog from repository', () async {
      // Arrange
      when(
        () => mockBlogRepository.uploadBlog(
            authorId: authorId,
            title: title,
            content: content,
            image: image,
            topics: topics),
      ).thenAnswer((_) async => Right(tBlogEntity));

      // Act
      final result = await uploadBlogUseCase(
        UploadBlogParams(
            userId: authorId,
            title: title,
            content: content,
            image: image,
            topics: topics),
      );

      // Assert
      expect(result, isA<Right<BaseFailure, BlogEntity>>());
      verify(
        () => mockBlogRepository.uploadBlog(
            authorId: authorId,
            title: title,
            content: content,
            image: image,
            topics: topics),
      );
      verifyNoMoreInteractions(mockBlogRepository);
    });

    test('should return BaseFailure when repository throws exception',
        () async {
      // Arrange
      when(() => mockBlogRepository.uploadBlog(
          authorId: authorId,
          title: title,
          content: content,
          image: image,
          topics: topics)).thenThrow(Exception());

      // Act
      final result = await uploadBlogUseCase(UploadBlogParams(
          userId: authorId,
          title: title,
          content: content,
          image: image,
          topics: topics));

      // Assert
      expect(result, isA<Left<BaseFailure, BlogEntity>>());
      verify(() => mockBlogRepository.uploadBlog(
          authorId: authorId,
          title: title,
          content: content,
          image: image,
          topics: topics));
      verifyNoMoreInteractions(mockBlogRepository);
    });
  });
}
