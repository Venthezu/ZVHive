class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String content;
  final String? attachment;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.attachment,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      chatId: json['chat_id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      content: json['content'],
      attachment: json['attachment'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Chat {
  final String id;
  final String user1Id;
  final String user2Id;
  final Message? lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chat({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      user1Id: json['user1_id'],
      user2Id: json['user2_id'],
      lastMessage: json['last_message'] != null ? Message.fromJson(json['last_message']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}