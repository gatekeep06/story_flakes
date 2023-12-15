import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  String errorText = "";

  void logIn() async {
    try {
      showDialog(context: context, barrierDismissible: false, builder: (context) {
        return const SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text
      );
    }
    catch(e) {
      ConnectivityResult res = await Connectivity().checkConnectivity();
      if (res != ConnectivityResult.wifi && res != ConnectivityResult.mobile && res != ConnectivityResult.ethernet) {
        setState(() {
          errorText = "Connection lost. Try to restore it and try again";
        });
      }
      else {
        setState(() {
          isEmailEmpty = emailEditingController.text.isEmpty;
          isPasswordEmpty = passwordEditingController.text.isEmpty;
          errorText = "Cannot sign in with this data";
        });
      }
    }
    finally {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log In")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.lock, size: 100.0,),
              SizedBox(height: 20.0,),
              Text(errorText, style: TextStyle(color: Colors.red)),
              TextField(
                controller: emailEditingController,
                onChanged: (value) {
                  setState(() {
                    isEmailEmpty = value.isEmpty;
                    errorText = "";
                  });
                },
                decoration: InputDecoration(
                    errorText: isEmailEmpty ? "Enter your email" : null
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                controller: passwordEditingController,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    isPasswordEmpty = value.isEmpty;
                    errorText = "";
                  });
                },
                decoration: InputDecoration(
                  errorText: isPasswordEmpty ? "Enter your password" : null
                ),
              ),
              TextButton(
                onPressed: () {
                  logIn();
                },
                child: Text("log in"),
              ),
            ],
          ),
        ),
      )
    );
  }
}
