import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;

  const SignUpPage({super.key, required this.emailEditingController, required this.passwordEditingController});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController loginEditingController = TextEditingController();
  late final TextEditingController emailEditingController;
  late final TextEditingController passwordEditingController;
  bool isLoginEmpty = false;
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  String errorText = "";
  bool _obscureText = true;

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    emailEditingController = widget.emailEditingController;
    passwordEditingController = widget.passwordEditingController;
    super.initState();
  }

  void signUp() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailEditingController.text,
        password: passwordEditingController.text,
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailEditingController.text,
        password: passwordEditingController.text,
      );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(loginEditingController.text);
      Navigator.pop(context);
    }
    on FirebaseAuthException catch(e) {
      switch (e.code) {
        case "weak-password": errorText = "Your password is too weak"; break;
        case "invalid-email": errorText = "There is something strange with your email"; break;
        case "email-already-in-use": errorText = " The email is already in use\nAre you sure you don't have an account?"; break;
        default:
          ConnectivityResult res = await Connectivity().checkConnectivity();
          if (res != ConnectivityResult.wifi && res != ConnectivityResult.mobile && res != ConnectivityResult.ethernet) {
            errorText = "Connection lost\nRestore it and try again";
          }
          else {
            isLoginEmpty = loginEditingController.text.isEmpty;
            isEmailEmpty = emailEditingController.text.isEmpty;
            isPasswordEmpty = passwordEditingController.text.isEmpty;
          }
          break;
      }
      setState(() {});
    }
    finally {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Sign Up")),
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
                  controller: loginEditingController,
                  onChanged: (value) {
                    setState(() {
                      isLoginEmpty = value.isEmpty;
                      errorText = "";
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Login",
                      border: const OutlineInputBorder(),
                      errorText: isLoginEmpty ? "Enter your login" : null
                  ),
                ),
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
                        icon: Icon(_obscureText ? Icons.visibility : Icons
                            .visibility_off),
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
                    signUp();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 80.0),
                    decoration: ShapeDecoration(
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                        "Sign Up", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 50.0),
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {

                  },
                  child: const Text("Sign In", style: TextStyle(
                      decoration: TextDecoration.underline, fontSize: 16.0)),
                ),
              ],
            ),
          ),
        )
    );
  }
}
