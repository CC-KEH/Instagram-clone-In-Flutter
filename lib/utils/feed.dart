import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/Colors.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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
    );
  }
}
