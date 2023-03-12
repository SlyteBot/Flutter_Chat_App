import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';

class RequestTile extends StatefulWidget {
  final RequestModel request;
  final String userName;
  const RequestTile({Key? key, required this.request, required this.userName})
      : super(key: key);

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
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              widget.userName,
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
