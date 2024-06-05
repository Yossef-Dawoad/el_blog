import 'package:clean_blog/core/utils/logs/logger.dart';

import '../../../../core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    logger.d(json);

    return UserModel(
      id: json['id'] as String,
      username: json['user_metadata']['username'] as String,
      email: json['email'] as String,
    );
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }
}
