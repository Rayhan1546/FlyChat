class UserModel {
  final String id;
  final String username;
  final DateTime? createdAt;
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
      createdAt: DateTime.parse(
        map['created_at'],
      ),
      profilePictureUrl: map['profile_picture_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'created_at': createdAt?.toIso8601String(),
      'profile_picture_url': profilePictureUrl,
    };
  }
}
