import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RequestTile extends StatefulWidget {
  final RequestModel request;

  const RequestTile({Key? key, required this.request}) : super(key: key);

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  String username = "";

  getUsername() {
    context
        .read<UserProvider>()
        .getUsernameByUid(widget.request.senderUid)
        .then((value) {
      setState(() {
        username = value!;
      });
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.person_2_rounded,
            size: 35,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              username,
              style: const TextStyle(fontSize: 35),
              textWidthBasis: TextWidthBasis.parent,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {},
              child: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {},
              child: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
