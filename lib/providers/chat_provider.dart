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

  deleteMessage(String chatId, String messageId) {
    DatabaseService databaseService = DatabaseService();
    databaseService.deleteMessageFromChat(chatId, messageId);
  }

  deleteChat(String chatId, String uid) {
    DatabaseService databaseService = DatabaseService();
    databaseService.deleteMemberFromChat(chatId, uid);
  }

  getChatStream(String chatId) {
    DatabaseService databaseService = DatabaseService();
    return databaseService.getChatStream(chatId);
  }

  getUsersChatStream(String uid) {
    DatabaseService databaseService = DatabaseService();
    databaseService.deleteRequestsAndProcess(uid);
    return databaseService.getUsersChat(uid);
  }

  Future<String?> getUsernameByUid(String uid) async {
    DatabaseService databaseService = DatabaseService();
    return await databaseService.getUsername(uid);
  }

  Future<String> getChatName(String chatId, String uid) async {
    DatabaseService databaseService = DatabaseService();
    return await databaseService.getChatName(chatId, uid);
  }
}
