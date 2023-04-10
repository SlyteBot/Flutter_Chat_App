import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

class FriendProvider with ChangeNotifier {
  FriendProvider();

  fetch(String userUid) {
    DatabaseService databaseService = DatabaseService();
    databaseService.deleteRequestsAndProcess(userUid);
    return databaseService.getFriendsSnapshot(userUid);
  }

  startChat(String userUid, String friendUid) async {
    DatabaseService databaseService = DatabaseService();
    return await databaseService.createChat(userUid, friendUid);
  }

  Future<String?> getUsernameByUid(String uid) async {
    DatabaseService databaseService = DatabaseService();
    return await databaseService.getUsername(uid);
  }
}
