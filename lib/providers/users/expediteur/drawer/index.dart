// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProvDrawExpediteur with ChangeNotifier {
  int _index = 0;
  int get current_index => _index;
  void change_index(int value) {
    _index = value;
    notifyListeners();
  }
}
