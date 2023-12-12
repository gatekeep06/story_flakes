import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_flakes/data/element_field.dart';

class ProjectElement {
  String name;
  File? image;
  List<ElementField> fieldList = [];
  Map<int, String> connectionMap = {};
  List<String>? tags;

  ProjectElement({this.name = "", this.image, this.tags});

  String getTagString() {
    if (tags != null) {
      Iterator iterator = tags!.iterator;
      StringBuffer string = StringBuffer();
      while (true) {
        if (iterator.moveNext()) {
          string.write(iterator.current);
          string.write(", ");
        }
        else {
          return string.toString();
        }
      }
    }
    return "";
  }
}