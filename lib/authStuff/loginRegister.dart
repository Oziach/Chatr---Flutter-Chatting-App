// ignore_for_file: file_names

import 'package:chatr/pages/loginPage.dart';
import 'package:chatr/pages/registerPage.dart';
import 'package:flutter/material.dart';

class LoginRegister extends StatefulWidget {
  
  LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool showLogin = true;

  void toggleAuthPage(){
    
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return LoginPage(
        onTap: toggleAuthPage,
      );
    }
    else{
      return RegisterPage(
        onTap: toggleAuthPage,
      );
    }
  }
}