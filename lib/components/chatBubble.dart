import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final void Function(BuildContext context, String messageId) onLongPress;

  const ChatBubble({super.key, required this.message, required this.isCurrentUser, required this.onLongPress, required this.messageId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onLongPress:()=>{
        if(isCurrentUser){
          onLongPress(context, messageId)
        }
      },

      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isCurrentUser ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}