import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_chat_app/consts/collections_const.dart';
import 'package:flutter_project_chat_app/models/friendlist_model.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/models/user_model.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  addUser(String uid, String userName, String email) async {
    final user =
        UserModel(uid: uid, userName: userName, email: email).firestoreModel();
    final friendList =
        FriendListModel(uid: uid, friendList: {}).firestoreModel();
    await db.collection(Users.collectionName).add(user);
    await db.collection(Friends.collectionName).add(friendList);
  }

  Future<bool> doesUserExist(String userName) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.userName, isEqualTo: userName);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<String?> getUID(String userName) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.userName, isEqualTo: userName);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return null;
    }
    final user = querySnapshot.docs[0];
    return user.get(Users.uid);
  }

  Future<String?> getUsername(String uid) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.uid, isEqualTo: uid);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return null;
    }
    final user = querySnapshot.docs[0];
    return user.get(Users.userName);
  }

  Future<bool> updateRequest(RequestModel request) async {
    db
        .collection(Requests.collectionName)
        .doc(request.documentId)
        .update(request.firestoreModel());
    return true;
  }

  Future<bool> sendRequest(String senderUid, String userName) async {
    final receiverUid = await getUID(userName);

    if (receiverUid == null || senderUid == receiverUid) {
      return false;
    }
    final requestRef = db.collection(Requests.collectionName);
    final querySnapshot1 = await requestRef
        .where(Requests.senderUid, isEqualTo: senderUid)
        .where(Requests.receiverUid, isEqualTo: receiverUid)
        .get();
    final querySnapshot2 = await requestRef
        .where(Requests.senderUid, isEqualTo: receiverUid)
        .where(Requests.receiverUid, isEqualTo: senderUid)
        .get();
    if (querySnapshot1.size > 0 || querySnapshot2.size > 0) {
      return false;
    }
    final request = RequestModel(
            senderUid: senderUid,
            receiverUid: receiverUid,
            accepted: false,
            acknowleged: false)
        .firestoreModel();
    await db.collection(Requests.collectionName).add(request);
    return true;
  }

  getRequestNotAcknowlgedSnapShot(String uid) {
    return db
        .collection(Requests.collectionName)
        .where(Requests.receiverUid, isEqualTo: uid)
        .where(Requests.acknowleged, isEqualTo: false)
        .snapshots();
  }

  addFriend(String userUid, String friendUid) {
    final friendRef = db.collection(Friends.collectionName);

    friendRef
        .where(Friends.currentUid, isEqualTo: userUid)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 0) {
        return;
      }
      final document = querySnapshot.docs[0];
      final map = document.get(Friends.friendList);
      map[friendUid] = true;
      friendRef.doc(document.id).update({Friends.friendList: map});
    });
  }

  getFriendsSnapshot(String uid) {
    return db
        .collection(Friends.collectionName)
        .where(Friends.currentUid, isEqualTo: uid)
        .snapshots();
  }
}
