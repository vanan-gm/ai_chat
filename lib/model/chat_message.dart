class ChatMessage {
  final String id;
  final int createdAt;
  final String chatMessage;
  final UserType userType;
  ChatMessage({
    this.id = '',
    this.createdAt = 0,
    this.chatMessage = '',
    this.userType = UserType.ai,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? '',
      createdAt: json['created'] ?? 0,
      chatMessage: json['choices'].first['message']['content'] ?? '',
      userType: UserType.ai,
    );
  }
}

enum UserType { ai, user }
