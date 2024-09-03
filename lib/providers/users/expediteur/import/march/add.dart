// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/villes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../services/data_base_service.dart';

class ProvAddMarch with ChangeNotifier {
  final apiService = DBServices();

  void reset() {
    _villes_exp = [];
    _villes_liv = [];
    _marchandise = "";
    _quantite = 0;
    _date_debut = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _date_fin = "";
    _pay_exp = Pays(id: 0, name: "");
    _ville_exp = Villes(id: 0, name: "", country_id: 0);
    _client_name = "";
    _client_telepehone = "";
    _pay_liv = Pays(id: 0, name: "");
    _ville_liv = Villes(id: 0, name: "", country_id: 0);
    _affiche = false;
    notifyListeners();
  }

  String _client_telepehone = "";
  String _client_name = "";
  bool _loading = false;
  List<Villes> _villes_exp = [];
  List<Villes> _villes_liv = [];
  String _marchandise = "";
  int _quantite = 0;
  String _date_debut = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String _date_fin = "";
  Pays _pay_exp = Pays(id: 0, name: "");
  Villes _ville_exp = Villes(id: 0, name: "", country_id: 0);
  Pays _pay_liv = Pays(id: 0, name: "");
  Villes _ville_liv = Villes(id: 0, name: "", country_id: 0);
  bool _affiche = false;

  String get client_telephone => _client_telepehone;
  bool get loading => _loading;
  List<Villes> get villes_expeditions => _villes_exp;
  List<Villes> get villes_livraison => _villes_liv;
  int get quantite => _quantite;
  String get date_debut => _date_debut;
  String get date_fin => _date_fin;
  Pays get pay_exp => _pay_exp;
  Villes get ville_exp => _ville_exp;
  String get marchandise => _marchandise;
  bool get affiche => _affiche;
  String get client_name => _client_name;

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

  void change_quantite(String? value) {
    _quantite = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  void change_date_debut(String? value) {
    _date_debut = value!;
    notifyListeners();
  }

  void change_date_fin(String? value) {
    _date_fin = value!;
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

  void change_marchandise(String? value) {
    _marchandise = value!;
    notifyListeners();
  }

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }

  void change_client_name(String? value) {
    _client_name = value!;
    notifyListeners();
  }

  void change_client_telephone(String? value) {
    _client_telepehone = value!;
    notifyListeners();
  }
}