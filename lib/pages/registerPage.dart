// ignore_for_file: file_names, prefer_const_constructors

import 'package:chatr/authStuff/auth.dart';
import 'package:chatr/components/customButton.dart';
import 'package:chatr/components/customTextField.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  
  void Function()? onTap;
  
  RegisterPage({super.key, required this.onTap});
  
  TextEditingController usernameController  = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  void Register(BuildContext context){

    //if confirm password is right, reg new user
    if(passwordController.text == confirmPasswordController.text){
      Auth auth = Auth();
      try{
        auth.RegisterWithEmailAndPassword(usernameController.text, passwordController.text);
      }
      catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: Text(e.toString()),
        )
      );
      }
    }
    else{ //if passowrds don't match, show error
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match!...dumass"),
        ),
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
          Text('Create your account', style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 22),),

          SizedBox(height: 25,),

          //username
          CustomTextField(
            hintText: "Username",
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

          SizedBox(height: 15,),

          //confirm password field
          CustomTextField(
            hintText: "Confirm Password",
            hideText: true,
            controller: confirmPasswordController,
          ),
        
        
          SizedBox(height: 25,),

          //register button
          CustomButton(
            text: "Register",
            onTap: () => Register(context),
          ),

          SizedBox(height: 30,),

          //new user/register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Existing user? ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
              )),

              GestureDetector(
                onTap: onTap,
                child: Text("Login", 
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