import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/pages/login_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.black,
      ),
      home: const LoginPage(),
    );
  }
}
