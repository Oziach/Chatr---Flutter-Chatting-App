import 'package:chatr/chatStuff/ChatService.dart';
import 'package:chatr/components/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddChatterPopup extends StatelessWidget {
  AddChatterPopup({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
  
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add a friend to chat with!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 20
                )
              ),
          
              SizedBox(height: 25,),
          
              //input field
              TextField(
                style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                decoration:  InputDecoration(
                  isDense: true,
                  hintText: "friend@example.com",
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                controller: emailController,
              ),
          
              SizedBox(height: 20,),

               //cancel button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text("Cancel", style: TextStyle(color: Theme.of(context).colorScheme.tertiary),)
                ),
                
                SizedBox(width: 10,),

                //add button
                TextButton(
                  onPressed: () {
                    ChatService().AddToChatters(emailController.text);
                    Navigator.pop(context);
                  } ,
                  child: Text("Add", style: TextStyle(color: Theme.of(context).colorScheme.primary,)),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}