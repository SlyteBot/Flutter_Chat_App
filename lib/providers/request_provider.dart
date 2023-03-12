import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

class RequestProvider with ChangeNotifier {
  RequestProvider();

  fetch(String userUid) {
    DatabaseService databaseService = DatabaseService();
    return databaseService.getRequestNotAcknowlgedSnapShot(userUid);
  }

  acceptRequest(RequestModel request) {
    request.acceptedRequest();
    request.acknowlegedRequest();
    DatabaseService databaseService = DatabaseService();
    databaseService.updateRequest(request);
    databaseService.addFriend(request.receiverUid, request.senderUid);
  }

  denyRequest(RequestModel request) {
    request.acknowlegedRequest();
    DatabaseService databaseService = DatabaseService();
    databaseService.updateRequest(request);
  }

  sendRequest(String uid, String userName) async {
    DatabaseService databaseService = DatabaseService();
    var result = await databaseService.sendRequest(uid, userName);
    return result;
  }
}
