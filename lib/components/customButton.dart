// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String text;
  void Function()? onTap;

  CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {


    return  GestureDetector(

      onTap: onTap,

      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 20),
        
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          )
        ),
      ),
    );
  }
}