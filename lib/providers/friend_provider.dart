import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

class FriendProvider with ChangeNotifier {
  FriendProvider();

  fetch(String userUid) {
    DatabaseService databaseService = DatabaseService();
    databaseService.deleteRequestsAndAddFriends(userUid);
    return databaseService.getFriendsSnapshot(userUid);
  }

  deleteFriend(String userUid, String friendUid) {}

  startChat(String userUid, String friendUid) async {
    DatabaseService databaseService = DatabaseService();
    return await databaseService.createChat(userUid, friendUid);
  }
}
