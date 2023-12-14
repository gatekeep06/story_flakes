import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_flakes/data/project_element.dart';

class ProjectElementEditingPage extends StatefulWidget {
  final ProjectElement projectElement;

  const ProjectElementEditingPage({super.key, required this.projectElement});

  @override
  State<ProjectElementEditingPage> createState() => _ProjectElementEditingPageState();
}

class _ProjectElementEditingPageState extends State<ProjectElementEditingPage> {
  int? _selectedIndex;
  late ProjectElement projectElement;
  late String name;
  File? image;

  @override
  void initState() {
    super.initState();
    projectElement = widget.projectElement;
    name = projectElement.name;
    image = projectElement.image;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Project Element"),
          actions: [
            IconButton(
              onPressed: () {
                projectElement.name = name;
                projectElement.image = image;
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.check_circle_outline),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              icon: const Icon(Icons.cancel_outlined),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 240,
                  width: 240,
                  child: GestureDetector(
                    onTap: () async {
                      var file = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {
                        image = file != null ? File(file.path) : image;
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: image != null ? FileImage(image!) : null,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                child: TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (string) {
                    name = string;
                  },
                ),
              ),
              // ListView.builder(
              //   itemCount: 0,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Padding(
              //       padding: const EdgeInsets.only(top: 10.0, left: 2.0, right: 2.0),
              //       child: Card(
              //
              //       ),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}

