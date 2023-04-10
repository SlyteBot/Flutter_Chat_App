import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userData;
  bool _isAuthenticated = false;
  UserProvider();

  Future signIn(String email, String password) async {
    AuthService authService = AuthService();

    String? returnValue = "";
    await authService.loginUser(email, password).then((value) {
      if (value is UserModel) {
        _userData = value;
        _isAuthenticated = true;
        returnValue = null;
      } else {
        _isAuthenticated = false;
        returnValue = value;
      }
    });
    return returnValue;
  }

  Future register(String userName, String email, String password) async {
    AuthService authService = AuthService();
    String? returnValue = "";
    await authService.registerUser(email, password, userName).then((value) {
      if (value is UserModel) {
        _userData = value;
        _isAuthenticated = true;
        returnValue = null;
      } else {
        _isAuthenticated = false;
        returnValue = value;
      }
    });
    return returnValue;
  }

  Future sendResetPassword(String email) async {
    AuthService authService = AuthService();
    var result = await authService.forgotPasswordEmail(email);

    return result;
  }

  Future signOut() async {
    AuthService authService = AuthService();
    return await authService.signOutUser();
  }

  Future<String?> getUsernameByUid(String uid) async {
    DatabaseService databaseService = DatabaseService();
    return await databaseService.getUsername(uid);
  }

  Future<bool> changeUsername(String userName) async {
    DatabaseService databaseService = DatabaseService();
    var result = await databaseService.changeUsername(getUID(), userName);
    if (result) {
      _userData!.userName = userName;
      notifyListeners();
    }
    return result;
  }

  deleteAccount() {}
  String getUsername() {
    return _userData!.userName;
  }

  String getUID() {
    return _userData!.uid;
  }

  bool isAuthenticated() {
    return _isAuthenticated;
  }

  bool isUserNameValid() {
    return true;
  }
}
