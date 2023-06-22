import 'package:flutter/material.dart';

import '../widgets/text_field_Input.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  int _selectedpage = 6;
  late PageController pageController;
  final TextEditingController _searchController = TextEditingController();

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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search box
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search',
              ),
              keyboardType: TextInputType.text,
              controller: _searchController,
            ),

            // Stories box (Row Widget)
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.network(
                      'https://cdn.arstechnica.net/wp-content/uploads/2023/03/midjourney_v5_hero_2-800x450.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),

           const SizedBox(
              height: 30,
            ),

            // Text Messages and Requests
            Row(
              children: [
                const Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to requests page
                  },
                  child: const Text(
                    'Requests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            // Contacts list (Column widget)
            // Add your contacts list widgets here
          ],
        ),
      ),
    );
  }
}

