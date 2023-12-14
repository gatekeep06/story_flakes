import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:story_flakes/mobile_home_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const StoryFlakesApp());
}

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