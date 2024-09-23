import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          
          //icon
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Icons.person, color: Theme.of(context).colorScheme.inversePrimary,),
          ),

          //username
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.inversePrimary
            ),
          ),
        ],),
      ),
    );
  }
}