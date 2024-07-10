class MessageModel {
  final String? id;
  final String? senderId;
  final String? receiverId;
  final String? content;
  final DateTime? createdAt;
  final String? chatRoomId;

  MessageModel({
    this.id,
    this.senderId,
    required this.receiverId,
    required this.content,
    this.createdAt,
    required this.chatRoomId,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String?,
      senderId: map['sender_id'] as String?,
      receiverId: map['receiver_id'] as String?,
      content: map['content'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      chatRoomId: map['chat_room_id'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
      'chat_room_id': chatRoomId,
    };
  }
}