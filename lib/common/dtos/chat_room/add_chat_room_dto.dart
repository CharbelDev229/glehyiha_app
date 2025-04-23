import 'dart:io';

class AddChatRoomDto{
  final String name;
  final File image;

  AddChatRoomDto({required this.name, required this.image});

  Map<String, String> toMap() => {
    'name': name,
  };
}
