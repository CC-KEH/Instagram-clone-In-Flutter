import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/Colors.dart';
import 'package:instagram_clone/utils/global_vars.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  void handlePost() {}
  int _selectedpage = 2;
  late PageController pageController;

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
    int _previewHeight = 100;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New post'),
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          iconSize: 40,
          icon: const Icon(Icons.close),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            iconSize: 35,
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
            color: Colors.blueAccent,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2023/03/06/11/39/ai-generated-7833307_1280.jpg"),
                      fit: BoxFit.cover)),
            ),
            Container(
              height: 500,
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              color: Colors.blueAccent,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 137,
                        height: 137,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.amber),
                      ),
                      Container(
                        width: 137,
                        height: 137,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.amber),
                      ),
                      Container(
                        width: 137,
                        height: 137,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.amber),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
