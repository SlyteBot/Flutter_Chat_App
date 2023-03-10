import 'package:cloud_firestore/cloud_firestore.dart';

import '../consts/collections_const.dart';

class UserModel {
  String userName;
  String uid;
  String email;

  UserModel({required this.uid, required this.userName, required this.email});

  firestoreModel() {
    return {Users.uid: uid, Users.userName: userName, Users.email: email};
  }
}
