import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/Colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int _selectedpage = 2;
  late PageController pageController;
  Uint8List? _post;
  List<String> _selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();

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

  Future<void> _selectImage() async {
    final XFile? pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImages.add(pickedImage.path);
      });
    }
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
            onPressed: () async {
              // await StorageMethods().uploadImage(
              //     'posts', _selectedImages[index], true);
            },
            icon: const Icon(Icons.arrow_forward),
            color: Colors.blueAccent,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _selectedImages.isNotEmpty
                      ? ListView.builder(
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Image.network(_selectedImages[index]);
                    },
                  )
                      : Placeholder(),
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            color: Colors.blueAccent,
            child: Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemCount: _selectedImages.length + 1,
                itemBuilder: (context, index) {
                  if (index < _selectedImages.length) {
                    return Image.network(_selectedImages[index]);
                  } else {
                    return Container(
                      color: Colors.grey[200],
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _selectImage,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
