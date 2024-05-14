import 'dart:convert';

import 'package:clean_blog/features/blog/data/models/blog_model.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils/read_reader.dart';

void main() {
  late Map<String, dynamic> jsonMap;
  setUp(() {
    jsonMap = json.decode(readJsonFile('features/blog/utils/dummy_data.json'));
  });
  final testBlogModel = BlogModel(
    id: "1",
    authorId: "001",
    title: "Dart is Actualy A Really Nice Language",
    content: "blah blah blah",
    imageUrl: "image/url/path",
    topics: ["programming", "flutter"],
    updatedAt: DateTime.parse('2024-05-04T02:38:46.609924'),
    author: "ali Ahmed",
  );

  test('BlogModel should be a subclass of BlogEntity', () {
    // assert
    expect(testBlogModel, isA<BlogEntity>());
  });

  group('Vaildate BlogModel Serializarion/DeSerializarion', () {
    test('Should decode Json and return A valid Model', () async {
      // act
      final result = BlogModel.fromMap(jsonMap);
      // expect
      expect(result, equals(testBlogModel));
    });

    test('Should return A valid Json from A valid Model', () async {
      // act
      final result = testBlogModel.toMap();
      // expect
      expect(result, equals(jsonMap));
    });
  });
}
