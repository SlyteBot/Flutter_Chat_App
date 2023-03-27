import 'package:flutter_project_chat_app/consts/collections_const.dart';

class MessageModel {
  DateTime timeStamp;
  String senderUid;
  String message;
  MessageModel(
      {required this.timeStamp,
      required this.senderUid,
      required this.message});

  firestoreModel() {
    return {
      Messages.message: message,
      Messages.senderUid: senderUid,
      Messages.timeStamp: timeStamp
    };
  }
}
