import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:story_flakes/mobile_home_page.dart';

void main() => runApp(const StoryFlakesApp());

class StoryFlakesApp extends StatelessWidget {
  const StoryFlakesApp({super.key});

  StatefulWidget _getStartMenu() {
    if (Platform.isAndroid || Platform.isIOS) {
      return const MobileHomePage();
    }
    else {
      return const MobileHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MobileHomePage()
    );
  }

}