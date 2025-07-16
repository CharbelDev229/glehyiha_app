import 'dart:convert';
import 'chat_room_item.dart';

class ChatMessage implements ChatRoomItem {
  final int id;
  final int userId;
  final String message;
  final DateTime createdAt;
  final String? reply;
  final String? imagePath;
  final bool isUser;

  const ChatMessage({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
    this.reply,
    this.imagePath,
    required this.isUser,
  });
  
  @override
  List<Object?> get props => [
    id,
    userId,
    message,
    createdAt,
    reply,
    imagePath,
    isUser,
  ];
  
  @override
  bool get stringify => true;

  /// Pour l'historique (GET)
  factory ChatMessage.fromMap(Map<String, dynamic> data) {
    return ChatMessage(
      id: data['id'] as int,
      userId: data['user_id'] as int,
      message: data['message'] as String,
      createdAt: DateTime.parse(data['created_at'] as String),
      reply: data['reply'] as String?, // Peut être null
      imagePath: data['image_path'] as String?, // Peut être null
      isUser: data['is_user'] as bool? ?? false,
    );
  }

  /// Pour la réponse du bot (POST)
  factory ChatMessage.fromBotReply(Map<String, dynamic> data) {
    return ChatMessage(
      id: data['id'] ?? 0,
      userId: data['user_id'] ?? 0,
      message: data['message'] ?? '',
      createdAt: DateTime.now(),
      reply: data['reply'] as String?,
      imagePath: data['image_path'] as String?,
      isUser: false,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'message': message,
        'created_at': createdAt.toIso8601String(),
        'is_user': isUser,
        if (reply != null) 'reply': reply,
        if (imagePath != null) 'image_path': imagePath,
      };

  factory ChatMessage.fromJson(String data) =>
      ChatMessage.fromMap(json.decode(data) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}
