import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

class RequestProvider with ChangeNotifier {
  RequestProvider();

  fetch(String userUid) {
    DatabaseService databaseService = DatabaseService();
    databaseService.deleteRequestsAndProcess(userUid);
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

  sendRequest(String uid, String userName, bool delete) async {
    DatabaseService databaseService = DatabaseService();
    var result = await databaseService.sendRequest(uid, userName, delete);
    return result;
  }

  deleteFriendRequest(String uid, String friendUid) async {
    DatabaseService databaseService = DatabaseService();
    await databaseService.deleteFriend(uid, friendUid);
    return await databaseService.sendRequestWithUids(uid, friendUid, true);
  }
}
