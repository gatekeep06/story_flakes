import 'package:flutter/material.dart';
import 'package:story_flakes/data/project.dart';
import 'package:story_flakes/data/project_map.dart';
import 'package:story_flakes/project_home_page.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProjectMap _projectMap;

  @override
  void initState() {
    super.initState();
    _projectMap = ProjectMap();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            ListView.builder(
              itemCount: _projectMap.getMap().length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == _projectMap.getMap().length) {
                  return GestureDetector(
                    onTap: () {
                      print("object");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      alignment: Alignment.center,
                      child: const Column(
                        children: [
                          Text("+", style: TextStyle(color: Colors.blueGrey, fontSize: 64)),
                          Text("Add new project", style: TextStyle(color: Colors.grey, fontSize: 20))
                        ],
                      ),
                    ),
                  );
                }
                Project project = _projectMap.getMap()[index]!;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectHomePage(project: project)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100.0,
                            child: project.getIcon(),
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
            Center(
              child: Text('Tab 2'),
            ),
          ]
      )
    );
  }
}
