import 'package:flutter/material.dart';
import 'package:story_flakes/data/project.dart';
import 'package:story_flakes/project_branch_page.dart';

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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: project.snowflakeBranches.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectBranchPage(
                  project: project,
                  branch: project.snowflakeBranches.keys.elementAt(index),
                )));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.primaries[index % Colors.primaries.length],
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  alignment: Alignment.centerLeft,
                  height: 120,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Container(
                          alignment: Alignment.center,
                          child: project.snowflakeBranches.values.elementAt(index),
                        ),
                      ),
                      Expanded(
                        child: Text(project.snowflakeBranches.keys.elementAt(index), style: const TextStyle(fontSize: 24),),
                      )
                    ],
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}
