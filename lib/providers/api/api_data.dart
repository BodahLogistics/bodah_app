// ignore_for_file: non_constant_identifier_names

import 'package:bodah/modals/statuts.dart';
import 'package:bodah/modals/users.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/auth/prov_sign_up.dart';
import 'package:bodah/services/data_base_service.dart';
import 'package:flutter/material.dart';
import '../../modals/pays.dart';
import '../../modals/rules.dart';

class ApiProvider with ChangeNotifier {
  final apiService = DBServices();
  final sign_uo_provider = ProvSignUp();
  bool _isLoading = false;
  bool get loading => _isLoading;
  void change_loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Villes> _villes = [];
  List<Villes> get villes => _villes;
  List<Pays> _pays = [];
  List<Pays> get pays => _pays;

  List<Rules> _rules = [];
  List<Rules> get rules => _rules;

  List<Statuts> _statuts = [];
  List<Statuts> get statuts => _statuts;

  List<Users> _users = [];
  List<Users> get users => _users;

  Users _user = Users(
      id: 0,
      name: "",
      country_id: 0,
      telephone: "",
      deleted: 0,
      is_verified: 0,
      is_active: 0,
      code_sended: "");
  Users get user => _user;

  Users _new_user = Users(
      id: 0,
      name: "",
      country_id: 0,
      telephone: "",
      deleted: 0,
      is_verified: 0,
      is_active: 0,
      code_sended: "");
  Users get new_user => _new_user;

  Future<void> InitData() async {
    _isLoading = true;
    notifyListeners();
    final response_users = await apiService.getUsers();
    _users = response_users;
    final response = await apiService.user();
    _user = response;
    final response_pays = await apiService.getPays();
    _pays = response_pays;
    final response_role = await apiService.getRules();
    _rules = response_role;
    final response_statuts = await apiService.getStatuts();
    _statuts = response_statuts;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitUser() async {
    _isLoading = true;
    notifyListeners();
    final response = await apiService.user();
    _new_user = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAllVilles(int country_id) async {
    _isLoading = true;
    notifyListeners();
    final response = await apiService.getVilles(country_id);
    _villes = response;
    _isLoading = false;
    notifyListeners();
  }
}
