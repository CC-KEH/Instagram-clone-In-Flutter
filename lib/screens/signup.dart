import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/widgets/text_field_Input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwdController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();
  Uint8List? _avatar;
  Future<String> signup(String email, String passwd, String userName,Uint8List pfp) async {
    String res = 'Some error in Signup function';
    try {
      if(email.isNotEmpty || passwd.isNotEmpty || userName.isNotEmpty ){
        //Create User Account
        UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: passwd,

        );
        //Add user details to database
        await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
          'username': userName,
          'ID': cred.user!.uid,
          'email': email,
          'password': passwd,
          'avatar' : pfp,
          'followers' : [],
          'following' : [],
        });
        String res = 'success';
    }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  void selectImage() async{
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _avatar = im;
    });
  }

   pickImage(ImageSource source) async {
    ImagePicker img = ImagePicker();
    XFile? _file = await img.pickImage(source: source);
    if(_file != null){
      return await _file.readAsBytes();
    }
    print('No image selected!');

  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwdController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Image.asset(
                  'assets/images/insta_logo.png',
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                // AVATAR
                Stack(
                  children: [
                    _avatar != null ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_avatar!),
                    ) : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/64/62/36/360_F_364623623_ERzQYfO4HHHyawYkJ16tREsizLyvcaeg.jpg'),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {selectImage();},
                        icon: Icon(Icons.add_a_photo_outlined),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // USERNAME
                TextFieldInput(
                  label: 'Username',
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  controller: _usernameController,
                ),
                const SizedBox(height: 12),
                // EMAIL
                TextFieldInput(
                  label: 'Email',
                  hintText: 'Enter your email',
                  textInputType: TextInputType.text,
                  controller: _emailController,
                ),
                const SizedBox(height: 12),
                // PASSWORD
                TextFieldInput(
                  label: 'Password',
                  hintText: 'Enter your password',
                  ispasswd: true,
                  textInputType: TextInputType.text,
                  controller: _passwdController,
                ),
                const SizedBox(height: 12),
                // BUTTON
                GestureDetector(
                  onTap: () async {
                    await signup(
                      _emailController.text,
                      _passwdController.text,
                      _usernameController.text,
                      _avatar!,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        ' Log in.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
