// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_string_escapes

import 'dart:math';

import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/avds.dart';
import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/modals/certificat_phyto_sanitaire.dart';
import 'package:bodah/modals/chargement_effectues.dart';
import 'package:bodah/modals/client.dart';
import 'package:bodah/modals/declaration.dart';
import 'package:bodah/modals/destinataires.dart';
import 'package:bodah/modals/devises.dart';
import 'package:bodah/modals/donneur_ordres.dart';
import 'package:bodah/modals/entreprises.dart';
import 'package:bodah/modals/exports.dart';
import 'package:bodah/modals/livraison_cargaison.dart';
import 'package:bodah/modals/lta.dart';
import 'package:bodah/modals/pieces.dart';
import 'package:bodah/modals/positions.dart';
import 'package:bodah/modals/recus.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/tarifs.dart';
import 'package:bodah/modals/tdos.dart';
import 'package:bodah/modals/transport_mode.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/modals/vgms.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/annonces.dart';
import '../modals/appeles.dart';
import '../modals/autre_docs.dart';
import '../modals/bfus.dart';
import '../modals/bl.dart';
import '../modals/camions.dart';
import '../modals/cargaison.dart';
import '../modals/cargaison_client.dart';
import '../modals/cartificat_origine.dart';
import '../modals/chargement.dart';
import '../modals/charges.dart';
import '../modals/conducteur.dart';
import '../modals/entite_factures.dart';
import '../modals/expediteurs.dart';
import '../modals/expeditions.dart';
import '../modals/fiche_technique.dart';
import '../modals/import.dart';
import '../modals/interchanges.dart';
import '../modals/localisations.dart';
import '../modals/marchandises.dart';
import '../modals/ordre_transport.dart';
import '../modals/path.dart';
import '../modals/pays.dart';
import '../modals/rules.dart';
import '../modals/statuts.dart';
import '../modals/transporteurs.dart';
import '../modals/type_chargements.dart';
import '../modals/users.dart';
import '../modals/villes.dart';

class Functions {
  bool cant_delete_annonce(List<Expeditions> expeditions, BonCommandes ordre) {
    if (expeditions.isNotEmpty || ordre.id > 0) {
      return false;
    }

    return true;
  }

  double calculateHeight(
      int itemCount, int crossAxisCount, double aspectRatio) {
    final rows = (itemCount / crossAxisCount).ceil();
    return rows * (180 / aspectRatio); // Ajustez 200 selon la hauteur estimée
  }

  Lta lta(List<Lta> ltas, int id) {
    return ltas.firstWhere(
      (data) => data.id == id,
      orElse: () => Lta(
          id: id,
          path: "",
          modele_id: 0,
          deleted: 0,
          modele_type: "",
          reference: "",
          created_at: DateTime.now(),
          updated_at: DateTime.now()),
    );
  }

  BordereauLivraisons bordereau(List<BordereauLivraisons> bordereaux, int id) {
    return bordereaux.firstWhere(
      (data) => data.id == id,
      orElse: () => BordereauLivraisons(
        id: id,
        expedition_id: 0,
        numero_borderau: '',
        observation_id: 0,
      ),
    );
  }

  Marchandises expedition_marchandise(Expeditions expedition,
      List<Marchandises> marchandises, List<Annonces> annonces) {
    Annonces announce = annonce(annonces, expedition.annonce_id);
    List<Marchandises> datas = annonce_marchandises(marchandises, announce.id);

    return firstMarchandise(datas);
  }

  String immatriculation(String? num_immatricualtion) {
    return num_immatricualtion ?? "Non défini";
  }

  TypeChargements type_chargement(
      List<TypeChargements> type_chargements, int? id) {
    return type_chargements.firstWhere(
      (data) => data.id == id,
      orElse: () => TypeChargements(id: 0, name: ""),
    );
  }

  Statuts statut(List<Statuts> statuts, int id) {
    return statuts.firstWhere(
      (data) => data.id == id,
      orElse: () => Statuts(id: 0, name: ""),
    );
  }

