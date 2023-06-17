import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/screens/signup.dart';
import 'package:instagram_clone/utils/Colors.dart';
import 'package:instagram_clone/widgets/text_field_Input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future login(String email,String passwd,) async {
    String res = "Error in login function";
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: passwd);
      res = "Successfully login";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.00),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Container(),
              ),
              //Logo
              Image.asset(
                'assets/images/insta_logo.png',
                color: Colors.white,
              ),
              const SizedBox(
                height: 64,
              ),
              //Email Input
              TextFieldInput(
                  label: 'Email',
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController),
              const SizedBox(
                height: 30,
              ),
              //Password Input
              TextFieldInput(
                label: 'Password',
                hintText: 'Enter Password',
                textInputType: TextInputType.text,
                controller: _passwordController,
                ispasswd: true,
              ),
              const SizedBox(
                height: 30,
              ),
              //Login Button
              GestureDetector(
                onTap: () async{
                  await login(_emailController.text,_passwordController.text);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //Transitioning to Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Don't you have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign up.",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
