import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  //auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get current user
  User? GetCurrentUser(){
    return auth.currentUser;
  }

  //sign in
  Future<UserCredential> LoginWithEmailAndPassword(String email, password) async{

    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

      //save user info
      firestore.collection("Users").doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //register
  Future<UserCredential> RegisterWithEmailAndPassword(String email, password) async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      
      //save user info
      firestore.collection("Users").doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }

  }

  //sign out
  Future<void> Logout() async{
    await auth.signOut();
  }

  //errors idk
}