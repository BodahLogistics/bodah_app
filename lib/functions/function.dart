// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/rules.dart';
import '../modals/users.dart';

class Functions {
  bool hasRole(List<Rules> rules, String role) {
    return rules.any((data) => data.nom == role);
  }

  Color convertHexToColor(String hexColor) {
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    return Color(int.parse(hexColor, radix: 16));
  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  bool existing_phone_number(List<Users> users, String phone_number) {
    bool any = users.any((element) => element.telephone == phone_number);
    return any;
  }
}
