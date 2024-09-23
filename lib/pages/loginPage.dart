// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:chatr/authStuff/auth.dart';
import 'package:chatr/components/customButton.dart';
import 'package:chatr/components/customTextField.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  TextEditingController usernameController  = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void Login(BuildContext context) async{
    Auth auth = Auth();

    try{
      await auth.LoginWithEmailAndPassword(usernameController.text, passwordController.text);
    }
    catch(e){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //logo
          Icon(Icons.message, size: 66, color: Theme.of(context).colorScheme.primary,),

          SizedBox(height: 30,),

          //flashy text
          Text('Welcome back!', style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 22),),

          SizedBox(height: 25,),

          //username
          CustomTextField(
            hintText: "Email",
            hideText: false,
            controller: usernameController,

          ),

          SizedBox(height: 15,),

          //password field
          CustomTextField(
            hintText: "Passowrd",
            hideText: true,
            controller: passwordController,
          ),
        
          SizedBox(height: 25,),

          //login button
          CustomButton(
            text: "Login",
            onTap: ()=>Login(context),
          ),

          SizedBox(height: 30,),

          //new user/register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("New user? ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
              )),

              GestureDetector(
                onTap: onTap,
                child: Text("Register Now!", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        
          ],
        ),
      ),
    );
  }
}