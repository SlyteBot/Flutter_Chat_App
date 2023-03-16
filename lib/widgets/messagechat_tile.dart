import 'package:flutter/material.dart';

class MessageChatTile extends StatefulWidget {
  const MessageChatTile({Key? key}) : super(key: key);

  @override
  State<MessageChatTile> createState() => _MessageChatTileState();
}

class _MessageChatTileState extends State<MessageChatTile> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
            border:
                Border.all(width: 1, color: Theme.of(context).primaryColor)),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
