import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/consts/collections_const.dart';
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
          children: [
            const Icon(
              Icons.person,
              size: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            Consumer<ChatProvider>(
              builder: (context, value, child) {
                return FutureBuilder(
                  future: value.getChatName(widget.chatId, widget.userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        child: Text(
                          "",
                          style: TextStyle(fontSize: 35),
                          textWidthBasis: TextWidthBasis.parent,
                        ),
                      );
                    }

                    return SizedBox(
                      child: Text(
                        snapshot.data!,
                        style: const TextStyle(fontSize: 35),
                        textWidthBasis: TextWidthBasis.parent,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.35,
        child: Consumer<ChatProvider>(builder: (context, value, _) {
          return StreamBuilder(
            stream: value.getChatStream(widget.chatId),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Container();
              }
              List<QueryDocumentSnapshot> messages =
                  snapshot.data!.docs.toList();
              messages.sort((a, b) {
                Timestamp aTime = a.get(Messages.timeStamp);
                Timestamp btime = b.get(Messages.timeStamp);
                return aTime.compareTo(btime);
              });
              return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      messageData: MessageModel(
                          message: messages[index].get(Messages.message),
                          senderUid: messages[index].get(Messages.senderUid),
                          timeStamp: (messages[index].get(Messages.timeStamp))
                              .toDate()),
                      sendByMe: (widget.userId ==
                          messages[index].get(Messages.senderUid)),
                    );
                  });
            },
          );
        }),
      )),
    );
  }
}
