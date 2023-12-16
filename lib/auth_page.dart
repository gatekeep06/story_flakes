import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:story_flakes/sign_in_page.dart';
import 'package:story_flakes/mobile_home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (FirebaseAuth.instance.currentUser != null) {
            FirebaseAuth.instance.currentUser!.reload();
            return const MobileHomePage();
          }
          else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
