// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unnecessary_null_comparison

import 'dart:convert';

import 'package:bodah/modals/annonce_colis.dart';
import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/annonce_transporteurs.dart';
import 'package:bodah/modals/appeles.dart';
import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/modals/cargaison_client.dart';
import 'package:bodah/modals/cartificat_origine.dart';
import 'package:bodah/modals/chargement.dart';
import 'package:bodah/modals/chargement_effectues.dart';
import 'package:bodah/modals/coli_photos.dart';
import 'package:bodah/modals/conducteur.dart';
import 'package:bodah/modals/envoi_colis.dart';
import 'package:bodah/modals/expeditions.dart';
import 'package:bodah/modals/exports.dart';
import 'package:bodah/modals/import.dart';
import 'package:bodah/modals/letrre_voyage.dart';
import 'package:bodah/modals/livraison_cargaison.dart';
import 'package:bodah/modals/location_colis.dart';
import 'package:bodah/modals/marchandises.dart';
import 'package:bodah/modals/notifications.dart';
import 'package:bodah/modals/pieces.dart';
import 'package:bodah/modals/souscriptions.dart';
import 'package:bodah/modals/statut_expeditions.dart';
import 'package:bodah/modals/statut_operations.dart';
import 'package:bodah/modals/statuts.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/tarifs.dart';
import 'package:bodah/modals/tdos.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/modals/users.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/modals/voiture_photos.dart';
import 'package:bodah/modals/voitures.dart';
import 'package:bodah/providers/auth/prov_sign_up.dart';
import 'package:bodah/services/data_base_service.dart';
import 'package:flutter/material.dart';

import '../../modals/annonces.dart';
import '../../modals/arrondissements.dart';
import '../../modals/autre_docs.dart';
import '../../modals/avds.dart';
import '../../modals/bfus.dart';
import '../../modals/bl.dart';
import '../../modals/camions.dart';
import '../../modals/cargaison.dart';
import '../../modals/certificat_phyto_sanitaire.dart';
import '../../modals/charges.dart';
import '../../modals/client.dart';
import '../../modals/coli_tarifs.dart';
import '../../modals/declaration.dart';
import '../../modals/departements.dart';
import '../../modals/destinataires.dart';
import '../../modals/devises.dart';
import '../../modals/donneur_ordres.dart';
import '../../modals/entite_factures.dart';
import '../../modals/entreprises.dart';
import '../../modals/expediteurs.dart';
import '../../modals/fiche_technique.dart';
import '../../modals/info_localisation.dart';
import '../../modals/interchanges.dart';
import '../../modals/localisations.dart';
import '../../modals/lta.dart';
import '../../modals/marchandise_transporteur.dart';
import '../../modals/ordre_transport.dart';
import '../../modals/path.dart';
import '../../modals/pays.dart';
import '../../modals/positions.dart';
import '../../modals/quartiers.dart';
import '../../modals/recepteurs.dart';
import '../../modals/recus.dart';
import '../../modals/rules.dart';
import '../../modals/transport_liaison.dart';
import '../../modals/transport_mode.dart';
import '../../modals/transporteurs.dart';
import '../../modals/type_camions.dart';
import '../../modals/type_chargements.dart';
import '../../modals/vgms.dart';
import '../../services/secure_storage.dart';

class ApiProvider with ChangeNotifier {
  final apiService = DBServices();
  SecureStorage secure = SecureStorage();
  final sign_uo_provider = ProvSignUp();
  bool _isLoading = false;
  bool get loading => _isLoading;
  void change_loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _delete = false;
  bool get delete => _delete;
  void change_delete(bool value) {
    _delete = value;
    notifyListeners();
  }

  List<Unites> _unites = [];
  List<Unites> get unites => _unites;
  List<Villes> _villes = [];
  List<Villes> get villes => _villes;
  List<Pays> _pays = [];
  List<Pays> get pays => _pays;

  List<Departements> _departements = [];
  List<Departements> get departements => _departements;
  List<Arrondissements> _arrondissements = [];
  List<Arrondissements> get arrondissements => _arrondissements;
  List<Quartiers> _quartiers = [];
  List<Quartiers> get quartiers => _quartiers;

