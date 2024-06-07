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

    String tryParseUserName(Map<String, dynamic> json) {
      try {
        return json['raw_user_meta_data']['username'] as String;
      } on NoSuchMethodError {
        return json['username'];
      }
    }

    return UserModel(
      id: json['id'] as String,
      username: tryParseUserName(json),
      email: json['email'] ?? '',
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
