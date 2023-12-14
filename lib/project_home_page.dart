import 'package:flutter/material.dart';
import 'package:story_flakes/data/project.dart';
import 'package:story_flakes/project_branch_page.dart';
import 'package:story_flakes/project_element_page.dart';

class ProjectHomePage extends StatefulWidget {
  final Project project;

  const ProjectHomePage({super.key, required this.project});

  @override
  State<ProjectHomePage> createState() => _ProjectHomePageState();
}

class _ProjectHomePageState extends State<ProjectHomePage> {
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;
    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: project.branches.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ProjectBranchPage(branch: project.branches[index],)))
                            .then((value) => setState(() {}));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.primaries[index % Colors.primaries.length],
                                borderRadius: BorderRadius.circular(15.0)
                            ),
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(project.branches[index].name),
                                  ),
                                  const Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ),
                          ),
                          project.branches[index].recentlyEdited.isNotEmpty ? const Text("Recently edited") : const Text(""),
                          ListView.builder(
                            shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: project.branches[index].recentlyEdited.length,
                              itemBuilder: (BuildContext context, int recentlyEditedIndex) {
                                return Row(
                                  children: [
                                    const Icon(Icons.shortcut),
                                    Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                ProjectElementPage(projectElement: project.branches[index].projectElements[project.branches[index].recentlyEdited[recentlyEditedIndex]])))
                                                .then((value) => setState(() {}));
                                          },
                                          child: SizedBox(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                                                child: Text(project.branches[index].projectElements[project.branches[index].recentlyEdited[recentlyEditedIndex]].name),
                                              ),
                                            ),
                                          )
                                      ),
                                    )
                                  ],
                                );
                              }
                          ),
                        ],
                      )
                  ),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}