  List<AnnonceColis> _annonce_colis = [];
  List<AnnonceColis> get annonce_colis => _annonce_colis;
  List<ColiPhotos> _coli_photos = [];
  List<ColiPhotos> get coli_photos => _coli_photos;
  List<ColiTarifs> _coli_tarifs = [];
  List<ColiTarifs> get coli_tarifs => _coli_tarifs;
  List<LocationColis> _location_colis = [];
  List<LocationColis> get location_colis => _location_colis;
  List<Recepteurs> _recepteurs = [];
  List<Recepteurs> get recepteurs => _recepteurs;
  List<StatutOperations> _statut_operations = [];
  List<StatutOperations> get statut_operations => _statut_operations;
  List<StatutExpeditions> _statut_expeditions = [];
  List<StatutExpeditions> get statut_expeditions => _statut_expeditions;
  List<AnnonceTransporteurs> _trajets = [];
  List<AnnonceTransporteurs> get trajets => _trajets;
  List<MarchandiseTransporteur> _marchandise_transporteurs = [];
  List<MarchandiseTransporteur> get marchandise_transporteurs =>
      _marchandise_transporteurs;
  List<InfoLocalisations> _info_localisations = [];
  List<InfoLocalisations> get info_localisations => _info_localisations;
  List<Voitures> _voitures = [];
  List<Voitures> get voitures => _voitures;
  List<VoiturePhotos> _voiture_photos = [];
  List<VoiturePhotos> get voiture_photos => _voiture_photos;
  List<EnvoiColis> _envoi_colis = [];
  List<EnvoiColis> get envoi_colis => _envoi_colis;

  List<Rules> _rules = [];
  List<Rules> get rules => _rules;

  List<Rules> _roles = [];
  List<Rules> get roles => _roles;

  List<Statuts> _statuts = [];
  List<Statuts> get statuts => _statuts;

  List<Users> _users = [];
  List<Users> get users => _users;

  Users? _user;
  Users? get user => _user;

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
  List<Camions> _camions = [];
  List<Camions> get camions => _camions;
  List<Expediteurs> get expediteurs => _expediteurs;
  List<Transporteurs> get transporteurs => _transporteurs;
  List<Destinataires> get destinataires => _destinataires;
  List<Entreprises> get entreprises => _entreprises;
  List<DonneurOrdres> get donneur_ordres => _donneur_ordres;
  List<EntiteFactures> get entite_factures => _entite_factures;

  List<TypeChargements> _type_chargements = [];
  List<TypeChargements> get type_chargements => _type_chargements;
  List<TypeCamions> _type_camions = [];
  List<TypeCamions> get type_camions => _type_camions;
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
  List<Devises> _devises = [];
  List<Devises> get devises => _devises;

  List<Pieces> _pieces = [];
  List<Pieces> get pieces => _pieces;
  List<Import> _imports = [];
  List<Import> get imports => _imports;
  List<Exports> _exports = [];
  List<Exports> get exports => _exports;
  List<TransportMode> _transport_modes = [];
  List<TransportMode> get transport_modes => _transport_modes;
  List<CargaisonClient> _cargaison_clients = [];
  List<CargaisonClient> get cargaison_clients => _cargaison_clients;
  List<Chargement> _chargements = [];
  List<Chargement> get chargements => _chargements;
  List<Position> _positions = [];
  List<Position> get positions => _positions;
  List<Tarif> _tarifs = [];
  List<Tarif> get tarifs => _tarifs;
  List<Conducteur> _conducteurs = [];
  List<Conducteur> get conducteurs => _conducteurs;
  List<Client> _clients = [];
  List<Client> get clients => _clients;
  List<LivraisonCargaison> _livraisons = [];
  List<LivraisonCargaison> get livraisons => _livraisons;
  List<Cargaison> _cargaisons = [];
  List<Cargaison> get cargaisons => _cargaisons;
  List<ChargementEffectue> _chargement_effectues = [];
  List<ChargementEffectue> get chargement_effectues => _chargement_effectues;
  Rules? _rule;
  Rules? get rule => _rule;
  List<LetreVoitures> _contrats = [];
  List<LetreVoitures> get contrats => _contrats;

