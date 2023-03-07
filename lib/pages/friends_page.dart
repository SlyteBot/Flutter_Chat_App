import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/pages/login_page.dart';
import 'package:flutter_project_chat_app/pages/requests_page.dart';

import '../services/auth_service.dart';
import '../widgets/widgets.dart';
import 'home_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
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
    ///Database
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
      drawer: Drawer(
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
                  children: const [
                    Icon(
                      Icons.person,
                      size: 45,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      //TODO: Get username from provider
                      "Username",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  },
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
                  onTap: () {},
                  leading: const Icon(Icons.person),
                  selected: true,
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
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const RequestsPage()),
                        (route) => false);
                  },
                  leading: const Icon(Icons.contact_mail),
                  iconColor: Theme.of(context).primaryColor,
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
                            content:
                                const Text("Are you sure you want to logout?"),
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
      ),
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
