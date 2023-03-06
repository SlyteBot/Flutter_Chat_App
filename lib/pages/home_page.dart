import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/services/auth_service.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final listTileStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
                  onTap: () {},
                  leading: const Icon(Icons.message),
                  selected: true,
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
                  onTap: () {},
                  leading: const Icon(Icons.contact_mail),
                  selected: true,
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
                  selected: true,
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
