import 'package:chatr/authStuff/auth.dart';
import 'package:chatr/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {


  //get instance of firestore
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //get user stream
  Stream<List<Map<String,dynamic>>> GetUsersStream(){
    return fireStore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        
        final user = doc.data();

        return user;

      }).toList();
    });
  }

  //send message
  Future<void> SendMessage(String receiverId, messageText) async{

    Auth auth = Auth();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //get current user info
    final String currentUserId= auth.GetCurrentUser()!.uid;
    final String currentUserEmail = auth.GetCurrentUser()!.email!;
    final Timestamp timestamp = Timestamp.now();


    //create new message
    Message newMessage = Message(
      receiverId: receiverId, 
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      messageText: messageText,
      timestamp: timestamp
    );

    //constrcut chat room ID (sorted so i don't have to check for both the first and second, and second and first)
    String chatroomId = GetChatroomId(currentUserId, receiverId);

    //add message to database
    await firestore
    .collection("chatrooms")
    .doc(chatroomId)
    .collection("messages")
    .add(newMessage.ConvertToMap());
  }

  //get all messages in a chatroom
  Stream<QuerySnapshot> GetAllMessages(senderId, receiverId){
    String chatroomId = GetChatroomId(senderId, receiverId);

    return fireStore
    .collection("chatrooms")
    .doc(chatroomId)
    .collection("messages")
    .orderBy("timestamp", descending: false)
    .snapshots();    
  }

  void DeleteMessage(senderId, receiverId, messageId){
    
    String chatroomId = GetChatroomId(senderId, receiverId);

    fireStore
    .collection("chatrooms")
    .doc(chatroomId)
    .collection("messages")
    .doc(messageId)
    .delete();
  }

  String GetChatroomId(senderId, receiverId){
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatroomId = ids.join('_');

    return chatroomId;
  }

} 