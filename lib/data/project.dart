import 'dart:io';

import 'package:flutter/material.dart';
import 'package:story_flakes/data/project_element.dart';

class Project {
  String name;
  String description;
  Widget? _icon;
  final Map<String, Widget> snowflakeBranches = {
    "Timeline": const Icon(Icons.timeline, size: 40),
    "Characters": const Icon(Icons.person, size: 40),
    "World": const Icon(Icons.home_work_outlined, size: 40)
  };
  Map<String, List<ProjectElement>> projectElements = {
    "Timeline": [ProjectElement(name: "name", tags: ["123", "123", "123"])],
    "Characters": [],
    "World": []
  };

  Project(Widget? icon, {required this.name, required this.description}) {
    _icon = icon;
  }

  Widget getIcon() {
    if (_icon == null) {
      return const Icon(Icons.file_copy_outlined);
    }
    else {
      return _icon!;
    }
  }
}