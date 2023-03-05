import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginUser(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future registerUser(String email, String password, String userName) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        //Database
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future forgotPasswordEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOutUser() async {
    await firebaseAuth.signOut();
  }
}
