// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProvLogOut with ChangeNotifier {
  bool _hide = true;
  String _phone_number = "";
  String _password = "";
  bool _affiche = false;

  String get phone_number => _phone_number;
  String get password => _password;
  bool get hide_password => _hide;
  bool get affiche => _affiche;

  void change_phone_number(String? value) {
    _phone_number = value!;
    notifyListeners();
  }

  void change_password(String? value) {
    _password = value!;
    notifyListeners();
  }

  void change_hide_password() {
    _hide = !_hide;
    notifyListeners();
  }

  void change_affiche(bool? value) {
    _affiche = value!;
    notifyListeners();
  }

  void reset() {
    _phone_number = "";
    _password = "";
    notifyListeners();
  }
}
