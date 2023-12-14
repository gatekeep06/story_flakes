import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:story_flakes/data/project.dart';
import 'package:story_flakes/data/project_list.dart';
import 'package:story_flakes/editing_pages/project_editing_page.dart';
import 'package:story_flakes/project_home_page.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProjectList _projectList;

  final database = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _projectList = ProjectList();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = database.child("projects");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: TabBar(
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const [
            Tab(text: "mine"),
            Tab(text: "co-authoring")
          ],
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
            insets: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
          ),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _projectList.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        Project project = _projectList.list[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectHomePage(project: project)))
                                .then((value) async {
                                  await ref.push().set(project);
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: project.image != null ? FileImage(project.image!) : null,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          project.name,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          project.description,
                                          style: const TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.ac_unit),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.cloud),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                        onTap: () {
                          Project newProject = Project();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectEditingPage(project: newProject)))
                              .then((value) {
                                if (value) {
                                  setState(() {
                                    _projectList.list.add(newProject);
                                  });
                                }
                          });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '+',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 48,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      'Add new Project',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                    )
                  ]
              ),
            ),
            Center(
              child: Text('Tab 2'),
            ),
          ]
      )
    );
  }
}
