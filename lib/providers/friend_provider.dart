import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/user_model.dart';

class FriendProvider with ChangeNotifier {
  final List<UserModel> _friends = [];
  FriendProvider();

  fetch() {}

  get(int index) {}
}
