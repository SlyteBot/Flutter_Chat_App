class MessageModel {
  String id;
  DateTime timeStamp;
  String senderUid;
  String receiverUid;
  String message;
  MessageModel(
      {required this.id,
      required this.timeStamp,
      required this.senderUid,
      required this.receiverUid,
      required this.message});
}
