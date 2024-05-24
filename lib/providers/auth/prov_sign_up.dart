// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProvSignUp with ChangeNotifier {
  String _code = "";
  String get code => _code;
  void change_code(String? value) {
    _code = value!;
    notifyListeners();
  }

  String _nom = "";
  String _adresse = "";
  String _telephone = "";
  String _password = "";
  String _confirm_password = "";
  bool _accepte = false;
  bool _affiche = false;
  bool _hide = false;
  bool get hide_password => _hide;
  void change_hide_password() {
    _hide = !_hide;
    notifyListeners();
  }

  String get nom => _nom;
  String get adresse => _adresse;
  String get telephone => _telephone;
  String get password => _password;
  String get confirm_password => _confirm_password;
  bool get accepte => _accepte;
  bool get affiche => _affiche;

  void change_nom(String? value) {
    _nom = value!;
    notifyListeners();
  }

  void change_adresse(String? value) {
    _adresse = value!;
    notifyListeners();
  }

  void change_telephone(String? value) {
    _telephone = value!;
    notifyListeners();
  }

  void change_password(String? value) {
    _password = value!;
    notifyListeners();
  }

  void change_confirm_password(String value) {
    _confirm_password = value;
    notifyListeners();
  }

  void change_accepte(bool? value) {
    _accepte = value!;
    notifyListeners();
  }

  void change_affiche(bool? value) {
    _affiche = value!;
    notifyListeners();
  }
}
