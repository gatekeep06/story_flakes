import 'package:story_flakes/data/project_element.dart';

import 'connection.dart';

class Branch {
  String name;
  List<int> recentlyEdited = [];
  List<ProjectElement> projectElements = [];
  List<Connection> connections = [];

  Branch({required this.name});

  void addToRecentlyEdited(int index) {
    if (!recentlyEdited.contains(index)) {
      if (recentlyEdited.length == 3) {
        recentlyEdited.removeAt(0);
      }
      recentlyEdited.add(index);
    }
  }

  void removeElement(int index) {
    if (projectElements.length >= index) {
      projectElements.removeAt(index);
      for (Connection connection in connections) {
        if (connection.to == index || connection.from == index) {
          connections.remove(connection);
        }
      }
      if (recentlyEdited.contains(index)) {
        recentlyEdited.remove(index);
      }
    }
  }
}