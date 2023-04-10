import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_chat_app/models/user_model.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginUser(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      DatabaseService databaseService = DatabaseService();

      if (user != null) {
        String username = (await databaseService.getUsername(user.uid))!;
        return UserModel(uid: user.uid, userName: username, email: email);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future registerUser(String email, String password, String userName) async {
    try {
      DatabaseService databaseService = DatabaseService();
      bool exists = await databaseService.doesUserExist(userName);
      if (exists == true) {
        return "Username already exists";
      }
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        databaseService.addUser(user.uid, userName, user.email!);
        return UserModel(uid: user.uid, userName: userName, email: user.email!);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future forgotPasswordEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOutUser() async {
    await firebaseAuth.signOut();
  }

  deleteAccount() async {
    DatabaseService databaseService = DatabaseService();
    databaseService.deleteUser(firebaseAuth.currentUser!.uid);
    firebaseAuth.currentUser!.delete();
  }
}
