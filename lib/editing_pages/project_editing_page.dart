import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_flakes/data/project.dart';

class ProjectEditingPage extends StatefulWidget {
  final Project project;

  const ProjectEditingPage({super.key, required this.project});

  @override
  State<ProjectEditingPage> createState() => _ProjectEditingPageState();
}

class _ProjectEditingPageState extends State<ProjectEditingPage> {
  late Project project;
  late String name;
  late String description;
  File? image;

  @override
  void initState() {
    super.initState();
    project = widget.project;
    name = project.name;
    description = project.description;
    image = project.image;
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
          title: const Text("Project editing"),
          actions: [
            IconButton(
              onPressed: () {
                project.name = name;
                project.description = description;
                project.image = image;
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
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (string) {
                    name = string;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  onChanged: (string) {
                    description = string;
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
        )
      ),
    );
  }
}
