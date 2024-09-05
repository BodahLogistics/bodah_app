// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/villes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../services/data_base_service.dart';

class ProvAddExportAerien with ChangeNotifier {
  final apiService = DBServices();

  void reset() {
    _villes_exp = [];
    _villes_liv = [];
    _marchandise = "";
    _tarif = 0;
    _accompte = 0;
    _solde = 0;
    _quantite = 0;
    _date_debut = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _date_fin = "";
    _pay_exp = Pays(id: 0, name: "");
    _ville_exp = Villes(id: 0, name: "", country_id: 0);
    _client_name = "";
    _client_telepehone = "";
    _numero_marchandise = "";
    _lta = "";
    _pay_liv = Pays(id: 0, name: "");
    _ville_liv = Villes(id: 0, name: "", country_id: 0);
    _affiche = false;
    notifyListeners();
  }

  String _lta = "";
  String _numero_marchandise = "";
  String _client_telepehone = "";
  String _client_name = "";
  bool _loading = false;
  List<Villes> _villes_exp = [];
  List<Villes> _villes_liv = [];
  String _marchandise = "";
  double _tarif = 0;
  double _accompte = 0;
  double _solde = 0;
  int _quantite = 0;
  String _date_debut = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String _date_fin = "";
  Pays _pay_exp = Pays(id: 24, name: "");
  Villes _ville_exp = Villes(id: 9626, name: "", country_id: 0);
  Pays _pay_liv = Pays(id: 24, name: "");
  Villes _ville_liv = Villes(id: 9626, name: "", country_id: 0);
  bool _affiche = false;

  String get lta => _lta;
  String get numero_marchandise => _numero_marchandise;
  String get client_telephone => _client_telepehone;
  bool get loading => _loading;
  List<Villes> get villes_expeditions => _villes_exp;
  List<Villes> get villes_livraison => _villes_liv;
  double get solde => _solde;
  int get quantite => _quantite;
  double get accompte => _accompte;
  double get tarif => _tarif;
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

  void change_tarif(String? value) {
    _tarif = value!.isNotEmpty ? double.parse(value) : 0;
    if (tarif >= accompte) {
      _solde = _tarif - _accompte;
    }
    notifyListeners();
  }

  void change_accompte(String? value) {
    _accompte = value!.isNotEmpty ? double.parse(value) : 0;
    if (tarif >= accompte) {
      _solde = _tarif - _accompte;
    }
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

  void change_lta(String? value) {
    _lta = value!;
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

  void change_numero_marchandise(String? value) {
    _numero_marchandise = value!;
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
