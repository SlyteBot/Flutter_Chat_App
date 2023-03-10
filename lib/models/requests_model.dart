import '../consts/collections_const.dart';

class RequestModel {
  String senderUid;
  String receiverUid;
  bool accepted;
  bool acknowleged;
  RequestModel(
      {required this.senderUid,
      required this.receiverUid,
      required this.accepted,
      required this.acknowleged});

  firestoreModel() {
    return {
      Requests.senderUid: senderUid,
      Requests.receiverUid: receiverUid,
      Requests.accepted: accepted,
      Requests.acknowleged: acknowleged
    };
  }
}
