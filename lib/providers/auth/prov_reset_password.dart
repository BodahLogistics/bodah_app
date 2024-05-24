// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProvResetPassword with ChangeNotifier {
  String _phone_number = "";

  bool _affiche = false;
  bool get affiche => _affiche;

  String get phone_number => _phone_number;

  void change_phone_number(String? value) {
    _phone_number = value!;
    notifyListeners();
  }

  void change_affiche(bool? value) {
    _affiche = value!;
    notifyListeners();
  }
}