  List<Charge> expedition_charges(
      List<Charge> charges, Expeditions expedition) {
    return charges
        .where((data) =>
            data.chargement_type.contains("Expedition") &&
            data.chargement_id == expedition.id)
        .toList();
  }

  List<Charge> marchandise_charges(
      List<Charge> charges, Marchandises marchandise) {
    return charges
        .where((data) =>
            data.cargaison_type.contains("Marchandise") &&
            data.cargaison_id == marchandise.id)
        .toList();
  }

  Tarif charge_tarif(List<Tarif> tarifs, Charge charge) {
    return tarifs.firstWhere(
      (data) =>
          data.modele_id == charge.id && data.modele_type.contains("Charge"),
      orElse: () =>
          Tarif(id: 0, montant: 0, accompte: 0, modele_type: "", modele_id: 0),
    );
  }

  List<Expeditions> annonce_expeditions(
      List<Expeditions> expeditions, Annonces annonce) {
    return expeditions.where((data) => data.annonce_id == annonce.id).toList();
  }

  Devises devise(List<Devises> devises, int? id) {
    return devises.firstWhere(
      (data) => data.id == id,
      orElse: () => Devises(id: 0, nom: ""),
    );
  }

  BonCommandes annonce_bon_commande(
      List<BonCommandes> ordres, Annonces annonce) {
    return ordres.firstWhere(
      (data) => data.annonce_id == annonce.id,
      orElse: () => BonCommandes(
          id: 0,
          numero_bon_commande: "",
          is_validated: 0,
          description: "",
          delai_chargement: 0,
          amende_delai_chargement: 0,
          amende_dechargement: 0,
          montant_paye: 0,
          annonce_id: 0,
          donneur_ordre_id: 0,
          entite_facture_id: 0,
          deleted: 0,
          created_at: DateTime.now(),
          updated_at: DateTime.now()),
    );
  }

  Annonces marchandise_annonce(
      List<Annonces> annonces, Marchandises marchandise) {
    return annonces.firstWhere(
      (data) => data.id == marchandise.annonce_id,
      orElse: () => Annonces(
          id: 0,
          numero_annonce: "",
          is_active: 0,
          user_id: 0,
          deleted: 0,
          expediteur_id: 0,
          created_at: DateTime.now(),
          updated_at: DateTime.now()),
    );
  }

  Destinataires marchandise_destinataire(
      List<Destinataires> destinataires, Marchandises marchandise) {
    return destinataires.firstWhere(
      (data) => data.id == marchandise.destinataire_id,
      orElse: () =>
          Destinataires(id: 0, numero_destinataire: "", user_id: 0, deleted: 0),
    );
  }

  Camions expedition_camion(List<Camions> camions, Expeditions expedition) {
    return camions.firstWhere(
      (data) => data.id == expedition.vehicule_id,
      orElse: () => Camions(
          id: 0, type_vehicule_id: 0, modele_type: '', num_immatriculation: ''),
    );
  }

  Transporteurs expedition_transporteur(
      List<Transporteurs> transporteurs, Expeditions expedition) {
    return transporteurs.firstWhere(
      (data) => data.id == expedition.transporteur_id,
      orElse: () =>
          Transporteurs(id: 0, numero_transporteur: "", user_id: 0, deleted: 0),
    );
  }

  List<Cargaison> data_cargaisons(
      List<Cargaison> cargaisons, int id, String modele) {
    List<Cargaison> datas = cargaisons
        .where(
            (data) => data.modele_type.contains(modele) && data.modele_id == id)
        .toList();
    return datas;
  }

  List<ChargementEffectue> data_chargemnt_effectues(
      List<ChargementEffectue> chargements, int id, String modele) {
    List<ChargementEffectue> datas = chargements
        .where(
            (data) => data.modele_type.contains(modele) && data.modele_id == id)
        .toList();
    return datas;
  }

  List<LivraisonCargaison> data_livraisons(
      List<LivraisonCargaison> livraisons, int id, String modele) {
    List<LivraisonCargaison> datas = livraisons
        .where(
            (data) => data.modele_type.contains(modele) && data.modele_id == id)
        .toList();
    return datas;
  }

