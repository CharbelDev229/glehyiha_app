import 'dart:convert';

import 'package:glehiha/data/models/message/chat_room_item.dart';

import '../../../common/constants/instances.dart';

class ChatMessage extends ChatRoomItem {
  final int id;
  final String content;
  final int senderId;
  final String updateAt;
  final String? isDeletedAt;
  final String text;
  final bool isUser;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.senderId,
    required this.isDeletedAt,
    required this.updateAt,
    required this.text,
    required this.isUser,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> data) {
    logger.i("ChatRoomMessage.fromMap data['chat_room']: ${data['chat_room']}");
    return ChatMessage(
      id: data['id'] as int,
      content: data['content'] as String,
      senderId: data['sender_id'] as int,
      updateAt: data['update_at'] as String,
      isDeletedAt: data['is_deleted_at'] as String?,
      text: data['text'] as String,
      isUser: data['is_user'] as bool,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'content': content,
        'sender_id': senderId,
        'update_at': updateAt,
        'is_deleted_at': isDeletedAt,
        'text': text,
        'is_user': isUser,
      };

  ChatMessage copyWith({
    int? id,
    String? content,
    int? senderId,
    String? updateAt,
    String? isDeletedAt,
    String? text,
    bool? isUser,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      updateAt: updateAt ?? this.updateAt,
      isDeletedAt: isDeletedAt ?? this.isDeletedAt,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
    );
  }

  factory ChatMessage.fromJson(String data) =>
      ChatMessage.fromMap(json.decode(data) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, content, senderId, updateAt, isDeletedAt, text, isUser];
  }
}
