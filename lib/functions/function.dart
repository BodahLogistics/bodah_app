// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/unites.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/annonces.dart';
import '../modals/expediteurs.dart';
import '../modals/expeditions.dart';
import '../modals/localisations.dart';
import '../modals/marchandises.dart';
import '../modals/pays.dart';
import '../modals/rules.dart';
import '../modals/transporteurs.dart';
import '../modals/users.dart';
import '../modals/villes.dart';

class Functions {
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
          marchandise_id: 0,
          montant_paye: 0,
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
        id: 0,
        marchandise_id: 0,
        prix_expedition: 0,
        prix_transport: 0,
      ),
    );
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

  List<Marchandises> annonce_marchandises(
      List<Marchandises> marchandises, int annonce_id) {
    return marchandises.where((data) => data.annonce_id == annonce_id).toList();
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