  Pieces conducteur_piece(List<Pieces> pieces, Conducteur conducteur) {
    return pieces.firstWhere(
      (data) =>
          data.modele_id == conducteur.id &&
          data.modele_type.contains("Conducteur"),
      orElse: () => Pieces(id: 0, num_piece: "", modele_id: 0, modele_type: ""),
    );
  }

  Pieces data_piece(List<Pieces> pieces, int data_id, String data_modele) {
    return pieces.firstWhere(
      (data) =>
          data.modele_id == data_id && data.modele_type.contains(data_modele),
      orElse: () => Pieces(id: 0, num_piece: "", modele_id: 0, modele_type: ""),
    );
  }

  Camions chargement_camion(
      List<Camions> camions, ChargementEffectue chargement_effectue) {
    return camions.firstWhere(
      (data) => data.id == chargement_effectue.vehicule_id,
      orElse: () => Camions(id: 0, num_immatriculation: "", modele_type: ""),
    );
  }

  Camions camion(List<Camions> camions, int id) {
    return camions.firstWhere(
      (data) => data.id == id,
      orElse: () => Camions(id: 0, num_immatriculation: "", modele_type: ""),
    );
  }

  Conducteur chargement_chauffeur(
      List<Conducteur> conducteurs, ChargementEffectue chargement_effectue) {
    return conducteurs.firstWhere(
      (data) => data.id == chargement_effectue.conducteur_id,
      orElse: () => Conducteur(
          id: 0,
          reference: "",
          nom: "",
          telephone: "",
          country_id: 0,
          deleted: 0),
    );
  }

  List<CargaisonClient> cargaison_cargaison_clients(
      Cargaison cargaison, List<CargaisonClient> cargaison_clients) {
    List<CargaisonClient> datas = cargaison_clients
        .where((data) => data.cargaison_id == cargaison.id)
        .toList();

    return datas;
  }

  Client client(List<Client> clients, int id) {
    return clients.firstWhere(
      (data) => data.id == id,
      orElse: () => Client(
          id: 0,
          reference: "",
          nom: "",
          telephone: "",
          country_id: 0,
          deleted: 0),
    );
  }

  Position cargaison_client_position(
      List<Position> positions, CargaisonClient cargaison_client) {
    return positions.firstWhere(
      (data) =>
          data.modele_type.contains("CargaisonClient") &&
          data.modele_id == cargaison_client.id,
      orElse: () => Position(
          id: 0,
          pay_dep_id: 0,
          pay_liv_id: 0,
          city_dep_id: 0,
          city_liv_id: 0,
          modele_id: 0,
          modele_type: "",
          deleted: 0),
    );
  }

  Position chargement_effectue_position(
      List<Position> positions, ChargementEffectue chargement_effectue) {
    return positions.firstWhere(
      (data) =>
          data.modele_type.contains("ChargementEffectue") &&
          data.modele_id == chargement_effectue.id,
      orElse: () => Position(
          id: 0,
          pay_dep_id: 0,
          pay_liv_id: 0,
          city_dep_id: 0,
          city_liv_id: 0,
          modele_id: 0,
          modele_type: "",
          deleted: 0),
    );
  }

  Tarif chargement_effectue_tarif(
      List<Tarif> tarifs, ChargementEffectue chargement_effecue) {
    return tarifs.firstWhere(
        (data) =>
            data.modele_type.contains("ChargementEffectue") &&
            data.modele_id == chargement_effecue.id,
        orElse: () => Tarif(
              id: 0,
              montant: 0,
              accompte: 0,
              modele_type: "",
              modele_id: 0,
            ));
  }

  Cargaison cargaison(List<Cargaison> cargaisons, int id) {
    return cargaisons.firstWhere((data) => data.id == id,
        orElse: () => Cargaison(
            id: 0,
            reference: "",
            modele_type: "",
            modele_id: 0,
            nom: "",
            deleted: 0));
  }

