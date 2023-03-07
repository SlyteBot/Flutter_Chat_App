import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/pages/friends_page.dart';
import 'package:flutter_project_chat_app/pages/requests_page.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:flutter_project_chat_app/services/auth_service.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';
import 'package:flutter_project_chat_app/widgets/drawer_for_loggedin.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
