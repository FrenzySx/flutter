import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data())
          .where((user) => user['uid'] != _auth.currentUser?.uid)
          .toList();
    });
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final newMessage = Message(
      senderId: currentUser.uid,
      senderEmail: currentUser.email ?? '',
      receiverId: receiverId,
      message: message,
    );

    final chatRoomId = _getChatRoomId(currentUser.uid, receiverId);

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    final chatRoomId = _getChatRoomId(userId, otherUserId);

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  String _getChatRoomId(String userId1, String userId2) {
    final ids = [userId1, userId2]..sort();
    return ids.join('_');
  }
}