  Chargement cargaison_client_chargement(
      List<Chargement> chargements, CargaisonClient cargaison_client) {
    return chargements.firstWhere(
        (data) =>
            data.modele_type.contains("CargaisonClient") &&
            data.modele_id == cargaison_client.id,
        orElse: () => Chargement(
            id: 0, modele_id: 0, modele_type: "", debut: DateTime.now()));
  }

  Import import(List<Import> imports, int id) {
    return imports.firstWhere(
      (data) => data.id == id,
      orElse: () => Import(
          id: id,
          reference: "",
          transport_mode_id: 0,
          expediteur_id: 0,
          deleted: 0),
    );
  }

  Exports export(List<Exports> exports, int id) {
    return exports.firstWhere(
      (data) => data.id == id,
      orElse: () => Exports(
          id: id,
          reference: "",
          transport_mode_id: 0,
          expediteur_id: 0,
          deleted: 0),
    );
  }

  TransportMode transport_mode(List<TransportMode> type_transports, int id) {
    return type_transports.firstWhere(
      (data) => data.id == id,
      orElse: () => TransportMode(id: 0, nom: ""),
    );
  }

  List<String> couleurs = [
    '#FF0000',
    '#00FF00',
    '#0000FF',
    '#FFFF00',
    '#FF00FF',
    '#00FFFF',
    '#FFA500',
    '#800080',
    '#808000',
    '#008080',
    '#C0C0C0',
    '#808080',
    '#800000',
    '#008000',
    '#000080',
    '#FFFFFF',
    '#000000',
    '#F0F8FF',
    '#FAEBD7',
    '#00FFFF',
    '#7FFFD4',
    '#F0FFFF',
    '#F5F5DC',
    '#FFE4C4',
    '#000000',
    '#FFEBCD',
    '#0000FF',
    '#8A2BE2',
    '#A52A2A',
    '#DEB887',
    '#5F9EA0',
    '#7FFF00',
    '#D2691E',
    '#FF7F50',
    '#6495ED',
    '#FFF8DC',
    '#DC143C',
    '#00FFFF',
    '#00008B',
    '#008B8B',
    '#B8860B',
    '#A9A9A9',
    '#006400',
    '#BDB76B',
    '#8B008B',
    '#556B2F',
    '#FF8C00',
    '#9932CC',
    '#8B0000',
    '#E9967A',
    '#8FBC8F',
    '#483D8B',
    '#2F4F4F',
    '#2F4F4F',
    '#00CED1',
    '#9400D3',
    '#FF1493',
    '#00BFFF',
    '#696969',
    '#696969',
    '#1E90FF',
    '#B22222',
    '#FFFAF0',
    '#228B22',
    '#FF00FF',
    '#DCDCDC',
    '#F8F8FF',
    '#FFD700',
    '#DAA520',
    '#808080',
    '#008000',
    '#ADFF2F',
    '#F0FFF0',
    '#FF69B4',
    '#CD5C5C',
    '#4B0082',
    '#FFFFF0',
    '#F0E68C',
    '#E6E6FA',
    '#FFF0F5',
    '#7CFC00',
    '#FFFACD',
    '#ADD8E6',
    '#F08080',
    '#E0FFFF',
    '#FAFAD2',
    '#D3D3D3',
    '#90EE90',
    '#FFB6C1',
    '#FFA07A',
    '#20B2AA',
    '#87CEFA',
    '#778899',
    '#778899',
    '#B0C4DE',
    '#FFFFE0',
    '#00FF00',
    '#32CD32',
    '#FAF0E6',
    '#FF00FF',
    '#800000',
    '#66CDAA',
    '#0000CD',
    '#BA55D3',
    '#9370DB',
    '#3CB371',
    '#7B68EE',
    '#00FA9A',
    '#48D1CC',
    '#C71585',
    '#191970',
    '#F5FFFA',
    '#FFE4E1',
    '#FFE4B5',
    '#FFDEAD',
    '#000080',
    '#FDF5E6',
    '#808000',
    '#6B8E23',
    '#FFA500',
    '#FF4500',
    '#DA70D6',
    '#EEE8AA',
    '#98FB98',
    '#AFEEEE',
    '#DB7093',
    '#FFEFD5',
    '#FFDAB9',
    '#CD853F',
    '#FFC0CB',
  ];

