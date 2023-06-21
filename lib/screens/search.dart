import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<String>> getPostsUrl() async {
    final List<String> imageUrls = [];
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseStorage _storage = FirebaseStorage.instance;
    Reference ref = _storage.ref().child('posts').child(_auth.currentUser!.uid);
    final ListResult result = await ref.listAll();
    for (final item in result.items) {
      final String downloadUrl = await item.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<String>>(
              future: getPostsUrl(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error occurred'));
                }
                final List<String>? imageUrls = snapshot.data;
                if (imageUrls == null || imageUrls.isEmpty) {
                  return const Center(child: Text('No images found'));
                }
                return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(imageUrls[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