  Future<void> InitImport() async {
    _isLoading = true;
    final response_import = await apiService.getImports();
    _imports = response_import;
    final response_export = await apiService.getExports();
    _exports = response_export;
    final response_route_key = await apiService.getImportRouteKey();
    _import_route_key = response_route_key;
    final response_maritime_key = await apiService.getImportMaritimeKey();
    _import_maritime_key = response_maritime_key;
    final response_aerien_key = await apiService.getImportAerienKey();
    _import_aerien_key = response_aerien_key;
    final response_route = await apiService.getExportRouteKey();
    _export_route_key = response_route;
    final response_maritime = await apiService.getExportMaritimeKey();
    _export_maritime_key = response_maritime;
    final response_aerien = await apiService.getExportAerienKey();
    _export_aerien_key = response_aerien;
    final response_cargaison = await apiService.getCargaisons();
    _cargaisons = response_cargaison;
    final response_cargaison_client = await apiService.getCargaisonClients();
    _cargaison_clients = response_cargaison_client;
    final response_position = await apiService.getPositions();
    _positions = response_position;
    final response_chargement = await apiService.getChargements();
    _chargements = response_chargement;
    final response_livraison = await apiService.getLivraisons();
    _livraisons = response_livraison;
    final response_client = await apiService.getClients();
    _clients = response_client;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitCargaison() async {
    _isLoading = true;
    final response_client = await apiService.getClients();
    _clients = response_client;
    final response_cargaison = await apiService.getCargaisons();
    _cargaisons = response_cargaison;
    final response_cargaison_client = await apiService.getCargaisonClients();
    _cargaison_clients = response_cargaison_client;
    final response_position = await apiService.getPositions();
    _positions = response_position;
    final response_chargement = await apiService.getChargements();
    _chargements = response_chargement;
    final response_ville = await apiService.getAllVilles();
    _villes = response_ville;
    _isLoading = false;
    notifyListeners();
  }

  int _data_id = 0;
  int get data_id => _data_id;
  void change_data_id(int id) {
    _data_id = id;
    notifyListeners();
  }

  Future<void> InitLivraison() async {
    _isLoading = true;
    final response_livraison = await apiService.getLivraisons();
    _livraisons = response_livraison;
    final response_cargaison = await apiService.getCargaisons();
    _cargaisons = response_cargaison;
    final response_ville = await apiService.getAllVilles();
    _villes = response_ville;
    final response_client = await apiService.getClients();
    _clients = response_client;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitImportData() async {
    _isLoading = true;
    await InitImport();
    final response_chargement_effectues =
        await apiService.getChargementEffectues();
    _chargement_effectues = response_chargement_effectues;
    final response_pieces = await apiService.getPieces();
    _pieces = response_pieces;
    final response_camion = await apiService.getCamions();
    _camions = response_camion;
    final response_conducteur = await apiService.getConducteurs();
    _conducteurs = response_conducteur;
    final response_tarif = await apiService.getTarifs();
    _tarifs = response_tarif;
    final response_ville = await apiService.getAllVilles();
    _all_villes = response_ville;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitChargementEffectue() async {
    _isLoading = true;
    final response_position = await apiService.getPositions();
    _positions = response_position;
    final response_chargement_effectues =
        await apiService.getChargementEffectues();
    _chargement_effectues = response_chargement_effectues;
    final response_pieces = await apiService.getPieces();
    _pieces = response_pieces;
    final response_camion = await apiService.getCamions();
    _camions = response_camion;
    final response_conducteur = await apiService.getConducteurs();
    _conducteurs = response_conducteur;
    final response_tarif = await apiService.getTarifs();
    _tarifs = response_tarif;
    final response_ville = await apiService.getAllVilles();
    _all_villes = response_ville;
    _isLoading = false;
    notifyListeners();
  }

  int _import_route_key = 0;
  int get import_route_key => _import_route_key;
  void change_import_route_key(int value) {
    _import_route_key = value;
    notifyListeners();
  }

  int _import_maritime_key = 0;
  int get import_maritime_key => _import_maritime_key;
  void change_import_maritime_key(int value) {
    _import_maritime_key = value;
    notifyListeners();
  }

  int _import_aerien_key = 0;
  int get import_aerien_key => _import_aerien_key;
  void change_import_aerien_key(int value) {
    _import_aerien_key = value;
    notifyListeners();
  }

  int _export_route_key = 0;
  int get export_route_key => _export_route_key;
  void change_export_route_key(int value) {
    _export_route_key = value;
    notifyListeners();
  }

  int _export_maritime_key = 0;
  int get export_maritime_key => _export_maritime_key;
  void change_export_maritime_key(int value) {
    _export_maritime_key = value;
    notifyListeners();
  }

  int _export_aerien_key = 0;
  int get export_aerien_key => _export_aerien_key;
  void change_export_aerien_key(int value) {
    _export_aerien_key = value;
    notifyListeners();
  }

  void setUser(Users? user) {
    _user = user;
    notifyListeners();
  }

  void setRule(Rules? rule) {
    _rule = rule;
    notifyListeners();
  }

  List<AutreDocs> _autre_docs = [];
  List<AutreDocs> get autre_docs => _autre_docs;
  List<Avd> _avds = [];
  List<Avd> get avds => _avds;
  List<Bfu> _bfus = [];
  List<Bfu> get bfus => _bfus;
  List<Bl> _bls = [];
  List<Bl> get bls => _bls;
  List<Lta> _ltas = [];
  List<Lta> get ltas => _ltas;
  List<Declaration> _declarations = [];
  List<Declaration> get declarations => _declarations;
  List<FicheTechnique> _fiche_techniques = [];
  List<FicheTechnique> get fiche_techniques => _fiche_techniques;
  List<CO> _cos = [];
  List<CO> get cos => _cos;
  List<CPS> _cps = [];
  List<CPS> get cps => _cps;
  List<OrdreTransport> _import_ordres = [];
  List<OrdreTransport> get import_ordres => _import_ordres;
  List<Paths> _paths = [];
  List<Paths> get paths => _paths;

  List<Charge> _charges = [];
  List<Charge> get charges => _charges;

  List<Souscriptions> _souscriptions = [];
  List<Souscriptions> get souscriptions => _souscriptions;

  List<TransportLiaisons> _chauffeurs = [];
  List<TransportLiaisons> get chauffeurs => _chauffeurs;

  Future<void> InitData() async {
    _isLoading = true;
    try {
      String? userJson = await secure.readSecureData('user');
      String? ruleJson = await secure.readSecureData('rule');

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        Users user = Users.fromMap(userMap);
        _user = user;
        notifyListeners();
      }

      if (ruleJson != null) {
        Map<String, dynamic> ruleMap = jsonDecode(ruleJson);
        Rules rule = Rules.fromMap(ruleMap);
        _rule = rule;
        notifyListeners();
      }

      final response_users = await apiService.getUsers();
      _users = response_users;
      final response_pays = await apiService.getPays();
      _pays = response_pays;

      if (_user != null && _rule != null) {
        if (_rule!.nom == "Expéditeur") {
          final response_unites = await apiService.getUnites();
          _unites = response_unites;
          final response_devises = await apiService.getDevises();
          _devises = response_devises;
          final response_transport_mode = await apiService.getTransportMode();
          _transport_modes = response_transport_mode;
          await InitAnnonce();
          await InitImport();
        } else {
          await InitTransporteurAnnonce();
          final response_bordereaux =
              await apiService.getTransporteurBordereaux();
          _bordereaux = response_bordereaux;
          final response_contrat = await apiService.getTransporteurContrat();
          _contrats = response_contrat;
          final response_trajet = await apiService.getTrajet();
          _trajets = response_trajet;
          final response_type_camions = await apiService.getTypeCamions();
          _type_camions = response_type_camions;
          final response_transporteur = await apiService.getTransporteur();
          _transporteurs = response_transporteur;
          final response_vehicule = await apiService.getTransporteurCamions();
          _camions = response_vehicule;
        }

        final response_type_chargement = await apiService.getTypeChargements();
        _type_chargements = response_type_chargement;
        final response_unite = await apiService.getUnites();
        _unites = response_unite;
        final response_statuts = await apiService.getStatutExpeditions();
        _statut_expeditions = response_statuts;
      } else {
        final response_role = await apiService.getRules();
        _rules = response_role;
        final response_statuts = await apiService.getStatuts();
        _statuts = response_statuts;
      }

      _isLoading = false;
    } catch (e) {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> InitChauffeurs() async {
    _isLoading = true;
    final response_chauffeurs = await apiService.getChauffeurs();
    _chauffeurs = response_chauffeurs;
    final response_vehicule = await apiService.getTransporteurCamions();
    _camions = response_vehicule;
    final response_users = await apiService.getUsers();
    _users = response_users;
    final response_piece = await apiService.getTransporteurPieces();
    _pieces = response_piece;
    final response_transporteur = await apiService.getTransporteur();
    _transporteurs = response_transporteur;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitCamions() async {
    _isLoading = true;
    final response_vehicule = await apiService.getTransporteurCamions();
    _camions = response_vehicule;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitImportRouteKey() async {
    _isLoading = true;
    final response = await apiService.getImportRouteKey();
    _import_route_key = response;
    _isLoading = false;
    notifyListeners();
  }

  void addAnnonce(Annonces annonce, Marchandises marchandise,
      Localisations localisation, Tarifications tarif) {
    _annonces.insert(0, annonce);
    _marchandises.insert(0, marchandise);
    _tarifications.insert(0, tarif);
    _localisations.insert(0, localisation);

    notifyListeners();
  }

  void addPhotos(List<AnnoncePhotos> photos) {
    _annonce_photos.addAll(photos);
    notifyListeners();
  }

  void change_token(String value) {
    _token = value;
    notifyListeners();
  }

  Future<void> InitAnnonce() async {
    _isLoading = true;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
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

  Future<void> InitSouscriptions() async {
    _isLoading = true;
    final response_souscription = await apiService.getSouscription();
    _souscriptions = response_souscription;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTrajet() async {
    _isLoading = true;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_trajet = await apiService.getTrajet();
    _trajets = response_trajet;
    final response_marchandise = await apiService.getTrajetMarchandise();
    _marchandise_transporteurs = response_marchandise;
    final response_localisation = await apiService.getInfoLocalisations();
    _info_localisations = response_localisation;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurAnnonce() async {
    _isLoading = true;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_expedition = await apiService.getTransporteurExpditions();
    _expeditions = response_expedition;
    final response_marchandise =
        await apiService.getAnnonceTransporteurMarchandises();
    _marchandises = response_marchandise;
    final response_photo = await apiService.getTransporteurAnnoncePhotos();
    _annonce_photos = response_photo;
    final response_tarification =
        await apiService.getAnnonceTransporteurTarification();
    _tarifications = response_tarification;
    final response_localisation =
        await apiService.getAnnonceTransporteurLocalisation();
    _localisations = response_localisation;
    final response_annonce = await apiService.getTransporteurAnnonces();
    _annonces = response_annonce;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitExpedition() async {
    _isLoading = true;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurExpedition() async {
    _isLoading = true;
    final response_expedition = await apiService.getTransporteurExpditions();
    _expeditions = response_expedition;
    await InitTransporteurAnnonce();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitExpeditionForAnnonce() async {
    _isLoading = true;
    final response_charge = await apiService.getCharges();
    _charges = response_charge;
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_tarif = await apiService.getTarifs();
    _tarifs = response_tarif;
    final response_piece = await apiService.getPieces();
    _pieces = response_piece;
    final response_transporteur = await apiService.getTransporteurs();
    _transporteurs = response_transporteur;
    final response_camions = await apiService.getCamions();
    _camions = response_camions;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurExpeditionForAnnonce() async {
    _isLoading = true;
    final response_charge = await apiService.getTransporteurCharge();
    _charges = response_charge;
    final response_expedition = await apiService.getTransporteurExpditions();
    _expeditions = response_expedition;
    final response_tarif = await apiService.getTransporteurTarif();
    _tarifs = response_tarif;
    final response_piece = await apiService.getTransporteurPieces();
    _pieces = response_piece;
    final response_transporteur = await apiService.getTransporteur();
    _transporteurs = response_transporteur;
    final response_camions = await apiService.getTransporteurCamions();
    _camions = response_camions;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitForSomeAnnonce() async {
    _isLoading = true;
    final response_photo = await apiService.getAnnoncePhotos();
    _annonce_photos = response_photo;
    final response_destinataire = await apiService.getDestinataires();
    _destinataires = response_destinataire;
    final response_entreprise = await apiService.getEntreprises();
    _entreprises = response_entreprise;
    final response_expediteur = await apiService.getExpediteurs();
    _expediteurs = response_expediteur;
    final response_users = await apiService.getUsers();
    _users = response_users;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitDocuments() async {
    _isLoading = true;
    final response_bordereaux = await apiService.getBordereaux();
    _bordereaux = response_bordereaux;
    final response_recues = await apiService.getRecus();
    _recus = response_recues;
    final response_vgm = await apiService.getVgms();
    _vgms = response_vgm;
    final response_tdo = await apiService.getTdos();
    _tdos = response_tdo;
    final response_apeles = await apiService.getApeles();
    _appeles = response_apeles;
    final response_interchange = await apiService.getInterchanges();
    _interchanges = response_interchange;
    final response_ordre = await apiService.getOrdres();
    _ordres = response_ordre;
    final response_autre_doc = await apiService.getAutreDocs();
    _autre_docs = response_autre_doc;
    final response_avd = await apiService.getAvds();
    _avds = response_avd;
    final response_bl = await apiService.getBls();
    _bls = response_bl;
    final response_lta = await apiService.getLtas();
    _ltas = response_lta;
    final response_bfu = await apiService.getBfus();
    _bfus = response_bfu;
    final response_co = await apiService.getCos();
    _cos = response_co;
    final response_cps = await apiService.getCps();
    _cps = response_cps;
    final response_declaration = await apiService.getDeclarations();
    _declarations = response_declaration;
    final response_fiche_technique = await apiService.getFiches();
    _fiche_techniques = response_fiche_technique;
    final response_import_ordre = await apiService.getImportOrdre();
    _import_ordres = response_import_ordre;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteursDocuments() async {
    _isLoading = true;
    final response_bordereaux = await apiService.getTransporteurBordereaux();
    _bordereaux = response_bordereaux;
    final response_recues = await apiService.getTransporteurRecus();
    _recus = response_recues;
    final response_vgm = await apiService.getTransporteurVgm();
    _vgms = response_vgm;
    final response_tdo = await apiService.getTransporteurTdo();
    _tdos = response_tdo;
    final response_apeles = await apiService.getTransporteurApeles();
    _appeles = response_apeles;
    final response_interchange = await apiService.getTransporteurInterchange();
    _interchanges = response_interchange;
    final response_contrat = await apiService.getTransporteurContrat();
    _contrats = response_contrat;
    final response_paths = await apiService.getTransporteurPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitInterchanges() async {
    _isLoading = true;
    final response_interchange = await apiService.getInterchanges();
    _interchanges = response_interchange;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurInterchanges() async {
    _isLoading = true;
    final response_interchange = await apiService.getTransporteurInterchange();
    _interchanges = response_interchange;
    final response_paths = await apiService.getTransporteurPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitBordereaux() async {
    _isLoading = true;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_bordereaux = await apiService.getBordereaux();
    _bordereaux = response_bordereaux;
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_destinataire = await apiService.getDestinataires();
    _destinataires = response_destinataire;
    final response_transporteur = await apiService.getTransporteurs();
    _transporteurs = response_transporteur;
    final response_camions = await apiService.getCamions();
    _camions = response_camions;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitAutreDocs() async {
    _isLoading = true;
    final response = await apiService.getAutreDocs();
    _autre_docs = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitBL() async {
    _isLoading = true;
    final response = await apiService.getBls();
    _bls = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitLta() async {
    _isLoading = true;
    final response = await apiService.getLtas();
    _ltas = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitAvd() async {
    _isLoading = true;
    final response = await apiService.getAvds();
    _avds = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitBfu() async {
    _isLoading = true;
    final response = await apiService.getBfus();
    _bfus = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitDeclaration() async {
    _isLoading = true;
    final response = await apiService.getDeclarations();
    _declarations = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitFicheTechnique() async {
    _isLoading = true;
    final response = await apiService.getFiches();
    _fiche_techniques = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitCo() async {
    _isLoading = true;
    final response = await apiService.getCos();
    _cos = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitCps() async {
    _isLoading = true;
    final response = await apiService.getCps();
    _cps = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTdos() async {
    _isLoading = true;
    final response = await apiService.getTdos();
    _tdos = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitVgms() async {
    _isLoading = true;
    final response = await apiService.getVgms();
    _vgms = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitRecus() async {
    _isLoading = true;
    final response = await apiService.getRecus();
    _recus = response;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitApeles() async {
    _isLoading = true;
    final response_apeles = await apiService.getApeles();
    _appeles = response_apeles;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitImportOrdre() async {
    _isLoading = true;
    final response_odre = await apiService.getImportOrdre();
    _import_ordres = response_odre;
    final response_paths = await apiService.getPaths();
    _paths = response_paths;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitOrdres() async {
    _isLoading = true;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_ordre = await apiService.getOrdres();
    _ordres = response_ordre;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitForSomeOrdre() async {
    _isLoading = true;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_ordres = await apiService.getOrdres();
    _ordres = response_ordres;
    final response_expedition = await apiService.getExpeditions();
    _expeditions = response_expedition;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_destinataire = await apiService.getDestinataires();
    _destinataires = response_destinataire;
    final response_entite = await apiService.getEntiteFactures();
    _entite_factures = response_entite;
    final response_donneur = await apiService.getDonneurOrdres();
    _donneur_ordres = response_donneur;
    final response_entreprise = await apiService.getEntreprises();
    _entreprises = response_entreprise;
    final response_expediteur = await apiService.getExpediteurs();
    _expediteurs = response_expediteur;
    final response_transporteur = await apiService.getTransporteurs();
    _transporteurs = response_transporteur;
    final response_camions = await apiService.getCamions();
    _camions = response_camions;
    final response_users = await apiService.getUsers();
    _users = response_users;
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