  int randomInt(int maxNumber) {
    Random random = Random();
    return random.nextInt(maxNumber + 1);
  }

  Expeditions expedition(List<Expeditions> expeditions, int expedition_id) {
    return expeditions.firstWhere(
      (data) => data.id == expedition_id,
      orElse: () => Expeditions(
          id: 0,
          numero_expedition: "",
          transporteur_id: 0,
          statu_expedition_id: 0,
          annonce_id: 0,
          deleted: 0,
          date_depart: DateTime.now(),
          type_paiement_id: 0,
          vehicule_id: 0,
          created_at: DateTime.now(),
          updated_at: DateTime.now()),
    );
  }

  String date(DateTime? date_time) {
    if (date_time == null) {
      return '';
    }
    return DateFormat("dd-MM-yyyy").format(date_time);
  }

  Expediteurs expediteur(List<Expediteurs> expediteurs, int expediteur_id) {
    return expediteurs.firstWhere(
      (data) => data.id == expediteur_id,
      orElse: () =>
          Expediteurs(id: 0, user_id: 0, numero_expediteur: "", deleted: 0),
    );
  }

  List<AnnoncePhotos> annonce_pictures(Annonces annonce,
      List<Marchandises> marchandises, List<AnnoncePhotos> photos) {
    List<AnnoncePhotos> datas = [];
    List<Marchandises> annonce_marchandise =
        annonce_marchandises(marchandises, annonce.id);

    if (annonce_marchandise.isNotEmpty) {
      for (var element in annonce_marchandise) {
        List<AnnoncePhotos> pictures = marchandise_photos(photos, element.id);
        if (pictures.isNotEmpty) {
          for (var data in pictures) {
            datas.add(data);
          }
        }
      }
    }

    return datas;
  }

  Transporteurs transporteur(
      List<Transporteurs> transporteurs, int transporteur_id) {
    return transporteurs.firstWhere(
      (data) => data.id == transporteur_id,
      orElse: () =>
          Transporteurs(id: 0, numero_transporteur: "", user_id: 0, deleted: 0),
    );
  }

  Users user(List<Users> users, int user_id) {
    return users.firstWhere(
      (data) => data.id == user_id,
      orElse: () => Users(
          id: 0,
          name: "",
          country_id: 0,
          telephone: "",
          deleted: 0,
          is_verified: 0,
          is_active: 0,
          dark_mode: 0),
    );
  }

  Marchandises marchandise(
      List<Marchandises> marchandises, int marchandise_id) {
    return marchandises.firstWhere(
      (data) => data.id == marchandise_id,
      orElse: () => Marchandises(
          id: 0,
          nom: "",
          annonce_id: 0,
          numero_marchandise: "",
          deleted: 0,
          quantite: 0,
          unite_id: 0,
          poids: 0,
          nombre_camions: 0),
    );
  }

  Localisations localisation(
      List<Localisations> localisations, int localisation_id) {
    return localisations.firstWhere(
      (data) => data.id == localisation_id,
      orElse: () => Localisations(
          id: 0,
          pays_exp_id: 0,
          pays_liv_id: 0,
          city_exp_id: 0,
          city_liv_id: 0,
          marchandise_id: 0),
    );
  }

  Localisations marchandise_localisation(
      List<Localisations> localisations, int marchandise_id) {
    return localisations.firstWhere(
      (data) => data.marchandise_id == marchandise_id,
      orElse: () => Localisations(
          id: 0,
          pays_exp_id: 0,
          pays_liv_id: 0,
          city_exp_id: 0,
          city_liv_id: 0,
          marchandise_id: 0),
    );
  }

  Tarifications tarification(List<Tarifications> tarifications, int id) {
    return tarifications.firstWhere(
      (data) => data.id == id,
      orElse: () => Tarifications(
        accompte: 0,
        id: 0,
        marchandise_id: 0,
        prix_expedition: 0,
        prix_transport: 0,
      ),
    );
  }

