import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/pages/chat_page.dart';
import 'package:flutter_project_chat_app/providers/chat_provider.dart';
import 'package:flutter_project_chat_app/providers/friend_provider.dart';
import 'package:flutter_project_chat_app/providers/request_provider.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:flutter_project_chat_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FriendTile extends StatefulWidget {
  final String friendUid;
  const FriendTile({Key? key, required this.friendUid}) : super(key: key);

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Remove this friend",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                content: const Text(
                    "Are you sure you want to delete this user from your friend list?"),
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
                        context.read<RequestProvider>().deleteFriendRequest(
                            context.read<UserProvider>().getUID(),
                            widget.friendUid);
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
          Consumer<FriendProvider>(
            builder: (context, value, child) {
              return FutureBuilder(
                future: value.getUsernameByUid(widget.friendUid),
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
                  if (snapshot.data == null) {
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
          ),
          OutlinedButton(
              onPressed: () async {
                String chatId = await context.read<FriendProvider>().startChat(
                    context.read<UserProvider>().getUID(), widget.friendUid);
                switchToChat(chatId);
                //Navigate to chat screen with the selected user paramater
              },
              child: const Icon(Icons.add)),
        ]),
      ),
    );
  }

  switchToChat(String chatId) {
    String userId = context.read<UserProvider>().getUID();
    context.read<ChatProvider>().setChatId(chatId);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatPage(
              chatId: chatId,
              userId: userId,
            )));
  }
}
