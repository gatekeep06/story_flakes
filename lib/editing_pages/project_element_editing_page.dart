import 'package:flutter/material.dart';
import 'package:story_flakes/data/project_element.dart';

class ProjectElementEditingPage extends StatefulWidget {
  final ProjectElement projectElement;

  const ProjectElementEditingPage({super.key, required this.projectElement});

  @override
  State<ProjectElementEditingPage> createState() => _ProjectElementEditingPageState();
}

class _ProjectElementEditingPageState extends State<ProjectElementEditingPage> {
  String? _name;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    ProjectElement projectElement = widget.projectElement;

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
                projectElement.name = _name != null ? _name! : "";
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
                    onTap: () {
                      projectElement.changeImage(this);
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: projectElement.image != null ? FileImage(projectElement.image!) : null,
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
                    _name = string;
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

