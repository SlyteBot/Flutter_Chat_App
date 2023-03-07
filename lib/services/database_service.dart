import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_chat_app/consts/collections_const.dart';
import 'package:flutter_project_chat_app/models/user_model.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  addUser(String uid, String userName, String email) async {
    final user = {Users.uid: uid, Users.userName: userName, Users.email: email};
    final friendList = {Friends.currentUid: uid, Friends.friendList: []};
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

  Future getUsername(String uid) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.uid, isEqualTo: uid);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return null;
    }
    final user = querySnapshot.docs[0];
    return user.get(Users.userName);
  }

  Future<bool> sendRequest(String uid, String userName) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.userName, isEqualTo: userName);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return false;
    }
    final receiverUid = querySnapshot.docs[0].get(Users.uid);

    final request = {
      Requests.senderUid: uid,
      Requests.receiverUid: receiverUid,
      Requests.date: DateTime.now()
    };
    await db.collection(Requests.collectionName).add(request);
    return true;
  }
}
