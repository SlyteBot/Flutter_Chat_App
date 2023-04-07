import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/consts/collections_const.dart';
import 'package:flutter_project_chat_app/pages/friends_page.dart';
import 'package:flutter_project_chat_app/pages/requests_page.dart';
import 'package:flutter_project_chat_app/providers/chat_provider.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:flutter_project_chat_app/services/auth_service.dart';
import 'package:flutter_project_chat_app/services/database_service.dart';
import 'package:flutter_project_chat_app/widgets/chat_tile.dart';
import 'package:flutter_project_chat_app/widgets/drawer_for_loggedin.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: getDrawer(index, context),
      body: SafeArea(
        child: Consumer<ChatProvider>(
          builder: (context, value, child) {
            return StreamBuilder(
              stream: value.getUsersChatStream(widget.uid),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> chats =
                      snapshot.data!.docs.toList();

                  if (chats.isNotEmpty) {
                    return ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return ChatTile(
                            chatId: chats[index].id,
                            uid: widget.uid,
                          );
                        });
                  }
                }
                return const Center(
                  child: Text("You have no chats!"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
