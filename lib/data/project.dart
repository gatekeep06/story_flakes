import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_flakes/data/branch.dart';
import 'package:story_flakes/data/project_element.dart';

class Project {
  String name;
  String description;
  File? image;
  final List<Branch> branches = [Branch(name: "Timeline"), Branch(name: "Characters"), Branch(name: "World")];

  Project({this.name = "", this.description = "", this.image});
}