import '../consts/collections_const.dart';

class FriendListModel {
  String uid;
  Map<String, bool> friendList;

  FriendListModel({required this.uid, required this.friendList});

  firestoreModel() {
    return {Friends.currentUid: uid, Friends.friendList: friendList};
  }
}
