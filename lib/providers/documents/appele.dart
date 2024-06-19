// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProvDownloadDocument with ChangeNotifier {
  bool _affiche = false;
  bool get affiche => _affiche;

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }
}
