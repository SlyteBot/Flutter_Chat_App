import 'package:flutter_project_chat_app/consts/collections_const.dart';

class ChatModel {
  List<String> members;
  String name;
  bool isDM;
  ChatModel({required this.members, required this.name, required this.isDM});

  firestoreModel() {
    return {Chats.name: name, Chats.members: members, Chats.isDM: isDM};
  }
}
