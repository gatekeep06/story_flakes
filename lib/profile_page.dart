import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 240,
                width: 240,
                child: GestureDetector(
                  onTap: () async {
                    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (xFile != null) {
                      String name = xFile.name;
                      if (FirebaseAuth.instance.currentUser!.photoURL != null) {
                        await FirebaseStorage.instance.refFromURL(FirebaseAuth.instance.currentUser!.photoURL!).delete();
                      }
                      await FirebaseStorage.instance.ref().child("images/user_images/${FirebaseAuth.instance.currentUser!.uid}/avatar/$name")
                          .putFile(File(xFile.path));
                      await FirebaseAuth.instance.currentUser!.updatePhotoURL(await FirebaseStorage.instance.ref()
                          .child("images/user_images/${FirebaseAuth.instance.currentUser!.uid}/avatar/$name").getDownloadURL());
                      setState(() {});
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: FirebaseAuth.instance.currentUser!.photoURL == null ? null : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
