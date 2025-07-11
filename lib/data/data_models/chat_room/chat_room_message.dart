
import '../../models/message/chat_message.dart';
import '../../models/message/chat_room_item.dart';
import '../../models/message/chat_room_separated_date.dart';

class GetChatRoomMessageData {
  final List<ChatRoomItem>? chatRoomItems;

  GetChatRoomMessageData({
    this.chatRoomItems,
  });

  // Constructeur pour créer un objet vide
  factory GetChatRoomMessageData.empty() {
    return GetChatRoomMessageData(
      chatRoomItems: [],
    );
  }

  // Factory method to get a GetChatRoomMessageData instance from a map
  factory GetChatRoomMessageData.fromMap(Map<String, dynamic> map) {
    final chats = map['chats'] as List<dynamic>?;
    
    if (chats == null || chats.isEmpty) {
      return GetChatRoomMessageData(chatRoomItems: []);
    }
    
    final List<ChatRoomItem> chatRoomItems = [];
    
    for (var item in chats) {
      if (item is Map<String, dynamic>) {
        try {
          chatRoomItems.add(ChatMessage.fromMap(item));
        } catch (e) {
          // Si l'élément ne peut pas être converti en ChatMessage, essayez de le convertir en ChatRoomSeparatedDate
          try {
            if (item.containsKey('date')) {
              chatRoomItems.add(ChatRoomSeparatedDate.fromMap(item));
            }
          } catch (e) {
            // Ignorer les éléments qui ne peuvent pas être convertis
            print('Impossible de convertir l\'élément: $e');
          }
        }
      }
    }
    
    return GetChatRoomMessageData(
      chatRoomItems: chatRoomItems,
    );
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
