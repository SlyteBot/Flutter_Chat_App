import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/providers/request_provider.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../providers/friend_provider.dart';

class RequestTile extends StatefulWidget {
  final RequestModel request;

  const RequestTile({Key? key, required this.request}) : super(key: key);

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
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
          Consumer<FriendProvider>(
            builder: (context, value, child) {
              return FutureBuilder(
                future: value.getUsernameByUid(widget.request.senderUid),
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
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                context.read<RequestProvider>().acceptRequest(widget.request);
              },
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
              onPressed: () {
                context.read<RequestProvider>().denyRequest(widget.request);
              },
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
