import 'package:chatr/authStuff/auth.dart';
import 'package:chatr/chatStuff/ChatService.dart';
import 'package:chatr/components/chatBubble.dart';
import 'package:chatr/components/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatPage extends StatefulWidget {

  final String receiverEmail;
  final String receiverId;

  ChatPage({super.key, required this.receiverEmail, required this.receiverId});


  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();

  final ChatService chatService = ChatService();

  final Auth auth = Auth();

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //add listener
    focusNode.addListener((){
      if(focusNode.hasFocus){
        Future.delayed(
          const Duration(milliseconds: 500),
          ScrollDown,
        );
      }
    });
  }
  

  final ScrollController scrollController = ScrollController(); 

  void ScrollDown(){
    scrollController.animateTo(
      scrollController.position.maxScrollExtent, 
      duration: const Duration(milliseconds: 500), 
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  //show options
  void ShowOptions(BuildContext context, String messageId){
    showModalBottomSheet(
      context: context,
       builder: (context){
        return SafeArea(
          child: Wrap(
            children: [
          
              //delete message
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red[600],),
                title: Text('Delete', style: TextStyle(color: Colors.red[600]),),
                onTap: () {
                  Navigator.pop(context);
                  ShowDeleteConfirmation(context , messageId);
                },

              ),

              //cancel button
               ListTile(
                leading: Icon(Icons.cancel, color: Theme.of(context).colorScheme.inversePrimary,),
                title: Text('Cancel', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,)),
                onTap: () => {
                  Navigator.pop(context)
                },
              ),
              
            ],
          )
        );
      }
    );
  }

  void ShowDeleteConfirmation(BuildContext context, String messageId){
    showDialog(
      context: context,
       builder: (context) => AlertDialog(
        title: Text("Delete message", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
        content: Text("Are you sure you want to delete this message", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
        actions: [
          
          
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text("Cancel", style: TextStyle(color: Theme.of(context).colorScheme.tertiary),)
          ),

          //delete button
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              chatService.DeleteMessage(auth.GetCurrentUser()!.uid, widget.receiverId, messageId);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Message deleted!"), duration: Duration(milliseconds: 1000),));
            } ,
            child: Text("Delete", style: TextStyle(color: Colors.red[600],)),
          ),

        ],
       )
      );
  }

  //send message
  void SendMessage() async {
    if(messageController.text.isNotEmpty){
      await chatService.SendMessage(widget.receiverId, messageController.text);
      messageController.clear();
    }

    ScrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text(widget.receiverEmail, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blueGrey[400],
      ),
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
      stream: chatService.GetAllMessages(senderId, widget.receiverId), 
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
          controller: scrollController,
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
      child: ChatBubble(message: data["messageText"], isCurrentUser: isCurrentUser, messageId: doc.id, onLongPress: ShowOptions,),
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
            controller: messageController,
            focusNode: focusNode,
          )),
      
          Container(

            child: IconButton(
              onPressed: SendMessage, 
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}