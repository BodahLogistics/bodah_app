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
import 'package:geolocator/geolocator.dart';

import '../../functions/function.dart';
import '../../modals/actualite.dart';
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
import '../../modals/paiement_solde.dart';
import '../../modals/path.dart';
import '../../modals/pays.dart';
import '../../modals/positions.dart';
import '../../modals/quartiers.dart';
import '../../modals/recepteurs.dart';
import '../../modals/recus.dart';
import '../../modals/rules.dart';
import '../../modals/signature.dart';
import '../../modals/transport_liaison.dart';
import '../../modals/transport_mode.dart';
import '../../modals/transporteurs.dart';
import '../../modals/type_camions.dart';
import '../../modals/type_chargements.dart';
import '../../modals/type_paiements.dart';
import '../../modals/vgms.dart';
import '../../services/secure_storage.dart';

class ApiProvider with ChangeNotifier {
  final apiService = DBServices();
  final function = Functions();
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
  List<PaiementSolde> _paiement_soldes = [];
  List<PaiementSolde> get paiement_soldes => _paiement_soldes;

  List<Positions> _positions = [];
  List<Positions> get positions => _positions;
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

  void setTrajet(AnnonceTransporteurs data) {
    _trajets.insert(0, data);
    notifyListeners();
  }

  void updateTrajet(AnnonceTransporteurs data) {
    int index = _trajets.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _trajets[index] = data;
      notifyListeners();
    }
  }

  void removeTrajet(AnnonceTransporteurs data) {
    _trajets.remove(data);
    notifyListeners();
  }

  void setInfoLocalisation(InfoLocalisations data) {
    _info_localisations.insert(0, data);
    notifyListeners();
  }

  void updateInfoLocalisation(InfoLocalisations data) {
    int index =
        _info_localisations.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _info_localisations[index] = data;
      notifyListeners();
    }
  }

  void setMarchandiseTransporteur(MarchandiseTransporteur data) {
    _marchandise_transporteurs.insert(0, data);
    notifyListeners();
  }

  void updateMarchandiseTransporteur(MarchandiseTransporteur data) {
    int index = _marchandise_transporteurs
        .indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _marchandise_transporteurs[index] = data;
      notifyListeners();
    }
  }

  void setCamion(Camions data) {
    _camions.insert(0, data);
    notifyListeners();
  }

  void updateCamion(Camions data) {
    int index = _camions.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _camions[index] = data;
      notifyListeners();
    }
  }

  void setPiece(Pieces data) {
    _pieces.insert(0, data);
    notifyListeners();
  }

  void updatePieces(Pieces data) {
    int index = _pieces.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _pieces[index] = data;
      notifyListeners();
    }
  }

  void setUtilisateur(Users data) {
    _users.insert(0, data);
    notifyListeners();
  }

  void updateUser(Users data) {
    int index = _users.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _users[index] = data;
      notifyListeners();
    }
  }

  void setTransporteur(Transporteurs data) {
    _transporteurs.insert(0, data);
    notifyListeners();
  }

  void updateTransporteur(Transporteurs data) {
    int index = _transporteurs.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _transporteurs[index] = data;
      notifyListeners();
    }
  }

  void setLiaison(TransportLiaisons data) {
    _chauffeurs.insert(0, data);
    notifyListeners();
  }

  void updateLiaison(TransportLiaisons data) {
    int index = _chauffeurs.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _chauffeurs[index] = data;
      notifyListeners();
    }
  }

  void removeLiaison(TransportLiaisons data) {
    _chauffeurs.remove(data);
    notifyListeners();
  }

  void setAnnonce(Annonces data) {
    _annonces.insert(0, data);
    notifyListeners();
  }

  void updateAnnonce(Annonces data) {
    int index = _annonces.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _annonces[index] = data;
      notifyListeners();
    }
  }

  void updateExpedition(Expeditions data) {
    int index = _expeditions.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _expeditions[index] = data;
      notifyListeners();
    }
  }

  void updateContrat(LetreVoitures data) {
    int index = _contrats.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _contrats[index] = data;
      notifyListeners();
    }
  }

  void updateBordereau(BordereauLivraisons data) {
    int index = _bordereaux.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _bordereaux[index] = data;
      notifyListeners();
    }
  }

  void removeAnnonce(Annonces data) {
    _annonces.remove(data);
    notifyListeners();
  }

  void setMarchandise(Marchandises data) {
    _marchandises.insert(0, data);
    notifyListeners();
  }

  void updateMarchandise(Marchandises data) {
    int index = _marchandises.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _marchandises[index] = data;
      notifyListeners();
    }
  }

  void setLocalisation(Localisations data) {
    _localisations.insert(0, data);
    notifyListeners();
  }

  void updateLocalisation(Localisations data) {
    int index = _localisations.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _localisations[index] = data;
      notifyListeners();
    }
  }

  void setTarification(Tarifications data) {
    _tarifications.insert(0, data);
    notifyListeners();
  }

  void updateTarification(Tarifications data) {
    int index = _tarifications.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _tarifications[index] = data;
      notifyListeners();
    }
  }

  void setAnnoncePhotos(List<AnnoncePhotos> datas) {
    _annonce_photos.addAll(datas);
    notifyListeners();
  }

  void setNotification(Notifications data) {
    _notifications.insert(0, data);
    notifyListeners();
  }

  void updateNotification(Notifications data) {
    int index = _notifications.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _notifications[index] = data;
      notifyListeners();
    }
  }

  void removeNotification(Notifications data) {
    _notifications.remove(data);
    notifyListeners();
  }

  void setBonCommande(BonCommandes data) {
    _ordres.insert(0, data);
    notifyListeners();
  }

  void updateBonCommande(BonCommandes data) {
    int index = _ordres.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _ordres[index] = data;
      notifyListeners();
    }
  }

  void removeBonCommande(BonCommandes data) {
    _ordres.remove(data);
    notifyListeners();
  }

  void setEntite(EntiteFactures data) {
    _entite_factures.insert(0, data);
    notifyListeners();
  }

  void setDonneurOrdre(DonneurOrdres data) {
    _donneur_ordres.insert(0, data);
    notifyListeners();
  }

  void setExpediteur(Expediteurs data) {
    _expediteurs.insert(0, data);
    notifyListeners();
  }

  void setEntreprise(Entreprises data) {
    _entreprises.insert(0, data);
    notifyListeners();
  }

  void setConducteur(Conducteur data) {
    _conducteurs.insert(0, data);
    notifyListeners();
  }

  void setClient(Client data) {
    _clients.insert(0, data);
    notifyListeners();
  }

  void setChargementEffectue(ChargementEffectue data) {
    _chargement_effectues.insert(0, data);
    notifyListeners();
  }

  void updateChargementEffectue(ChargementEffectue data) {
    int index =
        _chargement_effectues.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _chargement_effectues[index] = data;
      notifyListeners();
    }
  }

  void removeChargementEffectue(ChargementEffectue data) {
    _chargement_effectues.remove(data);
    notifyListeners();
  }

  setChargementEffectues(List<ChargementEffectue> datas) {
    _chargement_effectues.addAll(datas);
    notifyListeners();
  }

  void setLivraison(LivraisonCargaison data) {
    _livraisons.insert(0, data);
    notifyListeners();
  }

  void updateLivraison(LivraisonCargaison data) {
    int index = _livraisons.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _livraisons[index] = data;
      notifyListeners();
    }
  }

  void removeLivraison(LivraisonCargaison data) {
    _livraisons.remove(data);
    notifyListeners();
  }

  setLivraisons(List<LivraisonCargaison> datas) {
    _livraisons.addAll(datas);
    notifyListeners();
  }

  setCargaisons(List<Cargaison> datas) {
    _cargaisons.addAll(datas);
    notifyListeners();
  }

  void setCargaison(Cargaison data) {
    _cargaisons.insert(0, data);
    notifyListeners();
  }

  void updateCargaison(Cargaison data) {
    int index = _cargaisons.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _cargaisons[index] = data;
      notifyListeners();
    }
  }

  void removeCargaison(Cargaison data) {
    _cargaisons.remove(data);
    notifyListeners();
  }

  setCargaions(List<Cargaison> datas) {
    _cargaisons.addAll(datas);
    notifyListeners();
  }

  void setTarif(Tarif data) {
    _tarifs.insert(0, data);
    notifyListeners();
  }

  void updateTarif(Tarif data) {
    int index = _tarifs.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _tarifs[index] = data;
      notifyListeners();
    }
  }

  void setPosition(Positions data) {
    _positions.insert(0, data);
    notifyListeners();
  }

  void updatePosition(Positions data) {
    int index = _positions.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _positions[index] = data;
      notifyListeners();
    }
  }

  void setChargements(Chargement data) {
    _chargements.insert(0, data);
    notifyListeners();
  }

  void updateChargement(Chargement data) {
    int index = _chargements.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _chargements[index] = data;
      notifyListeners();
    }
  }

  void setCargaisonClient(CargaisonClient data) {
    _cargaison_clients.insert(0, data);
    notifyListeners();
  }

  void updateCargaisonClient(CargaisonClient data) {
    int index =
        _cargaison_clients.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _cargaison_clients[index] = data;
      notifyListeners();
    }
  }

  void removeCargaisonClient(CargaisonClient data) {
    _cargaison_clients.remove(data);
    notifyListeners();
  }

  setCargaisonClients(List<CargaisonClient> datas) {
    _cargaison_clients.addAll(datas);
    notifyListeners();
  }

  void setImport(Import data) {
    _imports.insert(0, data);
    notifyListeners();
  }

  void updateImport(Import data) {
    int index = _imports.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _imports[index] = data;
      notifyListeners();
    }
  }

  void removeImport(Import data) {
    _imports.remove(data);
    notifyListeners();
  }

  void setExport(Exports data) {
    _exports.insert(0, data);
    notifyListeners();
  }

  void updateExport(Exports data) {
    int index = _exports.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _exports[index] = data;
      notifyListeners();
    }
  }

  void removeExport(Exports data) {
    _exports.remove(data);
    notifyListeners();
  }

  void setSouscription(Souscriptions data) {
    _souscriptions.insert(0, data);
    notifyListeners();
  }

  void removeSouscription(Souscriptions data) {
    _souscriptions.remove(data);
    notifyListeners();
  }

  void setLta(Lta data) {
    _ltas.insert(0, data);
    notifyListeners();
  }

  void updateLta(Lta data) {
    int index = _ltas.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _ltas[index] = data;
      notifyListeners();
    }
  }

  void removeLta(Lta data) {
    _ltas.remove(data);
    notifyListeners();
  }

  void setBl(Bl data) {
    _bls.insert(0, data);
    notifyListeners();
  }

  void updateBl(Bl data) {
    int index = _bls.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _bls[index] = data;
      notifyListeners();
    }
  }

  void removeBl(Bl data) {
    _bls.remove(data);
    notifyListeners();
  }

  void setTdo(Tdos data) {
    _tdos.insert(0, data);
    notifyListeners();
  }

  void updateTdo(Tdos data) {
    int index = _tdos.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _tdos[index] = data;
      notifyListeners();
    }
  }

  void removeTdo(Tdos data) {
    _tdos.remove(data);
    notifyListeners();
  }

  void setVgm(Vgms data) {
    _vgms.insert(0, data);
    notifyListeners();
  }

  void updateVgm(Vgms data) {
    int index = _vgms.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _vgms[index] = data;
      notifyListeners();
    }
  }

  void removeVgm(Vgms data) {
    _vgms.remove(data);
    notifyListeners();
  }

  void setAppele(Appeles data) {
    _appeles.insert(0, data);
    notifyListeners();
  }

  void updateAppele(Appeles data) {
    int index = _appeles.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _appeles[index] = data;
      notifyListeners();
    }
  }

  void removeAppele(Appeles data) {
    _appeles.remove(data);
    notifyListeners();
  }

  void setOrdre(OrdreTransport data) {
    _import_ordres.insert(0, data);
    notifyListeners();
  }

  void updateOrdre(OrdreTransport data) {
    int index = _import_ordres.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _import_ordres[index] = data;
      notifyListeners();
    }
  }

  void removeOrdre(OrdreTransport data) {
    _import_ordres.remove(data);
    notifyListeners();
  }

  void setInterchange(Interchanges data) {
    _interchanges.insert(0, data);
    notifyListeners();
  }

  void updateInterchange(Interchanges data) {
    int index = _interchanges.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _interchanges[index] = data;
      notifyListeners();
    }
  }

  void removeInterchange(Interchanges data) {
    _interchanges.remove(data);
    notifyListeners();
  }

  void setRecu(Recus data) {
    _recus.insert(0, data);
    notifyListeners();
  }

  void updateRecu(Recus data) {
    int index = _recus.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _recus[index] = data;
      notifyListeners();
    }
  }

  void removeRecu(Recus data) {
    _recus.remove(data);
    notifyListeners();
  }

  void setAvd(Avd data) {
    _avds.insert(0, data);
    notifyListeners();
  }

  void updateAvd(Avd data) {
    int index = _avds.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _avds[index] = data;
      notifyListeners();
    }
  }

  void removeAvd(Avd data) {
    _avds.remove(data);
    notifyListeners();
  }

  void setDeclaration(Declaration data) {
    _declarations.insert(0, data);
    notifyListeners();
  }

  void updateDeclaration(Declaration data) {
    int index = _declarations.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _declarations[index] = data;
      notifyListeners();
    }
  }

  void removeDeclaration(Declaration data) {
    _declarations.remove(data);
    notifyListeners();
  }

  void setFiche(FicheTechnique data) {
    _fiche_techniques.insert(0, data);
    notifyListeners();
  }

  void updateFiche(FicheTechnique data) {
    int index =
        _fiche_techniques.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _fiche_techniques[index] = data;
      notifyListeners();
    }
  }

  void removeFicheTechnique(FicheTechnique data) {
    _fiche_techniques.remove(data);
    notifyListeners();
  }

  void setCo(CO data) {
    _cos.insert(0, data);
    notifyListeners();
  }

  void updateCo(CO data) {
    int index = _cos.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _cos[index] = data;
      notifyListeners();
    }
  }

  void removeCo(CO data) {
    _cos.remove(data);
    notifyListeners();
  }

  void setCps(CPS data) {
    _cps.insert(0, data);
    notifyListeners();
  }

  void updateCps(CPS data) {
    int index = _cps.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _cps[index] = data;
      notifyListeners();
    }
  }

  void removeCps(CPS data) {
    _cps.remove(data);
    notifyListeners();
  }

  void setBfu(Bfu data) {
    _bfus.insert(0, data);
    notifyListeners();
  }

  void updateBfu(Bfu data) {
    int index = _bfus.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _bfus[index] = data;
      notifyListeners();
    }
  }

  void removeBfu(Bfu data) {
    _bfus.remove(data);
    notifyListeners();
  }

  void setAutreDoc(AutreDocs data) {
    _autre_docs.insert(0, data);
    notifyListeners();
  }

  void setSignature(Signatures data) {
    _signatures.insert(0, data);
    notifyListeners();
  }

  void updateAutreDoc(AutreDocs data) {
    int index = _autre_docs.indexWhere((account) => account.id == data.id);
    if (index != -1) {
      _autre_docs[index] = data;
      notifyListeners();
    }
  }

  void removeAutreDoc(AutreDocs data) {
    _autre_docs.remove(data);
    notifyListeners();
  }

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

  List<Actualites> _actualites = [];
  List<Actualites> get actualites => _actualites;

  List<Souscriptions> _souscriptions = [];
  List<Souscriptions> get souscriptions => _souscriptions;

  List<TransportLiaisons> _chauffeurs = [];
  List<TransportLiaisons> get chauffeurs => _chauffeurs;

  List<TypePaiements> _type_paiements = [];
  List<TypePaiements> get type_piaments => _type_paiements;

  List<Signatures> _signatures = [];
  List<Signatures> get signatures => _signatures;

  Future<void> InitData() async {
    _isLoading = true;
    try {
      String device = await function.getDeviceModel();
      Position? position = await function.getLocation();
      await apiService.createVisiteur(
          device, position?.longitude ?? 0, position?.latitude ?? 0, "", "");

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

      final response_pays = await apiService.getPays();
      _pays = response_pays;

      if (_user != null && _rule != null) {
        if (user!.is_active == 1 &&
            user!.is_verified == 1 &&
            user!.deleted == 0) {
          final response_actualite = await apiService.getActualites();
          _actualites = response_actualite;
          if (_rule!.nom == "Expéditeur") {
            final response_unites = await apiService.getUnites();
            _unites = response_unites;
            final response_devises = await apiService.getDevises();
            _devises = response_devises;
            final response_transport_mode = await apiService.getTransportMode();
            _transport_modes = response_transport_mode;
            await InitAnnonce();
            await InitImport();
            await InitDocuments();
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
            final response_expedition = await apiService.getExpeditions();
            _expeditions = response_expedition;
            final response_entite = await apiService.getEntiteFactures();
            _entite_factures = response_entite;
            final response_donneur = await apiService.getDonneurOrdres();
            _donneur_ordres = response_donneur;
            final response_transporteur = await apiService.getTransporteurs();
            _transporteurs = response_transporteur;
            final response_camions = await apiService.getCamions();
            _camions = response_camions;
            final response_charge = await apiService.getCharges();
            _charges = response_charge;
            final response_tarif = await apiService.getTarifs();
            _tarifs = response_tarif;
            final response_piece = await apiService.getPieces();
            _pieces = response_piece;
            final response_soldes = await apiService.getPaiementSoldes();
            _paiement_soldes = response_soldes;
            final response_signature = await apiService.getSignatures();
            _signatures = response_signature;
          } else {
            final response_signature =
                await apiService.getTransporteurSignatures();
            _signatures = response_signature;
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
            final response_recues = await apiService.getTransporteurRecus();
            _recus = response_recues;
            final response_vgm = await apiService.getTransporteurVgm();
            _vgms = response_vgm;
            final response_tdo = await apiService.getTransporteurTdo();
            _tdos = response_tdo;
            final response_apeles = await apiService.getTransporteurApeles();
            _appeles = response_apeles;
            final response_interchange =
                await apiService.getTransporteurInterchange();
            _interchanges = response_interchange;
            final response_chauffeurs = await apiService.getChauffeurs();
            _chauffeurs = response_chauffeurs;
            final response_users = await apiService.getUsers();
            _users = response_users;
            final response_piece = await apiService.getTransporteurPieces();
            _pieces = response_piece;
            final response_marchandise =
                await apiService.getTrajetMarchandise();
            _marchandise_transporteurs = response_marchandise;
            final response_localisation =
                await apiService.getInfoLocalisations();
            _info_localisations = response_localisation;
            final response_souscription = await apiService.getSouscription();
            _souscriptions = response_souscription;
            final response_expedition =
                await apiService.getTransporteurExpditions();
            _expeditions = response_expedition;
            final response_charge = await apiService.getTransporteurCharge();
            _charges = response_charge;
            final response_tarif = await apiService.getTransporteurTarif();
            _tarifs = response_tarif;
            final response_soldes =
                await apiService.getTransporteurPaiementSoldes();
            _paiement_soldes = response_soldes;
          }

          final response_type_chargement =
              await apiService.getTypeChargements();
          _type_chargements = response_type_chargement;
          final response_type_pay = await apiService.getTypePaiements();
          _type_paiements = response_type_pay;
          final response_unite = await apiService.getUnites();
          _unites = response_unite;
          final response_statuts = await apiService.getStatutExpeditions();
          _statut_expeditions = response_statuts;
        }
      }

      _isLoading = false;
    } catch (e) {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> Init() async {
    _isLoading = true;
    try {
      final response_users = await apiService.getUsers();
      _users = response_users;
      final response_pays = await apiService.getPays();
      _pays = response_pays;
      final response_rule = await apiService.getRules();
      _rules = response_rule;
      final response_statuts = await apiService.getStatuts();
      _statuts = response_statuts;
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

  Future<void> InitActualites() async {
    _isLoading = true;
    final response = await apiService.getActualites();
    _actualites = response;
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
    final response_soldes = await apiService.getPaiementSoldes();
    _paiement_soldes = response_soldes;
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
    final response_soldes = await apiService.getTransporteurPaiementSoldes();
    _paiement_soldes = response_soldes;
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

    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurContrat() async {
    _isLoading = true;
    final response_contrat = await apiService.getTransporteurContrat();
    _contrats = response_contrat;
    final response_signature = await apiService.getTransporteurSignatures();
    _signatures = response_signature;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurInterchange() async {
    _isLoading = true;
    final response_interchange = await apiService.getTransporteurInterchange();
    _interchanges = response_interchange;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurAppele() async {
    _isLoading = true;
    final response_apeles = await apiService.getTransporteurApeles();
    _appeles = response_apeles;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurTdo() async {
    _isLoading = true;
    final response_tdo = await apiService.getTransporteurTdo();
    _tdos = response_tdo;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurVgms() async {
    _isLoading = true;
    final response_vgm = await apiService.getTransporteurVgm();
    _vgms = response_vgm;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurRecus() async {
    _isLoading = true;
    final response_recues = await apiService.getTransporteurRecus();
    _recus = response_recues;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurBordereau() async {
    _isLoading = true;
    final response_bordereaux = await apiService.getTransporteurBordereaux();
    _bordereaux = response_bordereaux;
    final response_signature = await apiService.getTransporteurSignatures();
    _signatures = response_signature;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitInterchanges() async {
    _isLoading = true;
    final response_interchange = await apiService.getInterchanges();
    _interchanges = response_interchange;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTransporteurInterchanges() async {
    _isLoading = true;
    final response_interchange = await apiService.getTransporteurInterchange();
    _interchanges = response_interchange;
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
    final response_signature = await apiService.getSignatures();
    _signatures = response_signature;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitAutreDocs() async {
    _isLoading = true;
    final response = await apiService.getAutreDocs();
    _autre_docs = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitBL() async {
    _isLoading = true;
    final response = await apiService.getBls();
    _bls = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitLta() async {
    _isLoading = true;
    final response = await apiService.getLtas();
    _ltas = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitAvd() async {
    _isLoading = true;
    final response = await apiService.getAvds();
    _avds = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitBfu() async {
    _isLoading = true;
    final response = await apiService.getBfus();
    _bfus = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitDeclaration() async {
    _isLoading = true;
    final response = await apiService.getDeclarations();
    _declarations = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitFicheTechnique() async {
    _isLoading = true;
    final response = await apiService.getFiches();
    _fiche_techniques = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitCo() async {
    _isLoading = true;
    final response = await apiService.getCos();
    _cos = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitCps() async {
    _isLoading = true;
    final response = await apiService.getCps();
    _cps = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitTdos() async {
    _isLoading = true;
    final response = await apiService.getTdos();
    _tdos = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitVgms() async {
    _isLoading = true;
    final response = await apiService.getVgms();
    _vgms = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitRecus() async {
    _isLoading = true;
    final response = await apiService.getRecus();
    _recus = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitApeles() async {
    _isLoading = true;
    final response_apeles = await apiService.getApeles();
    _appeles = response_apeles;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> InitImportOrdre() async {
    _isLoading = true;
    final response_odre = await apiService.getImportOrdre();
    _import_ordres = response_odre;
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
    final response_signature = await apiService.getSignatures();
    _signatures = response_signature;
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
