import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/consts/collections_const.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/providers/request_provider.dart';
import 'package:flutter_project_chat_app/providers/user_provider.dart';
import 'package:flutter_project_chat_app/widgets/drawer_for_loggedin.dart';
import 'package:flutter_project_chat_app/widgets/request_tile.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/widgets.dart';
import 'login_page.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  static const index = 2;
  late Stream<QuerySnapshot> requests;
  List<Widget> requestTiles = [];
  @override
  void initState() {
    requests = getSnapshot();
    super.initState();
  }

  getSnapshot() {
    return context
        .read<RequestProvider>()
        .fetch(context.read<UserProvider>().getUID());
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
              stream: requests,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ));
                }
                if (snapshot.hasData) {
                  requestTiles.clear();
                  for (int i = 0; i < snapshot.data!.docs.length; ++i) {
                    var document = snapshot.data!.docs[i];
                    final requestInstance = RequestTile(
                        request: RequestModel(
                      senderUid: document.get(Requests.senderUid),
                      receiverUid: document.get(Requests.receiverUid),
                      accepted: document.get(Requests.accepted),
                      acknowleged: document.get(Requests.acknowleged),
                      documentId: document.id,
                    ));
                    requestTiles.add(requestInstance);
                  }
                }
                return SingleChildScrollView(
                  child: Column(children: requestTiles),
                );
              }),
        ));
  }
}
