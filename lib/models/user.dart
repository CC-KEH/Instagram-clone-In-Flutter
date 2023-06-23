import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String uid;
  final String email;
  final String userName;
  final String password;
  final String avatarUrl;
  final List followers;
  final List following;

  const User({
    required this.uid,
    required this.email,
    required this.userName,
    required this.password,
    required this.avatarUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': userName,
        'password': password,
        'avatarUrl': avatarUrl,
        'followers': followers,
        'following': following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      userName: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      avatarUrl: snapshot['avatarUrl'],
      password: snapshot['password'],
    );
  }
}
