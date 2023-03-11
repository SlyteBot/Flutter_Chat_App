import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';

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
          Icon(
            Icons.person_2_rounded,
            size: 35,
          ),
          Text(
            "Username",
            style: TextStyle(fontSize: 35),
          ),
          SizedBox(
            width: 50,
          ),
          FilledButton(
            onPressed: () {},
            child: Icon(Icons.check),
          ),
          SizedBox(
            width: 10,
          ),
          FilledButton(
            style: ButtonStyle(),
            onPressed: () {},
            child: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
