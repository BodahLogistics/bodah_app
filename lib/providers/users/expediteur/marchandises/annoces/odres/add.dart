// ignore_for_file: non_constant_identifier_names

import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/modals/donneur_ordres.dart';
import 'package:bodah/modals/entite_factures.dart';
import 'package:bodah/modals/entreprises.dart';
import 'package:flutter/foundation.dart';

import '../../../../../../modals/users.dart';

class ProvAddOrdre with ChangeNotifier {
  void change_ordre(
      BonCommandes ordre,
      EntiteFactures entite_facture,
      DonneurOrdres donneur_ordre,
      Users entite_facture_user,
      Users donneur_ordre_user,
      Entreprises donneur_ordre_entreprise,
      Entreprises entite_facture_entreprise) {
    _entite_email = entite_facture_user.email ?? "";
    _entite_ifu = entite_facture_entreprise.ifu ?? "";
    _delai_chargement = ordre.delai_chargement;
    _amende_delai_chargement = ordre.amende_delai_chargement;
    _amende_dechargement = ordre.amende_dechargement;
    _email = donneur_ordre_user.email ?? "";
    _name = donneur_ordre_user.name;
    _phone_number = donneur_ordre_user.telephone;
    _entreprise = donneur_ordre_entreprise.name;
    _ifu = donneur_ordre_entreprise.ifu ?? "";
    _entite_name = entite_facture_user.name;
    _entite_phone_number = entite_facture_user.telephone;
    _entite_entreprise = entite_facture_entreprise.name;
    _entite_address = entite_facture_user.adresse ?? "";
    _address = donneur_ordre_user.adresse ?? "";
    notifyListeners();
  }

  void reset() {
    _entite_ifu = "";
    _address = "";
    _entite_address = '';
    _delai_chargement = 72;
    _amende_delai_chargement = 25000;
    _amende_dechargement = 25000;
    _email = "";
    _entite_email = "";
    _name = "";
    _phone_number = "";
    _entreprise = "";
    _ifu = "";
    _entite_name = "";
    _entite_phone_number = "";
    _entite_entreprise = "";
    _affiche = false;
    notifyListeners();
  }

  String _address = "";
  String _entite_address = "";
  String get address => _address;
  String get entite_address => _entite_address;

  void change_adress(String? value) {
    _address = value!;
    notifyListeners();
  }

  void change_entite_adress(String? value) {
    _entite_address = value!;
    notifyListeners();
  }

  String _entite_ifu = "";
  int _delai_chargement = 72;
  double _amende_delai_chargement = 25000;
  double _amende_dechargement = 25000;
  String _email = "";
  String _name = "";
  String _phone_number = "";
  String _entreprise = "";
  String _ifu = "";
  String _entite_name = "";
  String _entite_phone_number = "";
  String _entite_email = "";
  String _entite_entreprise = "";
  bool _affiche = false;

  int get delai_chargement => _delai_chargement;
  double get amende_delai_chargement => _amende_delai_chargement;
  double get amende_dechargement => _amende_dechargement;
  String get email => _email;
  String get entite_email => _entite_email;
  String get name => _name;
  String get phone_number => _phone_number;
  String get entreprise => _entreprise;
  String get ifu => _ifu;
  String get entite_name => _entite_name;
  String get entite_phone_number => _entite_phone_number;
  String get entite_entreprise => _entite_entreprise;
  String get entite_ifu => _entite_ifu;
  bool get affiche => _affiche;

  void change_delai_chargement(String? value) {
    _delai_chargement = value!.isNotEmpty ? int.parse(value) : 0;
    notifyListeners();
  }

  void change_entite_email(String? value) {
    _entite_email = value!;
    notifyListeners();
  }

  void change_amende_delai_chargement(String? value) {
    _amende_delai_chargement = value!.isNotEmpty ? double.parse(value) : 0;
    notifyListeners();
  }

  void change_amende_dechargement(String? value) {
    _amende_dechargement = value!.isNotEmpty ? double.parse(value) : 0;
    notifyListeners();
  }

  void change_email(String? value) {
    _email = value!;
    notifyListeners();
  }

  void change_name(String? value) {
    _name = value!;
    notifyListeners();
  }

  void change_phone_number(String? value) {
    _phone_number = value!;
    notifyListeners();
  }

  void change_entreprise(String? value) {
    _entreprise = value!;
    notifyListeners();
  }

  void change_ifu(String? value) {
    _ifu = value!;
    notifyListeners();
  }

  void change_entite_name(String? value) {
    _entite_name = value!;
    notifyListeners();
  }

  void change_entite_phone_number(String? value) {
    _entite_phone_number = value!;
    notifyListeners();
  }

  void change_entite_entreprise(String? value) {
    _entite_entreprise = value!;
    notifyListeners();
  }

  void change_entite_ifu(String? value) {
    _entite_ifu = value!;
    notifyListeners();
  }

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }
}
