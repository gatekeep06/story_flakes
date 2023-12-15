import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_flakes/data/element_field.dart';

class ProjectElement {
  String name;
  File? image;
  List<ElementField> fieldList = [];

  ProjectElement({this.name = "", this.image});
}