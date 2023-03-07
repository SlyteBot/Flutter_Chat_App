import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/pages/login_page.dart';
import 'package:flutter_project_chat_app/pages/requests_page.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';
import 'package:flutter_project_chat_app/widgets/drawer_for_loggedin.dart';

import '../services/auth_service.dart';
import '../widgets/widgets.dart';
import 'home_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  static const index = 1;

  void addFriendDialog() {
    String userName = "";
    showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: AlertDialog(
              title: const Text(
                "Add a friend by their username!",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        userName = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                Material(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Material(
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      print(userName);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    addUserAsFriend(userName);
  }

  void addUserAsFriend(String userName) {
    DatabaseService databaseService = DatabaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                addFriendDialog();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: getDrawer(index, context),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              AuthService authService = AuthService();
              authService.signOutUser();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            },
            child: const Text("Logut"),
          ),
        ),
      ),
    );
  }
}
