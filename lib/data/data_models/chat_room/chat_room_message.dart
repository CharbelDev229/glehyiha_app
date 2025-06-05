
import '../../models/message/chat_message.dart';
import '../../models/message/chat_room_item.dart';
import '../../models/message/chat_room_separated_date.dart';

class GetChatRoomMessageData {
  List<ChatRoomItem>? chatRoomItems;
  int currentPage = 0;
  int lastPage = 0;
  int total = 0;

  GetChatRoomMessageData({this.chatRoomItems});

  // Factory method to get a GetChatRoomMessageData instance from a map
  GetChatRoomMessageData.fromMap(Map<String, dynamic> json) {
    chatRoomItems = <ChatRoomItem>[];
    currentPage = json["current_page"] ?? 0;
    lastPage = json["last_page"] ?? 0;
    total = json["total"] ?? 0;
    // for (var item in json["data"]) {
    //   chatRoomItems?.add(_mapToChatRoomItem(item));
    // }
    for (var item in json["data"]) {
  chatRoomItems?.add(_mapToChatRoomItem(item as Map<String, dynamic>));
}

  }

  

 

  // Method to determine the correct ChatRoomItem type and instantiate it
  ChatRoomItem _mapToChatRoomItem(Map<String, dynamic> data) {
    if (data.containsKey('content')) {
      // This is a ChatRoomMessage
      return ChatMessage.fromMap(data);
    } else if (data.containsKey('date')) {
      // This is a ChatRoomSeparatedDate
      return ChatRoomSeparatedDate.fromMap(data);
    } else {
      throw Exception('Unknown ChatRoomItem type');
    }
  }
}
