// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:bodah/modals/marchandises.dart';
import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/modals/villes.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../../services/data_base_service.dart';

class ProvAddMarchandise with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final apiService = DBServices();
  void change_marchandise(
      Marchandises marchandise,
      Unites unite,
      Tarifications tarifications,
      Pays pay_expeditioon,
      Pays pay_livraison,
      Villes ville_expedition,
      Villes ville_livraison,
      String adresse_liv,
      String adress_exp) {
    _adress_exp = adress_exp;
    _adress_liv = adress_liv;
    _ville_liv = ville_livraison;
    _ville_exp = ville_expedition;
    _pay_exp = pay_expeditioon;
    _pay_liv = pay_livraison;
    _nom = marchandise.nom;
    _quantite = marchandise.quantite;
    _unite = unite;
    _poids = marchandise.poids;
    _date_chargement =
        DateFormat("yyyy-MM-dd").format(marchandise.date_chargement!);
    notifyListeners();
  }

  void reset() {
    _file_selected = null;
    _nom = "";
    _unite = Unites(id: 0, name: "");
    _poids = 0;
    _quantite = 0;
    _date_chargement = "";
    _pay_exp = Pays(id: 0, name: "");
    _ville_exp = Villes(id: 0, name: "", country_id: 0);
    _adress_exp = "";
    _pay_liv = Pays(id: 0, name: "");
    _ville_liv = Villes(id: 0, name: "", country_id: 0);
    _adress_liv = "";
    _affiche = false;
    notifyListeners();
  }

  File? _file_selected;
  File? get file_selected => _file_selected;
  void change_file(File file) {
    _file_selected = file;
    notifyListeners();
  }

  bool _upload = false;
  bool get upload => _upload;
  void change_upload(bool value) {
    _upload = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  void change_loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Villes> _villes_exp = [];
  List<Villes> get villes_expeditions => _villes_exp;
  List<Villes> _villes_liv = [];
  List<Villes> get villes_livraison => _villes_liv;

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

  Future<void> selectImageFromGallery() async {
    _upload = true;
    notifyListeners();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _file_selected = File(pickedFile.path);
    }

    _upload = false;
    notifyListeners();
  }

  Future<void> takeImageWithCamera() async {
    _upload = true;
    notifyListeners();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _file_selected = File(pickedFile.path);
    }

    notifyListeners();
  }

  String _nom = "";
  Unites _unite = Unites(id: 0, name: "");

  Unites get unite => _unite;

  void change_unite(Unites unite) {
    _unite = unite;
    notifyListeners();
  }

  int _quantite = 0;
  int get quantite => _quantite;
  void change_quantite(String? value) {
    _quantite = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  String _date_chargement = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String get date_chargement => _date_chargement;

  void change_date_chargement(String? value) {
    _date_chargement = value!;
    notifyListeners();
  }

  int _poids = 0;
  int get poids => _poids;
  void change_poids(String? value) {
    _poids = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  Pays _pay_exp = Pays(id: 0, name: "");
  Villes _ville_exp = Villes(id: 0, name: "", country_id: 0);
  String _adress_exp = "";

  Pays get pay_exp => _pay_exp;
  Villes get ville_exp => _ville_exp;
  String get adress_exp => _adress_exp;

  void change_pays_exp(Pays pay) {
    _pay_exp = pay;
    notifyListeners();
  }

  void change_ville_exp(Villes ville) {
    _ville_exp = ville;
    notifyListeners();
  }

  void change_adress_exp(String? value) {
    _adress_exp = value!;
    notifyListeners();
  }

  Pays _pay_liv = Pays(id: 0, name: "");
  Villes _ville_liv = Villes(id: 0, name: "", country_id: 0);
  String _adress_liv = "";

  Pays get pay_liv => _pay_liv;
  Villes get ville_liv => _ville_liv;
  String get adress_liv => _adress_liv;

  void change_pays_liv(Pays pay) {
    _pay_liv = pay;
    notifyListeners();
  }

  void change_ville_liv(Villes ville) {
    _ville_liv = ville;
    notifyListeners();
  }

  void change_adress_liv(String? value) {
    _adress_liv = value!;
    notifyListeners();
  }

  bool _affiche = false;
  String get nom => _nom;
  bool get affiche => _affiche;

  void change_nom(String? value) {
    _nom = value!;
    notifyListeners();
  }

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }
}
