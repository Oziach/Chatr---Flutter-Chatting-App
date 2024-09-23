import 'package:chatr/authStuff/auth.dart';
import 'package:chatr/chatStuff/ChatService.dart';
import 'package:chatr/components/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatPage extends StatelessWidget {

  final String receiverEmail;
  final String receiverId;

  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  final TextEditingController messageController = TextEditingController();

  final ChatService chatService = ChatService();
  final Auth auth = Auth();

  //send message
  void SendMessage() async {
    if(messageController.text.isNotEmpty){
      await chatService.SendMessage(receiverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail),),
      body: Column(
        children: [
          //all messages
          Expanded(
            child: BuildMessagesList(),
          ),

          //user input
          UserInput(context),
        ],
      ),

    );
  }

  Widget BuildMessagesList(){
    String senderId = auth.GetCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatService.GetAllMessages(senderId, receiverId), 
      builder: (context, snapshot){
        //errors
        if(snapshot.hasError){
          return Text("Error occured");
        }

        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text("Loading messages...");
        }

        //return all messages list
        return ListView(
          children: snapshot.data!.docs.map((doc) => CreateMessageItem(doc)).toList(),
        );
      }
    );
  }

  Widget CreateMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data["senderId"] == auth.GetCurrentUser()!.uid;
    var alignmnet = isCurrentUser ? Alignment.centerLeft : Alignment.centerRight;
    //align accordingly

    return Container(
      alignment: alignmnet,
      child: Text(data["messageText"])
    );
  }

  Widget UserInput(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: CustomTextField(
            hintText: "Type a message", 
            hideText: false, 
            controller: messageController
          )),
      
          Container(

            child: IconButton(
              onPressed: SendMessage, 
              icon: Icon(
                Icons.send,
              ),
            ),
          ),
        ],
      ),
    );
  }
}