import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Firebaseauthseervice{
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signUp( String email, String password) async {
    try{
      UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(e){
      print('Some Error Occured');
    }
    return null;
  }

  Future<User?> signIn( String email, String password) async {
    try{
      UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(e){
      print('Some Error Occurred');
    }
    return null;
  }
}