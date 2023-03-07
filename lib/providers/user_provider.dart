import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _userName = "";
  String _uid = "";
  String _email = "";

  String get userName => _userName;
  String get uid => _uid;
  String get email => _email;
  void setUser(String uid, String userName, String email) {
    _userName = userName;
    _uid = _uid;
    _email = email;
    notifyListeners();
  }
}
