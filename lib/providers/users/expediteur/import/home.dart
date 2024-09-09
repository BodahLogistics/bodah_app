// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProvHoImport with ChangeNotifier {
  int _current_index = 0;
  int get current_index => _current_index;
  void change_index(int value) {
    _current_index = value;
    notifyListeners();
  }
}
