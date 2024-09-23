import 'package:chatr/authStuff/loginRegister.dart';
import 'package:chatr/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          //user is logged in
          if(snapshot.hasData){
            return HomePage();
          }
          else{
            return LoginRegister();
          }
        }
      );
  }
}