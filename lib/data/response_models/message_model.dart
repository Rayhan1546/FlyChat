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
      id: map['id'],
      senderId: map['sender_id'],
      receiverId: map['receiver_id'],
      content: map['content'],
      createdAt: DateTime.parse(
        map['created_at'],
      ),
      chatRoomId: map['chat_room_id'],
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
