// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class ProvCalculator extends ChangeNotifier {
  int amount = 0;
  int get montant => amount;
  void change_montant(String? value) {
    amount = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  String _display = '';

  void addDigit(String digit) {
    _display += digit;
    notifyListeners();
  }

  void clearAll() {
    _display = '';
    notifyListeners();
  }

  void delete() {
    if (_display.isNotEmpty) {
      _display = _display.substring(0, _display.length - 1);
      notifyListeners();
    }
  }

  void evaluate() {
    Parser p = Parser();
    Expression exp = p.parse(_display);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);
    _display = result.toString();
    notifyListeners();
  }

  String get display => _display;
}
