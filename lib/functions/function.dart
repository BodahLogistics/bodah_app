// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/unites.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/annonces.dart';
import '../modals/expediteurs.dart';
import '../modals/localisations.dart';
import '../modals/marchandises.dart';
import '../modals/pays.dart';
import '../modals/rules.dart';
import '../modals/transporteurs.dart';
import '../modals/users.dart';
import '../modals/villes.dart';

class Functions {
  Expediteurs expediteur(List<Expediteurs> expediteurs, int expediteur_id) {
    return expediteurs.firstWhere(
      (data) => data.id == expediteur_id,
      orElse: () =>
          Expediteurs(id: 0, user_id: 0, numero_expediteur: "", deleted: 0),
    );
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
