// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'package:bodah/modals/cargaison.dart';
import 'package:bodah/modals/client.dart';
import 'package:bodah/modals/livraison_cargaison.dart';
import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/villes.dart';
import 'package:flutter/material.dart';

import '../../../../../services/data_base_service.dart';

class ProvAddLiv with ChangeNotifier {
  final apiService = DBServices();

  void change_livraison(LivraisonCargaison livraison, Cargaison cargaison,
      Client client, Pays pay, Villes ville) {
    _pay = pay;
    _ville = ville;
    _adresse = livraison.address;
    _telepehone = client.telephone;
    _name = client.nom;
    _marchandise = cargaison;
    _quantite = livraison.quantite;
    _superviseur = livraison.superviseur ?? "";
    notifyListeners();
  }

  void reset() {
    _adresse = "";
    _telepehone = "";
    _name = "";
    _loading = false;
    _villes = [];
    _marchandise = Cargaison(
        id: 0,
        reference: "",
        modele_type: "",
        modele_id: 0,
        nom: "",
        deleted: 0);
    _quantite = 0;
    _superviseur = "";
    _pay = Pays(id: 0, name: "");
    _ville = Villes(id: 0, name: "", country_id: 0);
    _affiche = false;
    notifyListeners();
  }

  String _adresse = "";
  String _telepehone = "";
  String _name = "";
  bool _loading = false;
  List<Villes> _villes = [];
  Cargaison _marchandise = Cargaison(
      id: 0, reference: "", modele_type: "", modele_id: 0, nom: "", deleted: 0);
  int _quantite = 0;
  String _superviseur = "";
  Pays _pay = Pays(id: 0, name: "");
  Villes _ville = Villes(id: 0, name: "", country_id: 0);
  bool _affiche = false;

  String get adresse => _adresse;
  bool get loading => _loading;
  List<Villes> get villes => _villes;
  int get quantite => _quantite;
  String get superviseur => _superviseur;
  Pays get pay => _pay;
  Villes get ville => _ville;
  Cargaison get marchandise => _marchandise;
  bool get affiche => _affiche;
  String get name => _name;
  String get telephone => _telepehone;

  void change_loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getAllVilles(int country_id) async {
    _loading = true;
    notifyListeners();
    final response = await apiService.getVilles(country_id);
    _villes = response;
    _loading = false;
    notifyListeners();
  }

  void change_quantite(String? value) {
    _quantite = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  void change_adresse(String? value) {
    _adresse = value!;
    notifyListeners();
  }

  void change_superviseur(String? value) {
    _superviseur = value!;
    notifyListeners();
  }

  void change_pays(Pays pay) {
    _pay = pay;
    notifyListeners();
  }

  void change_ville(Villes ville) {
    _ville = ville;
    notifyListeners();
  }

  void change_marchandise(Cargaison data) {
    _marchandise = data;
    notifyListeners();
  }

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }

  void change_name(String? value) {
    _name = value!;
    notifyListeners();
  }

  void change_telephone(String? value) {
    _telepehone = value!;
    notifyListeners();
  }
}
