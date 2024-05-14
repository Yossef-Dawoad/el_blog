import 'dart:convert';

import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/foundation.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.authorId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.author,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'author_id': authorId,
        'author': author,
        'title': title,
        'content': content,
        'image_url': imageUrl,
        'topics': topics,
        'updated_at': updatedAt.toIso8601String(),
      };

  factory BlogModel.fromMap(Map<String, dynamic> map) => BlogModel(
        id: map['id'] as String,
        authorId: map['author_id'] as String,
        author: map['author'] ?? '',
        title: map['title'] as String,
        content: map['content'] as String,
        imageUrl: map['image_url'] as String,
        topics: List<String>.from(map['topics'] ?? []),
        updatedAt: DateTime.tryParse(map['updated_at']) ?? DateTime.now(),
      );

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  BlogModel copyWith({
    String? id,
    String? authorId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? author,
  }) {
    return BlogModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
    );
  }

  @override
  bool operator ==(covariant BlogEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.authorId == authorId &&
        other.title == title &&
        other.content == content &&
        other.imageUrl == imageUrl &&
        listEquals(other.topics, topics) &&
        other.updatedAt == updatedAt &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        authorId.hashCode ^
        title.hashCode ^
        content.hashCode ^
        imageUrl.hashCode ^
        topics.hashCode ^
        updatedAt.hashCode ^
        author.hashCode;
  }
}
