import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as model;

class AuthMethods{
//TODO: ADD THIS TO AUTH CLASS
  Future<model.User> getUserDetails() async{
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

}