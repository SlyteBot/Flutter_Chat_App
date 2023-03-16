import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/widgets/messagechat_tile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const MessageChatTile(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: const [
            Icon(
              Icons.person,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Username"),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: const [
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
          Text("Elso uzenet"),
          Text("Masodik uzenet"),
        ]),
      )),
    );
  }
}
