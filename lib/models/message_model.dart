class MessageModel {
  DateTime timeStamp;
  String senderUid;
  String receiverUid;
  String message;
  MessageModel(
      {required this.timeStamp,
      required this.senderUid,
      required this.receiverUid,
      required this.message});
}
