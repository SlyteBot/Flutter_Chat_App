import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/providers/chat_provider.dart';
import 'package:flutter_project_chat_app/providers/friend_provider.dart';
import 'package:flutter_project_chat_app/providers/request_provider.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project_chat_app/firebase_options.dart';
import 'package:flutter_project_chat_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => FriendProvider()),
      ChangeNotifierProvider(create: (context) => RequestProvider()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.black,
        highlightColor: Colors.teal,
      ),
      home: const LoginPage(),
    );
  }
}
