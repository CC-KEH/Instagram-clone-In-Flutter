import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email = "";
  String _password = "";
  Future signup() async {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } catch (e, s) {
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
