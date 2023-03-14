import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FriendTile extends StatefulWidget {
  final String friendUid;
  const FriendTile({Key? key, required this.friendUid}) : super(key: key);

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  String username = "";

  setUsername() {
    context
        .read<UserProvider>()
        .getUsernameByUid(widget.friendUid)
        .then((value) {
      setState(() {
        username = value!;
      });
    });
  }

  @override
  void initState() {
    setUsername();
    super.initState();
  }

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
                      onPressed: () {},
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
          SizedBox(
            width: MediaQuery.of(context).size.width - 115,
            child: Text(
              username,
              style: const TextStyle(fontSize: 35),
              textWidthBasis: TextWidthBasis.parent,
            ),
          ),
          OutlinedButton(
              onPressed: () {
                //Navigate to chat screen with the selected user paramater
              },
              child: const Icon(Icons.add)),
        ]),
      ),
    );
  }
}
