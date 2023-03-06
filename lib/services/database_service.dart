import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;
  addUser(String uid, String userName, String email) async {
    final data = {"uid": uid, "userName": userName, "email": email};
    await db.collection("users").add(data);
  }

  Future<bool> doesUserExist(String userName) async {
    final usersRef = db.collection("users");
    final query = usersRef.where("userName", isEqualTo: userName);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return false;
    } else {
      return true;
    }
  }
}
