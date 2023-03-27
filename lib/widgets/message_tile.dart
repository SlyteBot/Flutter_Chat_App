import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/message_model.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatefulWidget {
  final MessageModel messageData;
  final bool sendByMe;
  const MessageTile(
      {Key? key, required this.messageData, required this.sendByMe})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  String getTimeString(DateTime time) {
    DateTime now = DateTime.now();
    if (now.difference(time).inDays >= 1) {
      return DateFormat('yyyy-MM-dd HH:mm').format(time);
    }
    return DateFormat("hh:mm").format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 14,
          bottom: 14,
          left: widget.sendByMe ? 0 : 24,
          right: widget.sendByMe ? 24 : 0),
      alignment: widget.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: widget.sendByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: widget.sendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9),
                    bottomLeft: Radius.circular(9),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9),
                    bottomRight: Radius.circular(9)),
            color: widget.sendByMe ? Colors.blue : Colors.blueGrey),
        child: Text(
          "${widget.messageData.message}\n\n${getTimeString(widget.messageData.timeStamp)}",
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Orbitron',
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