  List<AnnoncePhotos> marchandise_photos(
      List<AnnoncePhotos> photos, int marchandise_id) {
    return photos
        .where((data) => data.marchandise_id == marchandise_id)
        .toList();
  }

  List<AnnoncePhotos> annonce_photos(List<AnnoncePhotos> photos,
      List<Marchandises> marchandises, int annonce_id) {
    List<AnnoncePhotos> pictures = [];

    List<Marchandises> colis = annonce_marchandises(marchandises, annonce_id);

    Marchandises marchandise = colis.firstWhere(
      (data) {
        List<AnnoncePhotos> donnes = marchandise_photos(photos, data.id);
        return donnes.isNotEmpty;
      },
      orElse: () => Marchandises(
          id: 0,
          nom: "",
          annonce_id: 0,
          numero_marchandise: "",
          deleted: 0,
          quantite: 0,
          unite_id: 0,
          poids: 0,
          nombre_camions: 0),
    );

    pictures = marchandise_photos(photos, marchandise.id);

    return pictures;
  }

  Tarifications marchandise_tarification(
      List<Tarifications> tarifications, int marchandise_id) {
    return tarifications.firstWhere(
      (data) => data.marchandise_id == marchandise_id,
      orElse: () => Tarifications(
        accompte: 0,
        id: 0,
        marchandise_id: 0,
        prix_expedition: 0,
        prix_transport: 0,
      ),
    );
  }

  Marchandises firstMarchandise(List<Marchandises> datas) {
    if (datas.isNotEmpty) {
      return datas.first;
    }
    return Marchandises(
        id: 0,
        nom: "",
        annonce_id: 0,
        numero_marchandise: "",
        deleted: 0,
        quantite: 0,
        unite_id: 0,
        poids: 0,
        nombre_camions: 0);
  }

  Annonces annonce(List<Annonces> annonces, int annonce_id) {
    return annonces.firstWhere(
      (data) => data.id == annonce_id,
      orElse: () => Annonces(
          id: 0,
          numero_annonce: "",
          is_active: 0,
          user_id: 0,
          deleted: 0,
          expediteur_id: 0,
          created_at: DateTime.now(),
          updated_at: DateTime.now()),
    );
  }

  Pays pay(List<Pays> pays, int id) {
    return pays.firstWhere(
      (data) => data.id == id,
      orElse: () => Pays(id: 0, name: ""),
    );
  }

  Villes ville(List<Villes> villes, int id) {
    return villes.firstWhere(
      (data) => data.id == id,
      orElse: () => Villes(id: 0, name: "", country_id: 0),
    );
  }

  BonCommandes ordre(List<BonCommandes> ordres, int id) {
    return ordres.firstWhere(
      (data) => data.id == id,
      orElse: () => BonCommandes(
          id: id,
          numero_bon_commande: "",
          is_validated: 0,
          description: "",
          delai_chargement: 0,
          amende_delai_chargement: 0,
          amende_dechargement: 0,
          montant_paye: 0,
          annonce_id: 0,
          donneur_ordre_id: 0,
          entite_facture_id: 0,
          deleted: 0,
          created_at: DateTime.now(),
          updated_at: DateTime.now()),
    );
  }

  EntiteFactures entite_facture(List<EntiteFactures> entite_factures, int id) {
    return entite_factures.firstWhere(
      (data) => data.id == id,
      orElse: () => EntiteFactures(id: id, user_id: 0, reference: ""),
    );
  }

  DonneurOrdres donneur_ordres(List<DonneurOrdres> donneur_ordres, int id) {
    return donneur_ordres.firstWhere(
      (data) => data.id == id,
      orElse: () => DonneurOrdres(id: id, user_id: 0, reference: ""),
    );
  }

