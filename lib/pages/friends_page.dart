import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/consts/collections_const.dart';
import 'package:flutter_project_chat_app/pages/login_page.dart';
import 'package:flutter_project_chat_app/pages/requests_page.dart';
import 'package:flutter_project_chat_app/providers/friend_provider.dart';
import 'package:flutter_project_chat_app/providers/request_provider.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';
import 'package:flutter_project_chat_app/widgets/drawer_for_loggedin.dart';
import 'package:flutter_project_chat_app/widgets/friend_tile.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/widgets.dart';
import 'home_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  static const index = 1;
  late Stream<QuerySnapshot> friends;

  getFriendsSnapshot() {
    friends = context
        .read<FriendProvider>()
        .fetch(context.read<UserProvider>().getUID());
  }

  @override
  void initState() {
    getFriendsSnapshot();
    super.initState();
  }

  void addFriendDialog(BuildContext context) {
    String userName = "";
    showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: AlertDialog(
              title: const Text(
                "Add a friend by their username!",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      userName = value;
                    },
                  ),
                ],
              ),
              actions: [
                Material(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Material(
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                      sendRequest(userName);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  sendRequest(String userName) {
    context
        .read<RequestProvider>()
        .sendRequest(context.read<UserProvider>().getUID(), userName)
        .then((result) {
      if (result == true) {
        showSnackbar(context, Colors.green, "Request sent succesfully!");
      } else {
        showSnackbar(context, Colors.red, "Request wasn't sent!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                addFriendDialog(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: getDrawer(index, context),
      body: SafeArea(
        child: StreamBuilder(
          stream: friends,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }
            if (snapshot.hasData) {
              Map map = snapshot.data!.docs[0].get(Friends.friendList);
              List friendsList = map.keys.toList();
              if (friendsList.isNotEmpty) {
                return ListView.builder(
                    itemCount: friendsList.length,
                    itemBuilder: (context, index) {
                      return FriendTile(
                        friendUid: friendsList[index],
                      );
                    });
              } else {
                return const Center(
                  child: Text("You have no friends!"),
                );
              }
            }
            return const Center(
              child: Text("You have no friends!"),
            );
          },
        ),
      ),
    );
  }
}
