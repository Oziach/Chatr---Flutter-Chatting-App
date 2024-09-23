import 'package:chatr/authStuff/auth.dart';
import 'package:chatr/chatStuff/ChatService.dart';
import 'package:chatr/components/customDrawer.dart';
import 'package:chatr/components/userTile.dart';
import 'package:chatr/pages/chatPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {

 

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: CustomDrawer(),
      body: BuildUserList(),
    );
  }

  //build user list
  Widget BuildUserList(){
    return StreamBuilder(
      stream: chatService.GetUsersStream(), 
      builder: (context, snapshot){
        //error 
        if(snapshot.hasError){
          return const Text("Error");
        }

        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading...");
        }
        
        //return list view
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => BuildUserListItem(userData, context)).toList(),
        );
      }
    );
  }

  Widget BuildUserListItem(Map<String, dynamic> userData, BuildContext context){
    //display all users except current user 
    if(userData["email"] != auth.GetCurrentUser()?.email){
      return UserTile(
        text: userData["email"],
        onTap: (){
          //go to resprective chat page for that user
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverId: userData["uid"],
              ),
            ),
          );
        },
      );
    }
    else{
      return Container();
    }
  }

}