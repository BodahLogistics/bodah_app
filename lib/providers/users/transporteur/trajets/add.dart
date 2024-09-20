// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/type_chargements.dart';
import 'package:bodah/modals/villes.dart';
import 'package:flutter/material.dart';

import '../../../../../services/data_base_service.dart';

class ProvAddTrajet with ChangeNotifier {
  final apiService = DBServices();

  void change_trajet(String charge, TypeChargements type_chargement,
      Pays pays_exp, Pays pays_dest, Villes city_exp, Villes city_dest) {
    _charge = charge;
    _type_chargement = type_chargement;
    _pay_exp = pays_exp;
    _pay_liv = pays_dest;
    _ville_exp = city_exp;
    _ville_liv = city_dest;
    notifyListeners();
  }

  void reset() {
    _type_chargement = TypeChargements(id: 0, name: "");
    _charge = "";
    _pay_exp = Pays(id: 0, name: "");
    _ville_exp = Villes(id: 0, name: "", country_id: 0);
    _pay_liv = Pays(id: 0, name: "");
    _ville_liv = Villes(id: 0, name: "", country_id: 0);
    _affiche = false;
    notifyListeners();
  }

  List<Villes> _villes_exp = [];
  List<Villes> get villes_expeditions => _villes_exp;
  List<Villes> _villes_liv = [];
  List<Villes> get villes_livraison => _villes_liv;

  Future<void> getAllVillesExpedition(int country_id) async {
    final response = await apiService.getVilles(country_id);
    _villes_exp = response;
    notifyListeners();
  }

  Future<void> getAllVillesLivraison(int country_id) async {
    final response = await apiService.getVilles(country_id);
    _villes_liv = response;
    notifyListeners();
  }

  String _charge = "";
  String get charge => _charge;
  TypeChargements _type_chargement = TypeChargements(id: 0, name: "");

  TypeChargements get type_chargement => _type_chargement;

  Pays _pay_exp = Pays(id: 0, name: "");
  Villes _ville_exp = Villes(id: 0, name: "", country_id: 0);

  Pays get pay_exp => _pay_exp;
  Villes get ville_exp => _ville_exp;

  void change_pays_exp(Pays pay) {
    _pay_exp = pay;
    notifyListeners();
  }

  void change_ville_exp(Villes ville) {
    _ville_exp = ville;
    notifyListeners();
  }

  void change_charge(String? value) {
    _charge = value!;
    notifyListeners();
  }

  Pays _pay_liv = Pays(id: 0, name: "");
  Villes _ville_liv = Villes(id: 0, name: "", country_id: 0);

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

  void change_type_chargement(TypeChargements value) {
    _type_chargement = value;
    notifyListeners();
  }

  bool _affiche = false;
  bool get affiche => _affiche;

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }
}
