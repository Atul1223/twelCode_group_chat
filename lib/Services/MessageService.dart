import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/Models/UserModel.dart';

class FirebaseMessages {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  sendConversationMessages(String chatRoomId, MessageMap) {
    instance
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection(chatRoomId + "Chat")
        .add(MessageMap);
  }

  getConversationMessages(String ChatRoomId) {
    Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
        .collection('ChatRooms')
        .doc(ChatRoomId)
        .collection(ChatRoomId + "Chat")
        .orderBy('time', descending: false)
        .snapshots();
    return messageStream;
  }
}
