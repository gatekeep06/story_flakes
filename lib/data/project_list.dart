import 'package:story_flakes/data/project.dart';

class ProjectList {
  static final ProjectList _projectList = ProjectList._internal();
  List<Project> list = [Project(name: "dada", description: "dadadad")];

  factory ProjectList() {
    return _projectList;
  }

  ProjectList._internal();
}