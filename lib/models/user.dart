import 'package:flutter/material.dart';

class User {
  final String uuid;
  final String email;
  final String userName;
  final String password;
  final String avatarUrl;
  final List followers;
  final List following;

  const User({
    required this.uuid,
    required this.email,
    required this.userName,
    required this.password,
    required this.avatarUrl,
    required this.followers,
    required this.following,
  });
  Map<String,dynamic> toJson()=>{
    'uuid':uuid,
    'email':email,
    'username':userName,
    'password':password,
    'avatarUrl':avatarUrl,
    'followers':followers,
    'following':following,
  };

}
