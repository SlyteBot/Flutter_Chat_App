class Users {
  static const collectionName = "users";
  static const uid = "uid";
  static const email = "email";
  static const userName = "userName";
}

class Requests {
  static const collectionName = "friend_requests";
  static const senderUid = "sender";
  static const receiverUid = "receiver";
  static const accepted = "accepted";
  static const acknowleged = "acknowleged";
}

class Friends {
  static const collectionName = "friend_list";
  static const currentUid = "uid";
  static const friendList = "friendList";
}

class Chats {
  static const collectionName = "chats";
  static const name = "name";
  static const members = "members";
  static const isDM = "isDM";
}

class Messages {
  static const collectionName = "messages";
  static const senderUid = "senderUid";
  static const message = "message";
  static const timeStamp = "timeStamp";
}
