import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/Colors.dart';
import 'package:instagram_clone/widgets/text_field_Input.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late PageController pageController;
  int _selectedpage = 2;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _selectedpage = page;
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
            IconButton(
              icon: const Icon(Icons.favorite, size: 30,),
              onPressed:(){},
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Stories box (Row Widget)
              ListView.builder(scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(child: Image.network('https://cdn.arstechnica.net/wp-content/uploads/2023/03/midjourney_v5_hero_2-800x450.jpg'),decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),),);
                },),
              //Recent Posts list (Column widget)
            ],
          ),
        )
    );
  }
}
