class ChatRoom {
  final String id;
  final List<String> users;
  late final Message lastMessage;

  ChatRoom({
    required this.id,
    required this.users,
    required this.lastMessage,
  });
}

class Message {
  final String chatRoomId;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime createdAt;

  Message({
    required this.chatRoomId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      chatRoomId: json['chat_room_id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
