import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/methods/storage.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/screens/login.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_Input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _avatar;

  //TODO: ADD THIS TO AUTH CLASS
  Future<String> signup(String email, String passwd, String userName, Uint8List pfp) async {
    String res = 'Some error in Signup function';
    setState(() {
      _isLoading = true;
    });
    try {
      if (email.isNotEmpty || passwd.isNotEmpty || userName.isNotEmpty) {
        //Create User Account
        UserCredential cred =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: passwd,
        );

        //Store Avatar to Database
        String photoUrl =
            await StorageMethods().uploadImage('avatar', pfp, false);

        //Add user details to database
        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
          userName: userName,
          password: passwd,
          avatarUrl: photoUrl,
          followers: [],
          following: [],
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set(
              user.toJson(),
            );
        String res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = 'Password is weak';
      }
    } catch (err) {
      res = err.toString();
    }
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    }
    return res;
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _avatar = im;
    });
  }
  pickImage(ImageSource source) async {
    ImagePicker img = ImagePicker();
    XFile? _file = await img.pickImage(source: source);
    if (_file != null) {
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
                    _avatar != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_avatar!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2023/03/06/11/39/ai-generated-7833307_1280.jpg'),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
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
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Log in.",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
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
