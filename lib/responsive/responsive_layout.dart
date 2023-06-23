import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;

  const ResponsiveLayout({
    super.key,
    required this.WebScreenLayout,
    required this.MobileScreenLayout,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
 }
  addData() async{
    UserProvider _userProvider = Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenWidth) {
          //Web Screen layout
          return widget.WebScreenLayout;
        } else {
          //Mobile Screen layout
          return widget.MobileScreenLayout;
        }
      },
    );
  }
}