  Entreprises entite_entreprise(
      List<Entreprises> entreprises, int entite_facture_id) {
    return entreprises.firstWhere(
      (data) =>
          data.entrepriseable_id == entite_facture_id &&
          data.entrepriseable_type.contains("EntiteFacture"),
      orElse: () => Entreprises(
          id: 0,
          name: "",
          numero_entreprise: "",
          entrepriseable_type: "",
          entrepriseable_id: 0),
    );
  }

  Entreprises expediteur_entreprise(
      List<Entreprises> entreprises, int expediteur_id) {
    return entreprises.firstWhere(
      (data) =>
          data.entrepriseable_id == expediteur_id &&
          data.entrepriseable_type.contains("Expediteur"),
      orElse: () => Entreprises(
          id: 0,
          name: "",
          numero_entreprise: "",
          entrepriseable_type: "",
          entrepriseable_id: 0),
    );
  }

  Entreprises transporteur_entreprise(
      List<Entreprises> entreprises, int transporteur_id) {
    return entreprises.firstWhere(
      (data) =>
          data.entrepriseable_id == transporteur_id &&
          data.entrepriseable_type.contains("Transporteur"),
      orElse: () => Entreprises(
          id: 0,
          name: "",
          numero_entreprise: "",
          entrepriseable_type: "",
          entrepriseable_id: 0),
    );
  }

  Entreprises destinataire_entreprise(
      List<Entreprises> entreprises, int destinataire_id) {
    return entreprises.firstWhere(
      (data) =>
          data.entrepriseable_id == destinataire_id &&
          data.entrepriseable_type.contains("Destinataire"),
      orElse: () => Entreprises(
          id: 0,
          name: "",
          numero_entreprise: "",
          entrepriseable_type: "",
          entrepriseable_id: 0),
    );
  }

  Entreprises donneur_entreprise(
      List<Entreprises> entreprises, int donneur_id) {
    return entreprises.firstWhere(
      (data) =>
          data.entrepriseable_id == donneur_id &&
          data.entrepriseable_type.contains("DonneurOrdre"),
      orElse: () => Entreprises(
          id: 0,
          name: "",
          numero_entreprise: "",
          entrepriseable_type: "",
          entrepriseable_id: 0),
    );
  }

