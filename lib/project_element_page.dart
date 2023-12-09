import 'package:flutter/material.dart';
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
                    onTap: () {
                      projectElement.changeImage(this);
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
                  padding: const EdgeInsets.only(top: 10.0, left: 2.0, right: 2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(projectElement.fieldList[index].name, style: TextStyle(fontSize: 18.0)),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        FieldEditingPage(elementField: projectElement.fieldList[index])))
                                        .then((value) {
                                          if (value) {
                                            setState(() {});
                                          }
                                    });
                                  },
                                  icon: const Icon(Icons.edit),
                                )
                              )
                            )
                          ],
                        ),
                        Text(projectElement.fieldList[index].description)
                      ],
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
