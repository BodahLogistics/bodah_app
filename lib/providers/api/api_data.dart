// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/appeles.dart';
import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/modals/expeditions.dart';
import 'package:bodah/modals/marchandises.dart';
import 'package:bodah/modals/notifications.dart';
import 'package:bodah/modals/statuts.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/tdos.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/modals/users.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/auth/prov_sign_up.dart';
import 'package:bodah/services/data_base_service.dart';
import 'package:flutter/material.dart';
import '../../modals/annonces.dart';
import '../../modals/destinataires.dart';
import '../../modals/donneur_ordres.dart';
import '../../modals/entite_factures.dart';
import '../../modals/entreprises.dart';
import '../../modals/expediteurs.dart';
import '../../modals/interchanges.dart';
import '../../modals/localisations.dart';
import '../../modals/pays.dart';
import '../../modals/recus.dart';
import '../../modals/rules.dart';
import '../../modals/transporteurs.dart';
import '../../modals/type_chargements.dart';
import '../../modals/vgms.dart';

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
  );
  Users get user => _user;

  String _token = "";
  String get token => _token;
  List<Villes> _all_villes = [];
  List<Villes> get all_villes => _all_villes;
  List<Expediteurs> _expediteurs = [];
  List<Transporteurs> _transporteurs = [];
  List<Destinataires> _destinataires = [];
  List<Entreprises> _entreprises = [];
  List<DonneurOrdres> _donneur_ordres = [];
  List<EntiteFactures> _entite_factures = [];
  List<Expediteurs> get expediteurs => _expediteurs;
  List<Transporteurs> get transporteurs => _transporteurs;
  List<Destinataires> get destinataires => _destinataires;
  List<Entreprises> get entreprises => _entreprises;
  List<DonneurOrdres> get donneur_ordres => _donneur_ordres;
  List<EntiteFactures> get entite_factures => _entite_factures;

  List<TypeChargements> _type_chargements = [];
  List<TypeChargements> get type_chargements => _type_chargements;
  List<Recus> _recus = [];
  List<Recus> get recus => _recus;
  List<Interchanges> _interchanges = [];
  List<Interchanges> get interchanges => _interchanges;
  List<Vgms> _vgms = [];
  List<Vgms> get vgms => _vgms;
  List<Tdos> _tdos = [];
  List<Tdos> get tdos => _tdos;
  List<Appeles> _appeles = [];
  List<Appeles> get appeles => _appeles;
  List<BonCommandes> _ordres = [];
  List<BonCommandes> get ordres => _ordres;
  List<Annonces> _annonces = [];
  List<Annonces> get annonces => _annonces;
  List<Notifications> _notifications = [];
  List<Notifications> get notifications => _notifications;
  List<BordereauLivraisons> _bordereaux = [];
  List<BordereauLivraisons> get bordereaux => _bordereaux;
  List<Expeditions> _expeditions = [];
  List<Expeditions> get expeditions => _expeditions;
  List<Marchandises> _marchandises = [];
  List<Marchandises> get marchandises => _marchandises;
  List<Tarifications> _tarifications = [];
  List<Tarifications> get tarifications => _tarifications;
  List<Localisations> _localisations = [];
  List<Localisations> get localisations => _localisations;
  List<AnnoncePhotos> _annonce_photos = [];
  List<AnnoncePhotos> get photos => _annonce_photos;

  Future<void> InitData() async {
    _isLoading = true;
    final response_users = await apiService.getUsers();
    _users = response_users;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_unites = await apiService.getUnites();
    _unites = response_unites;
    final response = await apiService.user();
    _user = response[0];
    _roles = response[1];
    final response_pays = await apiService.getPays();
    _pays = response_pays;
    final response_role = await apiService.getRules();
    _rules = response_role;
    final response_statuts = await apiService.getStatuts();
    _statuts = response_statuts;
    final response_type_chargement = await apiService.getTypeChargements();
    _type_chargements = response_type_chargement;
    _isLoading = false;
    notifyListeners();
  }

  void change_token(String value) {
    _token = value;
    notifyListeners();
  }

  Future<void> InitAnnonce() async {
    _isLoading = true;
    final response = await apiService.user();
    _user = response[0];
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_photo = await apiService.getAnnoncePhotos();
    _annonce_photos = response_photo;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitDocuments() async {
    _isLoading = true;
    final response_bordereaux = await apiService.getBordereaux();
    _bordereaux = response_bordereaux;
    final response_recues = await apiService.getRecus();
    _recus = response_recues;
    final response_apeles = await apiService.getApeles();
    _appeles = response_apeles;
    final response_interchange = await apiService.getInterchanges();
    _interchanges = response_interchange;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitBordereaux() async {
    _isLoading = true;
    final response_bordereaux = await apiService.getBordereaux();
    _bordereaux = response_bordereaux;
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitInterchanges() async {
    _isLoading = true;
    final response_interchanges = await apiService.getInterchanges();
    _interchanges = response_interchanges;
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitRecus() async {
    _isLoading = true;
    final response_recus = await apiService.getRecus();
    _recus = response_recus;
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitApeles() async {
    _isLoading = true;
    final response_apeles = await apiService.getApeles();
    _appeles = response_apeles;
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
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

  Future<void> InitUser() async {
    _isLoading = true;
    final response = await apiService.user();
    _user = response[0];
    _isLoading = false;
    notifyListeners();
  }
}
