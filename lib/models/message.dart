import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String receiverId;
  final String senderId;
  final String senderEmail;
  final String messageText;
  final Timestamp timestamp;

  Message({
    required this.receiverId,
    required this.senderId,
    required this.senderEmail,
    required this.messageText,
    required this.timestamp,
  });

  Map<String, dynamic> ConvertToMap(){
    return{
      "senderId" : senderId,
      "receiverId" : receiverId,
      "senderEmail" : senderEmail,
      "messageText" : messageText,
      "timestamp" : timestamp,
    };
  }
}