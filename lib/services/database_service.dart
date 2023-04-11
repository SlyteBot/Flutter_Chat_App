import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_chat_app/consts/collections_const.dart';
import 'package:flutter_project_chat_app/models/chat_model.dart';
import 'package:flutter_project_chat_app/models/friendlist_model.dart';
import 'package:flutter_project_chat_app/models/message_model.dart';
import 'package:flutter_project_chat_app/models/requests_model.dart';
import 'package:flutter_project_chat_app/models/user_model.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  addUser(String uid, String userName, String email) async {
    final user =
        UserModel(uid: uid, userName: userName, email: email).firestoreModel();
    final friendList =
        FriendListModel(uid: uid, friendList: {}).firestoreModel();
    await db.collection(Users.collectionName).add(user);
    await db.collection(Friends.collectionName).add(friendList);
  }

  Future<bool> doesUserExist(String userName) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.userName, isEqualTo: userName);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return false;
    } else {
      return true;
    }
  }

  doesUserExistByUid(String uid) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.uid, isEqualTo: uid);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<String?> getUID(String userName) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.userName, isEqualTo: userName);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return null;
    }
    final user = querySnapshot.docs[0];
    return user.get(Users.uid);
  }

  Future<String?> getUsername(String uid) async {
    final usersRef = db.collection(Users.collectionName);
    final query = usersRef.where(Users.uid, isEqualTo: uid);
    final querySnapshot = await query.get();
    if (querySnapshot.size == 0) {
      return null;
    }
    final user = querySnapshot.docs[0];
    return user.get(Users.userName);
  }

  changeUsername(String uid, String newUserName) async {
    if (await doesUserExist(newUserName)) {
      return false;
    }
    final queryUser = await db
        .collection(Users.collectionName)
        .where(Users.uid, isEqualTo: uid)
        .get();
    if (queryUser.size <= 0) {
      return;
    }
    db
        .collection(Users.collectionName)
        .doc(queryUser.docs[0].id)
        .update({Users.userName: newUserName});
    return true;
  }

  Future<bool> updateRequest(RequestModel request) async {
    db
        .collection(Requests.collectionName)
        .doc(request.documentId)
        .update(request.firestoreModel());
    return true;
  }

  deleteUser(String uid) async {
    final queryUser = await db
        .collection(Users.collectionName)
        .where(Users.uid, isEqualTo: uid)
        .get();
    if (queryUser.size <= 0) {
      return;
    }
    db.collection(Users.collectionName).doc(queryUser.docs[0].id).delete();
    final queryFriends = await db
        .collection(Friends.collectionName)
        .where(Friends.currentUid, isEqualTo: uid)
        .get();
    final Map mapFriend = queryFriends.docs[0].get(Friends.friendList);

    final queryUserRequest = await db
        .collection(Requests.collectionName)
        .where(Requests.senderUid, isEqualTo: uid)
        .get();
    for (DocumentSnapshot doc in queryUserRequest.docs) {
      db.collection(Requests.collectionName).doc(doc.id).delete();
    }
    final queryUserRequest2 = await db
        .collection(Requests.collectionName)
        .where(Requests.receiverUid, isEqualTo: uid)
        .get();
    for (DocumentSnapshot doc in queryUserRequest2.docs) {
      db.collection(Requests.collectionName).doc(doc.id).delete();
    }
    for (String friendUid in mapFriend.keys) {
      await sendRequestWithUids(uid, friendUid, true);
    }
    db.collection(Friends.collectionName).doc(queryFriends.docs[0].id).delete();
    final queryChats = await db
        .collection(Chats.collectionName)
        .where(Chats.members, arrayContains: uid)
        .get();
    if (queryChats.size > 0) {
      for (QueryDocumentSnapshot doc in queryChats.docs) {
        List members = doc.get(Chats.members);
        members.remove(uid);
        db
            .collection(Chats.collectionName)
            .doc(doc.id)
            .update({Chats.members: members});
      }
    }
  }

  Future<bool> sendRequest(
      String senderUid, String userName, bool delete) async {
    final receiverUid = await getUID(userName);

    if (receiverUid == null || senderUid == receiverUid) {
      return false;
    }
    final requestRef = db.collection(Requests.collectionName);
    final querySnapshot1 = await requestRef
        .where(Requests.senderUid, isEqualTo: senderUid)
        .where(Requests.receiverUid, isEqualTo: receiverUid)
        .get();
    final querySnapshot2 = await requestRef
        .where(Requests.senderUid, isEqualTo: receiverUid)
        .where(Requests.receiverUid, isEqualTo: senderUid)
        .get();
    if (querySnapshot1.size > 0 || querySnapshot2.size > 0) {
      return false;
    }
    final request = RequestModel(
            senderUid: senderUid,
            receiverUid: receiverUid,
            accepted: false,
            acknowleged: false,
            delete: delete)
        .firestoreModel();
    await db.collection(Requests.collectionName).add(request);
    return true;
  }

  Future<bool> sendRequestWithUids(
      String senderUid, String receiverUid, bool delete) async {
    if (senderUid == receiverUid) {
      return false;
    }
    final requestRef = db.collection(Requests.collectionName);
    final querySnapshot1 = await requestRef
        .where(Requests.senderUid, isEqualTo: senderUid)
        .where(Requests.receiverUid, isEqualTo: receiverUid)
        .where(Requests.delete, isEqualTo: false)
        .get();
    final querySnapshot2 = await requestRef
        .where(Requests.senderUid, isEqualTo: receiverUid)
        .where(Requests.receiverUid, isEqualTo: senderUid)
        .where(Requests.delete, isEqualTo: false)
        .get();
    final querySnapshot3 = await requestRef
        .where(Requests.senderUid, isEqualTo: senderUid)
        .where(Requests.receiverUid, isEqualTo: receiverUid)
        .where(Requests.delete, isEqualTo: true)
        .get();
    final querySnapshot4 = await requestRef
        .where(Requests.senderUid, isEqualTo: receiverUid)
        .where(Requests.receiverUid, isEqualTo: senderUid)
        .where(Requests.delete, isEqualTo: true)
        .get();

    if ((querySnapshot1.size > 0 || querySnapshot2.size > 0) &&
        delete == false) {
      return false;
    }
    if ((querySnapshot3.size > 0 || querySnapshot4.size > 0) &&
        delete == true) {
      return false;
    }
    final request = RequestModel(
            senderUid: senderUid,
            receiverUid: receiverUid,
            accepted: false,
            acknowleged: false,
            delete: delete)
        .firestoreModel();
    await db.collection(Requests.collectionName).add(request);
    return true;
  }

  getRequestNotAcknowlgedSnapShot(String uid) {
    return db
        .collection(Requests.collectionName)
        .where(Requests.receiverUid, isEqualTo: uid)
        .where(Requests.acknowleged, isEqualTo: false)
        .snapshots();
  }

  addFriend(String userUid, String friendUid) {
    final friendRef = db.collection(Friends.collectionName);

    friendRef
        .where(Friends.currentUid, isEqualTo: userUid)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 0) {
        return;
      }
      final document = querySnapshot.docs[0];
      final map = document.get(Friends.friendList);
      map[friendUid] = true;
      friendRef.doc(document.id).update({Friends.friendList: map});
    });
  }

  deleteFriend(String userUid, String friendUid) async {
    final friendRef = db.collection(Friends.collectionName);

    friendRef
        .where(Friends.currentUid, isEqualTo: userUid)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 0) {
        return;
      }
      final document = querySnapshot.docs[0];
      final Map map = document.get(Friends.friendList);
      map.remove(friendUid);
      friendRef.doc(document.id).update({Friends.friendList: map});
    });
  }

  deleteRequestsAndProcess(String userUid) async {
    final requestRef = db.collection(Requests.collectionName);

    final acknowlegedRequests = await requestRef
        .where(Requests.senderUid, isEqualTo: userUid)
        .where(Requests.acknowleged, isEqualTo: true)
        .get();
    final deleteRequests = await requestRef
        .where(Requests.receiverUid, isEqualTo: userUid)
        .where(Requests.acknowleged, isEqualTo: false)
        .where(Requests.delete, isEqualTo: true)
        .get();
    for (final document in acknowlegedRequests.docs) {
      if (document.get(Requests.accepted) == true) {
        await addFriend(userUid, document.get(Requests.receiverUid));
      }
      requestRef.doc(document.id).delete();
    }
    for (final document in deleteRequests.docs) {
      await deleteFriend(userUid, document.get(Requests.senderUid));

      requestRef.doc(document.id).update({Requests.acknowleged: true});
      if (!await doesUserExistByUid(document.get(Requests.senderUid))) {
        requestRef.doc(document.id).delete();
      }
    }
  }

  getFriendsSnapshot(String uid) {
    return db
        .collection(Friends.collectionName)
        .where(Friends.currentUid, isEqualTo: uid)
        .snapshots();
  }

  createChat(String userUid, String friendUid) async {
    var querySnapshot = await db
        .collection(Chats.collectionName)
        .where(Chats.isDM, isEqualTo: true)
        .where(Chats.members, arrayContains: userUid)
        .get();
    if (querySnapshot.size > 0) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        if (doc.get(Chats.members).contains(friendUid)) {
          return doc.id;
        }
      }
    }
    var chat = await db.collection(Chats.collectionName).add(ChatModel(
          members: [userUid, friendUid],
          name: "",
          isDM: true,
        ).firestoreModel());
    return chat.id;
  }

  getChatStream(String chatId) {
    return db
        .collection(Chats.collectionName)
        .doc(chatId)
        .collection(Messages.collectionName)
        .snapshots();
  }

  getChatName(String chatId, String uid) async {
    final DocumentSnapshot chatDocument =
        await db.collection(Chats.collectionName).doc(chatId).get();
    if (!chatDocument.get(Chats.isDM)) {
      return chatDocument.get(Chats.name);
    }
    List members = chatDocument.get(Chats.members);
    String? friendUID;
    for (String userID in members) {
      if (userID != uid) {
        friendUID = userID;
      }
    }

    if (friendUID != null) {
      bool exist = await doesUserExistByUid(friendUID);
      if (exist) {
        return await getUsername(friendUID);
      }
    }

    return getUsername(uid);
  }

  getUsersChat(String uid) {
    return db
        .collection(Chats.collectionName)
        .where(Chats.members, arrayContains: uid)
        .snapshots();
  }

  sendMessageToChat(String userUid, String chatId, String message) {
    db
        .collection(Chats.collectionName)
        .doc(chatId)
        .collection(Messages.collectionName)
        .add(MessageModel(
                timeStamp: DateTime.now(), senderUid: userUid, message: message)
            .firestoreModel());
  }

  deleteMessageFromChat(String chatId, String messageId) {
    db
        .collection(Chats.collectionName)
        .doc(chatId)
        .collection(Messages.collectionName)
        .doc(messageId)
        .delete();
  }

  deleteMemberFromChat(String chatId, String uid) async {
    final chatDoc = await db.collection(Chats.collectionName).doc(chatId).get();

    List members = chatDoc.get(Chats.members);
    if (members.length == 1) {
      db.collection(Chats.collectionName).doc(chatId).delete();
    } else {
      members.remove(uid);
      db
          .collection(Chats.collectionName)
          .doc(chatId)
          .update({Chats.members: members});
    }
  }
}
