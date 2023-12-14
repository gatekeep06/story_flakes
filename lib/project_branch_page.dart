import 'package:flutter/material.dart';
import 'package:story_flakes/data/branch.dart';
import 'package:story_flakes/data/project_element.dart';
import 'package:story_flakes/editing_pages/element_editing_page.dart';
import 'package:story_flakes/project_element_page.dart';

class ProjectBranchPage extends StatefulWidget {
  final Branch branch;

  const ProjectBranchPage({super.key, required this.branch});

  @override
  State<ProjectBranchPage> createState() => _ProjectBranchPageState();
}

class _ProjectBranchPageState extends State<ProjectBranchPage> {
  @override
  Widget build(BuildContext context) {
    List<ProjectElement> projectElements = widget.branch.projectElements;

    return Scaffold(
      appBar: AppBar(title: Text(widget.branch.name)),
      body: ListView.builder(
        itemCount: projectElements.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectElementPage(projectElement: projectElements[index])))
                  .then((value) {
                    widget.branch.addToRecentlyEdited(index);
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
          ProjectElement newProjectElement = ProjectElement();
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectElementEditingPage(projectElement: newProjectElement)))
              .then((value) {
            if (value) {
              setState(() {
                projectElements.add(newProjectElement);
                widget.branch.addToRecentlyEdited(projectElements.length - 1);
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
