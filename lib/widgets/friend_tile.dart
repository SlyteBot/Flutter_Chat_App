import 'package:flutter/material.dart';

class FriendTile extends StatefulWidget {
  final String friendUid;
  const FriendTile({Key? key, required this.friendUid}) : super(key: key);

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  String username = "";

  setUsername() {
    setState(() {
      username = widget.friendUid;
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
            context: context,
            builder: (context) {
              return AlertDialog();
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
          OutlinedButton(onPressed: () {}, child: const Icon(Icons.add)),
        ]),
      ),
    );
  }
}
