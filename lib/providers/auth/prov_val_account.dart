// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';

class ProvValiAccount with ChangeNotifier {
  String _first = "";
  String get first => _first;
  void change_first(String value) {
    _first = value;
    notifyListeners();
  }

  String _second = "";
  String get second => _second;
  void change_second(String value) {
    _second = value;
    notifyListeners();
  }

  String _third = "";
  String get third => _third;
  void change_third(String value) {
    _third = value;
    notifyListeners();
  }

  String _fourth = "";
  String get fourth => _fourth;
  void change_fourth(String value) {
    _fourth = value;
    notifyListeners();
  }

  String _fifth = "";
  String get fifth => _fifth;
  void change_fifth(String value) {
    _fifth = value;
    notifyListeners();
  }

  String _sixth = "";
  String get sixth => _sixth;
  void change_sixth(String value) {
    _sixth = value;
    notifyListeners();
  }

  bool _affiche = false;
  bool get affiche => _affiche;
  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }

  void reset() {
    _first = "";
    _second = "";
    _third = "";
    _fourth = "";
    _fifth = "";
    _sixth = "";
    notifyListeners();
  }
}
