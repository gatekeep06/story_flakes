import 'package:flutter/material.dart';

abstract class DataBaseRequester<T> {
  int getIdByName(String name);

  bool compare(T t);

  T requestData(int id);

  bool pushDataChanges(T t);
}