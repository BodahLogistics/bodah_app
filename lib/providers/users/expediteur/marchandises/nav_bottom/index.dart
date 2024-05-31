// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProvNavMarchBottomExp with ChangeNotifier {
  int index = 0;
  int get current_index => index;
  void change_index(int value) {
    index = value;
    notifyListeners();
  }
}