  List<Appeles> data_appeles(
      List<Appeles> apeles, int data_id, String data_modele) {
    return apeles
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Appeles> expedition_appeles(
      List<Appeles> apeles, List<Expeditions> expeditions) {
    List<int> expeditionIds = expeditions.map((exp) => exp.id).toList();

    return apeles
        .where((data) =>
            data.modele_type.contains('Expedition') &&
            expeditionIds.contains(data.modele_id))
        .toList();
  }

  List<Interchanges> expedition_interchanges(
      List<Interchanges> interchanges, List<Expeditions> expeditions) {
    List<int> expeditionIds = expeditions.map((exp) => exp.id).toList();

    return interchanges
        .where((data) =>
            data.modele_type.contains('Expedition') &&
            expeditionIds.contains(data.modele_id))
        .toList();
  }

  List<Vgms> expedition_vgm(List<Vgms> vgms, List<Expeditions> expeditions) {
    List<int> expeditionIds = expeditions.map((exp) => exp.id).toList();

    return vgms
        .where((data) =>
            data.modele_type.contains('Expedition') &&
            expeditionIds.contains(data.modele_id))
        .toList();
  }

  List<Tdos> expedition_tdo(List<Tdos> tdos, List<Expeditions> expeditions) {
    List<int> expeditionIds = expeditions.map((exp) => exp.id).toList();

    return tdos
        .where((data) =>
            data.modele_type.contains('Expedition') &&
            expeditionIds.contains(data.modele_id))
        .toList();
  }

  List<Recus> expedition_recus(
      List<Recus> recus, List<Expeditions> expeditions) {
    List<int> expeditionIds = expeditions.map((exp) => exp.id).toList();

    return recus
        .where((data) =>
            data.modele_type.contains('Expedition') &&
            expeditionIds.contains(data.modele_id))
        .toList();
  }

  List<Recus> annonce_recus(
      Annonces annonce, List<Expeditions> expeditions, List<Recus> recus) {
    List<Recus> mesRecus = [];
    final list1 = data_recus(recus, annonce.id, "Annonce");
    final list2 = expedition_recus(recus, expeditions);
    mesRecus.addAll(list1);
    mesRecus.addAll(list2);
    return mesRecus;
  }

  List<Bl> data_bl(List<Bl> bls, int data_id, String data_modele) {
    return bls
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Lta> data_lta(List<Lta> ltas, int data_id, String data_modele) {
    return ltas
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Interchanges> data_interchanges(
      List<Interchanges> interchanges, int data_id, String data_modele) {
    return interchanges
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Tdos> data_tdos(List<Tdos> tdos, int data_id, String data_modele) {
    return tdos
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<OrdreTransport> data_ordres(
      List<OrdreTransport> ordres, int data_id, String data_modele) {
    return ordres
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Paths> data_paths(List<Paths> paths, int data_id, String data_modele) {
    return paths
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Vgms> data_vgm(List<Vgms> vgms, int data_id, String data_modele) {
    return vgms
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Recus> data_recus(List<Recus> recus, int data_id, String data_modele) {
    return recus
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<AutreDocs> data_autre_docs(
      List<AutreDocs> autre_docs, int data_id, String data_modele) {
    return autre_docs
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Avd> data_avds(List<Avd> avds, int data_id, String data_modele) {
    return avds
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Bfu> data_bfus(List<Bfu> bfus, int data_id, String data_modele) {
    return bfus
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<CO> data_cos(List<CO> cos, int data_id, String data_modele) {
    return cos
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<CPS> data_cps(List<CPS> cps, int data_id, String data_modele) {
    return cps
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<FicheTechnique> data_fiches(
      List<FicheTechnique> fiche_techniques, int data_id, String data_modele) {
    return fiche_techniques
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Declaration> data_declarations(
      List<Declaration> declarations, int data_id, String data_modele) {
    return declarations
        .where((data) =>
            data.modele_id == data_id && data.modele_type.contains(data_modele))
        .toList();
  }

  List<Marchandises> annonce_marchandises(
      List<Marchandises> marchandises, int annonce_id) {
    List<Marchandises> datas =
        marchandises.where((data) => data.annonce_id == annonce_id).toList();
    if (datas.isEmpty) {
      return [
        Marchandises(
            id: 0,
            nom: "",
            annonce_id: annonce_id,
            numero_marchandise: "",
            deleted: 0,
            quantite: 0,
            unite_id: 0,
            poids: 0,
            nombre_camions: 0)
      ];
    } else {
      return datas;
    }
  }

  List<Marchandises> data_marchandises(
      List<Marchandises> marchandises, int annonce_id) {
    List<Marchandises> datas =
        marchandises.where((data) => data.annonce_id == annonce_id).toList();

    return datas;
  }

  Unites unite(List<Unites> unites, int id) {
    return unites.firstWhere(
      (data) => data.id == id,
      orElse: () => Unites(id: 0, name: ""),
    );
  }

  String formatAmount(double montant) {
    String montantString = montant.toStringAsFixed(2);

    List<String> parties = montantString.split('.');
    String partieEntiere = parties[0];
    String partieDecimale = parties.length > 1 ? parties[1] : "00";

    List<String> partieEntiereSeparee = [];
    for (int i = partieEntiere.length - 1; i >= 0; i -= 3) {
      int debut = i - 2;
      int fin = i + 1;
      if (debut < 0) {
        debut = 0;
      }
      partieEntiereSeparee.insert(0, partieEntiere.substring(debut, fin));
    }

    String montantFormate =
        partieEntiereSeparee.join(' ') + ',' + partieDecimale;

    return montantFormate;
  }

  bool hasRole(List<Rules> rules, String role) {
    return rules.any((data) => data.nom == role);
  }

  Color convertHexToColor(String hexColor) {
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    return Color(int.parse(hexColor, radix: 16));
  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  bool existing_phone_number(List<Users> users, String phone_number) {
    bool any = users.any((element) => element.telephone == phone_number);
    return any;
  }
}
