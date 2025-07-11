import 'dart:convert';

import 'package:glehiha/data/models/message/chat_room_item.dart';

class ChatMessage extends ChatRoomItem {
  final int id;
  final int userId;
  final String message;
  final DateTime createdAt;
  final String? reply; 
  final String? imagePath; 

  const ChatMessage({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
    this.reply,
    this.imagePath, // Nouveau paramètre
  });

  /// Pour l'historique (GET)
  factory ChatMessage.fromMap(Map<String, dynamic> data) {
    return ChatMessage(
      id: data['id'] as int,
      userId: data['user_id'] as int,
      message: data['message'] as String,
      createdAt: DateTime.parse(data['created_at'] as String),
      reply: data['reply'] as String?, // Peut être null
      imagePath: data['image_path'] as String?, // Peut être null
    );
  }

  /// Pour la réponse du bot (POST)
  factory ChatMessage.fromBotReply(Map<String, dynamic> data) {
    return ChatMessage(
      id: 0,
      userId: 0,
      message: '',
      imagePath: data['image_path'] as String?, // Peut être null
      createdAt: DateTime.now(),
      reply: data['reply'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'message': message,
        'created_at': createdAt,
        if (reply != null) 'reply': reply,
      };

  ChatMessage copyWith({
    int? id,
    int? userId,
    String? message,
    DateTime? createdAt,
    String? reply,
    String? imagePath,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      reply: reply ?? this.reply,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  factory ChatMessage.fromJson(String data) =>
      ChatMessage.fromMap(json.decode(data) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, userId, message, createdAt, reply, imagePath];
  }
}
