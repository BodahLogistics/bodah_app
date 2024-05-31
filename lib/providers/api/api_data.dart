// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:bodah/modals/statuts.dart';
import 'package:bodah/modals/unites.dart';
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

  List<Unites> _unites = [];
  List<Unites> get unites => _unites;
  List<Villes> _villes = [];
  List<Villes> get villes => _villes;
  List<Pays> _pays = [];
  List<Pays> get pays => _pays;

  List<Rules> _rules = [];
  List<Rules> get rules => _rules;

  List<Rules> _roles = [];
  List<Rules> get roles => _roles;

  List<Statuts> _statuts = [];
  List<Statuts> get statuts => _statuts;

  List<Users> _users = [];
  List<Users> get users => _users;

  Users _user = Users(
      dark_mode: 0,
      id: 0,
      name: "",
      country_id: 0,
      telephone: "",
      deleted: 0,
      is_verified: 0,
      is_active: 0,
      code_sended: "");
  Users get user => _user;

  String _token = "";
  String get token => _token;

  Future<void> InitData(context) async {
    _isLoading = true;
    final response_users = await apiService.getUsers(context);
    _users = response_users;
    final response_unites = await apiService.getUnites();
    _unites = response_unites;
    final response = await apiService.user(context);
    _user = response[0];
    _roles = response[1];
    final response_pays = await apiService.getPays(context);
    _pays = response_pays;
    final response_role = await apiService.getRules(context);
    _rules = response_role;
    final response_statuts = await apiService.getStatuts(context);
    _statuts = response_statuts;
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
