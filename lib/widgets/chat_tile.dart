import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/chat_page.dart';
import '../providers/chat_provider.dart';
import '../providers/friend_provider.dart';
import '../providers/user_provider.dart';

class ChatTile extends StatefulWidget {
  final String chatId;
  final String uid;
  const ChatTile({Key? key, required this.chatId, required this.uid})
      : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switchToChat(widget.chatId, widget.uid);
      },
      onLongPress: () {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Leave this chat",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                content:
                    const Text("Are you sure you want to leave this chat?"),
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
                        Navigator.of(context).pop();
                        context
                            .read<ChatProvider>()
                            .deleteChat(widget.chatId, widget.uid);
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.green,
                      )),
                ],
              );
            });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Row(children: [
          const Icon(
            Icons.person_2_rounded,
            size: 35,
          ),
          Consumer<ChatProvider>(
            builder: (context, value, child) {
              return FutureBuilder(
                future: value.getChatName(widget.chatId, widget.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width - 115,
                      child: const Text(
                        "",
                        style: TextStyle(fontSize: 35),
                        textWidthBasis: TextWidthBasis.parent,
                      ),
                    );
                  }

                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Text(
                      snapshot.data!,
                      style: const TextStyle(fontSize: 35),
                      textWidthBasis: TextWidthBasis.parent,
                    ),
                  );
                },
              );
            },
          )
        ]),
      ),
    );
  }

  switchToChat(String chatId, String uid) {
    context.read<ChatProvider>().setChatId(chatId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatPage(
              chatId: chatId,
              userId: uid,
            )));
  }
}
