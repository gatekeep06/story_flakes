import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:story_flakes/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  String errorText = "";
  bool _obscureText = true;

  void signIn() async {
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
          errorText = "Connection lost\nRestore it and try again";
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
      appBar: AppBar(title: const Text("Sign In")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.lock, size: 100.0,),
              SizedBox(height: 20.0,),
              Text(errorText, style: TextStyle(color: Colors.red)),
              SizedBox(height: 10.0),
              TextField(
                controller: emailEditingController,
                onChanged: (value) {
                  setState(() {
                    isEmailEmpty = value.isEmpty;
                    errorText = "";
                  });
                },
                decoration: InputDecoration(
                    labelText: "Email",
                    border: const OutlineInputBorder(),
                    errorText: isEmailEmpty ? "Enter your email" : null
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: passwordEditingController,
                obscureText: _obscureText,
                onChanged: (value) {
                  setState(() {
                    isPasswordEmpty = value.isEmpty;
                    errorText = "";
                  });
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  errorText: isPasswordEmpty ? "Enter your password" : null
                ),
              ),
              SizedBox(height: 30.0),
              TextButton(
                onPressed: () {
                  signIn();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 80.0),
                  decoration: ShapeDecoration(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text("Sign In", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 50.0),
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(
                    emailEditingController: emailEditingController,
                    passwordEditingController: passwordEditingController,
                  )));
                },
                child: const Text("Sign Up", style: TextStyle(decoration: TextDecoration.underline, fontSize: 16.0)),
              ),
            ],
          ),
        ),
      )
    );
  }
}
