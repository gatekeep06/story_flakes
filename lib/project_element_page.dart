import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_flakes/data/element_field.dart';
import 'package:story_flakes/data/project_element.dart';
import 'package:story_flakes/editing_pages/field_editing_page.dart';

class ProjectElementPage extends StatefulWidget {
  final ProjectElement projectElement;

  const ProjectElementPage({super.key, required this.projectElement});

  @override
  State<ProjectElementPage> createState() => _ProjectElementPageState();
}

class _ProjectElementPageState extends State<ProjectElementPage> {
  final nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProjectElement projectElement = widget.projectElement;

    return Scaffold(
      appBar: AppBar(title: Text(projectElement.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 240,
                  width: 240,
                  child: GestureDetector(
                    onTap: () async {
                      var file = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {
                        projectElement.image = file != null ? File(file.path) : projectElement.image;
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: projectElement.image != null ? FileImage(projectElement.image!) : null,
                    ),
                  )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(projectElement.name, style: const TextStyle(fontSize: 32)),
                IconButton(
                  onPressed: () {
                    nameEditingController.text = projectElement.name;
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: const Text("Edit"),
                      content: TextField(
                        controller: nameEditingController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              projectElement.name = nameEditingController.text;
                            });
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.ac_unit),
                        ),
                        IconButton(
                          onPressed: () {
                            nameEditingController.text = "";
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.abc),
                        ),
                      ],
                    ));
                  },
                  icon: const Icon(Icons.edit),
                )
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: projectElement.fieldList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          FieldEditingPage(elementField: projectElement.fieldList[index])))
                          .then((value) {
                            if (value) {
                              setState(() {});
                            }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            projectElement.fieldList[index].name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            projectElement.fieldList[index].description,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                ElementField elementField = ElementField();
                Navigator.push(context, MaterialPageRoute(builder: (context) => FieldEditingPage(elementField: elementField)))
                    .then((value) {
                      if (value) {
                        setState(() {
                          projectElement.fieldList.add(elementField);
                        });
                      }
                });
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                child: const Column(
                  children: [
                    Text("+", style: TextStyle(color: Colors.blueGrey, fontSize: 32)),
                    Text("Add new field", style: TextStyle(color: Colors.grey, fontSize: 15))
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
