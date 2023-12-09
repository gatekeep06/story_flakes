import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_flakes/data/element_field.dart';

class ProjectElement {
  String name = "";
  File? image;
  List<ElementField> fieldList = [];
  Map<int, String> connectionMap = {};
  List<String> tags = [];

  ProjectElement({String? name, this.image, List<String>? tags}) {
    if (name != null) {
      this.name = name;
    }
    if (tags != null) {
      this.tags = tags;
    }
  }

  String getTagString() {
    Iterator iterator = tags.iterator;
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

  Future changeImage(State state) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state.setState(() {
        image = File(pickedFile.path);
      });
    }
  }
}