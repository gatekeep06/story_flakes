import 'package:story_flakes/data/project.dart';

class ProjectMap {
  static final ProjectMap _projectMap = ProjectMap._internal();
  Map<int, Project> _map = {0: Project(null, name: "dada", description: "dadadad")};

  factory ProjectMap() {
    return _projectMap;
  }

  ProjectMap._internal();

  Map<int, Project> getMap() {
    return _map;
  }

  bool addToMap(int id, Project project) {
    if (_map.containsKey(id)) {
      return false;
    }
    else {
      _map[id] = project;
      return true;
    }
  }

  bool removeFromMap(int id) {
    if (!_map.containsKey(id)) {
      return false;
    }
    else {
      _map.remove(id);
      return true;
    }
  }
}