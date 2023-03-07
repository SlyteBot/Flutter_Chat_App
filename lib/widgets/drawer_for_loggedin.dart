import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/pages/friends_page.dart';
import 'package:flutter_project_chat_app/pages/home_page.dart';
import 'package:flutter_project_chat_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../pages/login_page.dart';
import '../pages/requests_page.dart';
import '../providers/user_provider.dart';
import '../services/auth_service.dart';

getDrawer(int index, context) {
  final pagesIndex = [0, 1, 2];
  String userName = Provider.of<User>(context).userName;
  return Drawer(
    child: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const SizedBox(
            height: 45,
          ),
          GestureDetector(
            onTap: () {
              print("User pressed");
            },
            child: Column(
              children: [
                const Icon(
                  Icons.person,
                  size: 45,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  userName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          ListTileTheme(
            selectedColor: Theme.of(context).highlightColor,
            child: ListTile(
              onTap: () {
                if (index == pagesIndex[0]) {
                  return;
                }
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false);
              },
              selected: index == pagesIndex[0],
              leading: const Icon(Icons.message),
              iconColor: Theme.of(context).primaryColor,
              title: Text(
                "Messages",
                style: listTileStyle.copyWith(
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          ListTileTheme(
            selectedColor: Theme.of(context).highlightColor,
            child: ListTile(
              onTap: () {
                if (pagesIndex[1] == index) {
                  return;
                }
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const FriendsPage()),
                    (route) => false);
              },
              leading: const Icon(Icons.person),
              selected: index == 1,
              iconColor: Theme.of(context).primaryColor,
              title: Text(
                "Friends",
                style: listTileStyle.copyWith(
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          ListTileTheme(
            selectedColor: Theme.of(context).highlightColor,
            child: ListTile(
              onTap: () {
                if (pagesIndex[2] == index) {
                  return;
                }
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const RequestsPage()),
                    (route) => false);
              },
              leading: const Icon(Icons.contact_mail),
              iconColor: Theme.of(context).primaryColor,
              selected: index == pagesIndex[2],
              title: Text(
                "Requests",
                style: listTileStyle.copyWith(
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          ListTileTheme(
            selectedColor: Theme.of(context).highlightColor,
            child: ListTile(
              onTap: () {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () {
                                AuthService authService = AuthService();
                                authService.signOutUser();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false);
                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              )),
                        ],
                      );
                    });
              },
              leading: const Icon(Icons.exit_to_app),
              iconColor: Theme.of(context).primaryColor,
              title: Text(
                "Logout",
                style: listTileStyle.copyWith(
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
