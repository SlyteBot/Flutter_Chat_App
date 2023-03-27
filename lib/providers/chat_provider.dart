import 'package:flutter/foundation.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

class ChatProvider with ChangeNotifier {
  String? chatId;

  setChatId(String chatId) {
    this.chatId = chatId;
  }

  sendMessage(String userUid, String message) {
    DatabaseService databaseService = DatabaseService();
    databaseService.sendMessageToChat(userUid, chatId!, message);
  }
}
