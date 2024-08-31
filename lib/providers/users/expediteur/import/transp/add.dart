// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/villes.dart';
import 'package:flutter/material.dart';

import '../../../../../services/data_base_service.dart';

class ProvAddTransp with ChangeNotifier {
  final apiService = DBServices();

  void reset() {
    _villes_exp = [];
    _villes_liv = [];
    _tarif = 0;
    _accompte = 0;
    _solde = 0;
    _pay_exp = Pays(id: 0, name: "");
    _ville_exp = Villes(id: 0, name: "", country_id: 0);
    _cond_name = "";
    _cond_telepehone = "";
    _permis = "";
    _imm = "";
    _pay_liv = Pays(id: 0, name: "");
    _ville_liv = Villes(id: 0, name: "", country_id: 0);
    _affiche = false;
    notifyListeners();
  }

  String _imm = "";
  String _permis = "";
  String _cond_telepehone = "";
  String _cond_name = "";
  bool _loading = false;
  List<Villes> _villes_exp = [];
  List<Villes> _villes_liv = [];
  double _tarif = 0;
  double _accompte = 0;
  double _solde = 0;
  Pays _pay_exp = Pays(id: 0, name: "");
  Villes _ville_exp = Villes(id: 0, name: "", country_id: 0);
  Pays _pay_liv = Pays(id: 0, name: "");
  Villes _ville_liv = Villes(id: 0, name: "", country_id: 0);
  bool _affiche = false;

  String get immatriculation => _imm;
  String get permis => _permis;
  String get cond_telephone => _cond_telepehone;
  String get conducteur_name => _cond_name;
  bool get loading => _loading;
  List<Villes> get villes_expeditions => _villes_exp;
  List<Villes> get villes_livraison => _villes_liv;
  double get solde => _solde;
  double get accompte => _accompte;
  double get tarif => _tarif;
  Pays get pay_exp => _pay_exp;
  Villes get ville_exp => _ville_exp;
  bool get affiche => _affiche;

  void change_loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getAllVillesExpedition(int country_id) async {
    _loading = true;
    notifyListeners();
    final response = await apiService.getVilles(country_id);
    _villes_exp = response;
    _loading = false;
    notifyListeners();
  }

  Future<void> getAllVillesLivraison(int country_id) async {
    _loading = true;
    notifyListeners();
    final response = await apiService.getVilles(country_id);
    _villes_liv = response;
    _loading = false;
    notifyListeners();
  }

  void change_tarif(String? value) {
    _tarif = value!.isNotEmpty ? double.parse(value) : 0;
    if (tarif < accompte) {
      _solde = _tarif - _accompte;
    }
    notifyListeners();
  }

  void change_accompte(String? value) {
    _accompte = value!.isNotEmpty ? double.parse(value) : 0;
    if (tarif < accompte) {
      _solde = _tarif - _accompte;
    }
    notifyListeners();
  }

  void change_pays_exp(Pays pay) {
    _pay_exp = pay;
    notifyListeners();
  }

  void change_ville_exp(Villes ville) {
    _ville_exp = ville;
    notifyListeners();
  }

  Pays get pay_liv => _pay_liv;
  Villes get ville_liv => _ville_liv;

  void change_pays_liv(Pays pay) {
    _pay_liv = pay;
    notifyListeners();
  }

  void change_ville_liv(Villes ville) {
    _ville_liv = ville;
    notifyListeners();
  }

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }

  void change_conducteur_name(String? value) {
    _cond_name = value!;
    notifyListeners();
  }

  void change_conducteur_telephone(String? value) {
    _cond_telepehone = value!;
    notifyListeners();
  }

  void change_permis(String? value) {
    _permis = value!;
    notifyListeners();
  }

  void change_immatriculation(String? value) {
    _imm = value!;
    notifyListeners();
  }
}
