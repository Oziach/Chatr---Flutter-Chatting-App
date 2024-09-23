import 'package:chatr/authStuff/auth.dart';
import 'package:chatr/chatStuff/ChatService.dart';
import 'package:chatr/components/addChatterPopup.dart';
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
        centerTitle: true,
        title: Text("Home", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: CustomDrawer(),
      body: BuildUserList(),

      floatingActionButton: SizedBox(

        width: 75,
        child: FloatingActionButton(
          
          onPressed: () => ShowAddFriendPopup(context),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.people),
              Icon(Icons.add),
              ]
            
            ),
          ),
        ),
      ),
    );
  }

  //build user list
  Widget BuildUserList(){

    return StreamBuilder(
      stream: chatService.GetChattersStream(), 
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

  void ShowAddFriendPopup(BuildContext context){
    showDialog(
      context: context, 
      builder: (conetxt) => AddChatterPopup()
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