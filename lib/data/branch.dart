import 'package:story_flakes/data/project_element.dart';

class Branch {
  String name;
  List<int> recentlyEdited = [];
  List<ProjectElement> projectElements = [];

  Branch({required this.name});

  void addToRecentlyEdited(int index) {
    if (!recentlyEdited.contains(index)) {
      if (recentlyEdited.length == 3) {
        recentlyEdited.removeAt(0);
      }
      recentlyEdited.add(index);
    }
  }
}