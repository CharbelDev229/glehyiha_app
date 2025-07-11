
import 'dart:convert';

import '../message/chat_room_item.dart';

class ChatRoomSeparatedDate extends ChatRoomItem {
  final String date;

  const ChatRoomSeparatedDate({required this.date});

  factory ChatRoomSeparatedDate.fromMap(Map<String, dynamic> map) {
    return ChatRoomSeparatedDate(date: map['date']);
  }

  Map<String, dynamic> toMap(){
    return {
      'date': date
    };
  }

  // Factory method to create a ChatRoomSeparatedDate instance from a JSON string
  factory ChatRoomSeparatedDate.fromJson(String data) {
    return ChatRoomSeparatedDate.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  // Method to convert a ChatRoomSeparatedDate instance to a JSON string
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
 
  List<Object?> get props => [
        date,
      ];
}


