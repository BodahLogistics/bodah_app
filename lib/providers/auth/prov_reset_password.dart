// ignore_for_file: non_constant_identifier_names

import 'package:bodah/modals/users.dart';
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

  String _password = "";
  String _confirm_password = "";

  bool _hide = false;
  bool get hide_password => _hide;
  void change_hide_password() {
    _hide = !_hide;
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

  String get password => _password;
  String get confirm_password => _confirm_password;

  Users _user = Users(
    dark_mode: 0,
    id: 0,
    name: "",
    country_id: 0,
    telephone: "",
    deleted: 0,
    is_verified: 0,
    is_active: 0,
  );
  Users get user => _user;

  void change_user(Users user) {
    _user = user;
    notifyListeners();
  }

  void reset() {
    _phone_number = "";
    _password = "";
    _confirm_password = "";
    _first = "";
    _second = "";
    _third = "";
    _fourth = "";
    _fifth = "";
    _sixth = "";
    notifyListeners();
  }
}
