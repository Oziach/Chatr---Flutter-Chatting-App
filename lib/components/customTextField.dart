// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  String hintText;
  bool hideText = false;
  TextEditingController controller;

  CustomTextField({super.key, required this.hintText, required this.hideText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: hideText,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),

          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,

          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),

          
        ),
      ),
    );
  }
}