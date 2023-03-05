import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/services/auth_service.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}
