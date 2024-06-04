// ignore_for_file: non_constant_identifier_names

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/rules.dart';
import 'package:bodah/modals/statuts.dart';
import 'package:bodah/modals/villes.dart';
import 'package:flutter/material.dart';

import '../../modals/users.dart';

class ProvSignUp with ChangeNotifier {
  String _code = "";
  String get code => _code;
  void change_code(String? value) {
    _code = value!;
    notifyListeners();
  }

  Rules _rule = Rules(id: 0, nom: "");
  Statuts _statut = Statuts(id: 0, name: "");

  Rules get rule => _rule;
  Statuts get statut => _statut;

  void change_rule(Rules rule) {
    _rule = rule;
    notifyListeners();
  }

  void change_statut(Statuts statut) {
    _statut = statut;
    notifyListeners();
  }

  Pays _pay = Pays(id: 0, name: "", flag: "", country_code: "");
  Villes _ville = Villes(id: 0, name: "", country_id: 0);

  Pays get pay => _pay;
  Villes get ville => _ville;
  void change_pays(Pays pay) {
    _pay = pay;
    notifyListeners();
  }

  void change_ville(Villes ville) {
    _ville = ville;
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
    _rule = Rules(id: 0, nom: "");
    _statut = Statuts(id: 0, name: "");
    _pay = Pays(id: 0, name: "", flag: "", country_code: "");
    _ville = Villes(id: 0, name: "", country_id: 0);
    _nom = "";
    _password = "";
    _confirm_password = "";
    _telephone = "";
    notifyListeners();
  }
}
