import 'package:intl/intl.dart';

class UserModel {
  final String id;
  final String username;
  final String createdAt;
  final String profilePictureUrl;

  UserModel({
    required this.createdAt,
    required this.profilePictureUrl,
    required this.id,
    required this.username,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      createdAt: map['created_at'],
      profilePictureUrl: map['profile_picture_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'created_at': DateFormat('yMMMd').format(createdAt as DateTime),
      'profile_picture_url': profilePictureUrl,
    };
  }
}
