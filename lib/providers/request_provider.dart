import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

class RequestProvider with ChangeNotifier {
  RequestProvider();

  fetch(String uid) {
    DatabaseService databaseService = DatabaseService();
    return databaseService.getRequestNotAcknowlgedSnapShot(uid);
  }

  get(int index) {}

  sendRequest(String uid, String userName) async {
    DatabaseService databaseService = DatabaseService();
    var result = await databaseService.sendRequest(uid, userName);
    return result;
  }
}
