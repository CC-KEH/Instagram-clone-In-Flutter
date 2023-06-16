import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;

  const ResponsiveLayout({
    super.key,
    required this.WebScreenLayout,
    required this.MobileScreenLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenWidth) {
          //Web Screen layout
          return WebScreenLayout;
        } else {
          //Mobile Screen layout
          return MobileScreenLayout;
        }
      },
    );
  }
}
