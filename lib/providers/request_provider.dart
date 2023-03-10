import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

class RequestProvider with ChangeNotifier {
  final List<RequestModel> _requests = [];

  RequestProvider();

  fetch() {}

  get(int index) {}

  sendRequest(String uid, String userName) async {
    DatabaseService databaseService = DatabaseService();
    var result = await databaseService.sendRequest(uid, userName);
    return result;
  }
}
