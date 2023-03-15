import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Icon(Icons.send))
              ],
            ),
          )
        ],
      )),
    );
  }
}
