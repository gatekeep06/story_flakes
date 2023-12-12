import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_flakes/data/project_element.dart';

class Project {
  String name;
  String description;
  File? image;
  final Map<String, Widget> snowflakeBranches = {
    "Timeline": const Icon(Icons.timeline, size: 40),
    "Characters": const Icon(Icons.person, size: 40),
    "World": const Icon(Icons.home_work_outlined, size: 40)
  };
  Map<String, List<ProjectElement>> projectElements = {
    "Timeline": [],
    "Characters": [],
    "World": []
  };

  Project({this.name = "", this.description = "", this.image});
}