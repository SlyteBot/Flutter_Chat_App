import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/message_model.dart';
import 'package:flutter_project_chat_app/providers/chat_provider.dart';
import 'package:flutter_project_chat_app/widgets/message_tile.dart';
import 'package:flutter_project_chat_app/widgets/messagechat_tile.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final String userId;
  const ChatPage({Key? key, required this.chatId, required this.userId})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    MessageModel data = MessageModel(
        timeStamp: DateTime.now().subtract(const Duration(days: 1)),
        senderUid: "test",
        message: "Pelda uzenet");
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
          child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.35,
        child: SingleChildScrollView(
            child: Consumer<ChatProvider>(builder: (context, value, _) {
          return StreamBuilder(
            stream: value.getChatStream(),
            builder: (context, snapshot) {
              return Container();
            },
          );
        })),
      )),
    );
  }
}
