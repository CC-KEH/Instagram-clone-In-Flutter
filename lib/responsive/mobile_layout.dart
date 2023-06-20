import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/Colors.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  String? username = "";

  int _selectedpage = 0;
  late PageController pageController;



  void navigationTap(int page){


  }
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getUserName(); //initState cannot be async
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/insta_logo.png',
          scale: 15,
          color: Colors.white,
        ),
        actions: [
          Icon(
             Icons.favorite,
             size: 35,
          ),
          Text('     '),
          Icon(
            Icons.telegram,
            size: 35,
          ),
          Text('   '),
        ],
        backgroundColor: mobileBackgroundColor,
      ),
      body: Center(
        child: Text('This is mobile: $username'),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        onTap: (index){
          setState(() {
            _selectedpage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedpage ==0 ? Colors.white : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _selectedpage ==1 ? Colors.white : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              color: _selectedpage ==2 ? Colors.white : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie_creation_outlined,
              color: _selectedpage ==3 ? Colors.white : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedpage ==4 ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
