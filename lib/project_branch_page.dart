import 'package:flutter/material.dart';
import 'package:story_flakes/data/project_element.dart';
import 'package:story_flakes/editing_pages/project_element_editing_page.dart';
import 'package:story_flakes/project_element_page.dart';

import 'data/project.dart';

class ProjectBranchPage extends StatefulWidget {
  final Project project;
  final String branch;

  const ProjectBranchPage({super.key, required this.project, required this.branch});

  @override
  State<ProjectBranchPage> createState() => _ProjectBranchPageState();
}

class _ProjectBranchPageState extends State<ProjectBranchPage> {
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;
    List<ProjectElement> projectElements = project.projectElements[widget.branch]!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.branch)),
      body: ListView.builder(
        itemCount: projectElements.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectElementPage(projectElement: projectElements[index])))
                  .then((value) {
                    setState(() {});
              });
            },
            onLongPress: () {
              //TODO: menu
              print("looooong");
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: projectElements[index].image != null ? FileImage(projectElements[index].image!) : null,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(projectElements[index].name, style: const TextStyle(fontSize: 24.0)),
                          Text(projectElements[index].getTagString())
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ProjectElement newProjectElement = ProjectElement(name: "3132");
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectElementEditingPage(projectElement: newProjectElement)))
              .then((value) {
            if (value) {
              setState(() {
                projectElements.add(newProjectElement);
              });
            }
          });
        },
        tooltip: "Add new project element",
        child: const Text("+", style: TextStyle(fontSize: 32.0)),
      ),
    );
  }
}
