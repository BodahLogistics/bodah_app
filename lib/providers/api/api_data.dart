// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:bodah/modals/annonce_colis.dart';
import 'package:bodah/modals/annonce_photos.dart';
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
import 'package:bodah/modals/import.dart';
import 'package:bodah/modals/livraison_cargaison.dart';
import 'package:bodah/modals/location_colis.dart';
import 'package:bodah/modals/marchandises.dart';
import 'package:bodah/modals/notifications.dart';
import 'package:bodah/modals/pieces.dart';
import 'package:bodah/modals/statut_operations.dart';
import 'package:bodah/modals/statuts.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/tarifs.dart';
import 'package:bodah/modals/tdos.dart';
import 'package:bodah/modals/trajets.dart';
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
import '../../modals/interchanges.dart';
import '../../modals/localisations.dart';
import '../../modals/lta.dart';
import '../../modals/pays.dart';
import '../../modals/positions.dart';
import '../../modals/quartiers.dart';
import '../../modals/recepteurs.dart';
import '../../modals/recus.dart';
import '../../modals/rules.dart';
import '../../modals/transport_mode.dart';
import '../../modals/transporteurs.dart';
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
  List<Trajets> _trajets = [];
  List<Trajets> get trajets => _trajets;
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

  Future<void> InitImport() async {
    _isLoading = true;
    final response_import = await apiService.getImports();
    _imports = response_import;
    final response_route_key = await apiService.getImportRouteKey();
    _import_route_key = response_route_key;
    final response_maritime_key = await apiService.getImportMaritimeKey();
    _import_maritime_key = response_maritime_key;
    final response_aerien_key = await apiService.getImportAerienKey();
    _import_aerien_key = response_aerien_key;
    final response_cargaison = await apiService.getCargaisons();
    _cargaisons = response_cargaison;
    final response_cargaison_client = await apiService.getCargaisonClients();
    _cargaison_clients = response_cargaison_client;
    final response_position = await apiService.getPositions();
    _positions = response_position;
    final response_chargement = await apiService.getChargements();
    _chargements = response_chargement;
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

  Future<void> InitData() async {
    _isLoading = true;
    final response_users = await apiService.getUsers();
    _users = response_users;

    final response = await apiService.user();
    _user = response[0];
    final response_pays = await apiService.getPays();
    _pays = response_pays;
    final response_role = await apiService.getRules();
    _rules = response_role;
    final response_statuts = await apiService.getStatuts();
    _statuts = response_statuts;

    _roles = response[1];
    final response_unites = await apiService.getUnites();
    _unites = response_unites;
    final response_type_chargement = await apiService.getTypeChargements();
    _type_chargements = response_type_chargement;
    final response_devises = await apiService.getDevises();
    _devises = response_devises;
    final response_transport_mode = await apiService.getTransportMode();
    _transport_modes = response_transport_mode;
    await InitAnnonce();
    await InitImport();

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

  Future<void> InitExpedition() async {
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
    final response_destinataire = await apiService.getDestinataires();
    _destinataires = response_destinataire;
    final response_transporteur = await apiService.getTransporteurs();
    _transporteurs = response_transporteur;
    final response_camions = await apiService.getCamions();
    _camions = response_camions;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitForSomeAnnonce() async {
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
    final response_destinataire = await apiService.getDestinataires();
    _destinataires = response_destinataire;
    final response_entreprise = await apiService.getEntreprises();
    _entreprises = response_entreprise;
    final response_expediteur = await apiService.getExpediteurs();
    _expediteurs = response_expediteur;
    final response_users = await apiService.getUsers();
    _users = response_users;
    final response_ordres = await apiService.getOrdres();
    _ordres = response_ordres;
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

  Future<void> InitInterchanges() async {
    _isLoading = true;
    final response = await apiService.getInterchanges();
    _interchanges = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitAutreDocs() async {
    _isLoading = true;
    final response = await apiService.getAutreDocs();
    _autre_docs = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitBL() async {
    _isLoading = true;
    final response = await apiService.getBls();
    _bls = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitLta() async {
    _isLoading = true;
    final response = await apiService.getLtas();
    _ltas = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitAvd() async {
    _isLoading = true;
    final response = await apiService.getAvds();
    _avds = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitBfu() async {
    _isLoading = true;
    final response = await apiService.getBfus();
    _bfus = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitDeclaration() async {
    _isLoading = true;
    final response = await apiService.getDeclarations();
    _declarations = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitFicheTechnique() async {
    _isLoading = true;
    final response = await apiService.getFiches();
    _fiche_techniques = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitCo() async {
    _isLoading = true;
    final response = await apiService.getCos();
    _cos = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitCps() async {
    _isLoading = true;
    final response = await apiService.getCps();
    _cps = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTdos() async {
    _isLoading = true;
    final response = await apiService.getTdos();
    _tdos = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitVgms() async {
    _isLoading = true;
    final response = await apiService.getVgms();
    _vgms = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitRecus() async {
    _isLoading = true;
    final response = await apiService.getRecus();
    _recus = response;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitApeles() async {
    _isLoading = true;
    final response_apeles = await apiService.getApeles();
    _appeles = response_apeles;
    final response_annonce = await apiService.getAnnonces();
    _annonces = response_annonce;
    final response_localisation = await apiService.getLocalisations();
    _localisations = response_localisation;
    final response_marchandise = await apiService.getMarchandises();
    _marchandises = response_marchandise;
    final response_all_villes = await apiService.getAllVilles();
    _all_villes = response_all_villes;
    final response_tarification = await apiService.getTarifications();
    _tarifications = response_tarification;
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
