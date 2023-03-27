import 'package:flutter_project_chat_app/consts/collections_const.dart';

class ChatModel {
  List<String> members;
  String name;
  ChatModel({required this.members, required this.name});

  firestoreModel() {
    return {Chats.members: members};
  }
}
