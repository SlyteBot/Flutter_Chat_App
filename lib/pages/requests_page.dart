import 'package:flutter/material.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/pages/friends_page.dart';
import 'package:flutter_project_chat_app/pages/home_page.dart';
import 'package:flutter_project_chat_app/widgets/drawer_for_loggedin.dart';
import 'package:flutter_project_chat_app/widgets/request_tile.dart';

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
  addUserAsFriend() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                addUserAsFriend();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: getDrawer(index, context),
      body: SingleChildScrollView(
        child: Column(children: [
          RequestTile(
            request: RequestModel(
                receiverUid: "1234",
                senderUid: "4312",
                accepted: false,
                acknowleged: false),
            userName: "Slyte3",
          ),
          RequestTile(
            request: RequestModel(
                receiverUid: "1234",
                senderUid: "4312",
                accepted: false,
                acknowleged: false),
            userName: "LMAO21311112131423432432",
          ),
          RequestTile(
            request: RequestModel(
                receiverUid: "1234",
                senderUid: "4312",
                accepted: false,
                acknowleged: false),
            userName: "LMAO21311112131423432432",
          ),
          RequestTile(
            request: RequestModel(
                receiverUid: "1234",
                senderUid: "4312",
                accepted: false,
                acknowleged: false),
            userName: "LMAO21311112131423432432",
          ),
          RequestTile(
            request: RequestModel(
                receiverUid: "1234",
                senderUid: "4312",
                accepted: false,
                acknowleged: false),
            userName: "LMAO21311112131423432432",
          ),
          RequestTile(
            request: RequestModel(
                receiverUid: "1234",
                senderUid: "4312",
                accepted: false,
                acknowleged: false),
            userName: "LMAO21311112131423432432",
          ),
        ]),
      ),
    );
  }
}
