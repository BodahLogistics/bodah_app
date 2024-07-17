// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/camions.dart';
import 'package:bodah/modals/destinataires.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/providers/users/expediteur/marchandises/annoces/odres/add.dart';
import 'package:bodah/ui/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/detail.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/edit.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/annonces.dart';
import '../../../../../../modals/bon_commandes.dart';
import '../../../../../../modals/devises.dart';
import '../../../../../../modals/donneur_ordres.dart';
import '../../../../../../modals/entite_factures.dart';
import '../../../../../../modals/entreprises.dart';
import '../../../../../../modals/expediteurs.dart';
import '../../../../../../modals/expeditions.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/statuts.dart';
import '../../../../../../modals/type_chargements.dart';
import '../../../../../../modals/unites.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../../services/data_base_service.dart';
import '../../expeditions/detail.dart';

class DetailOrdre extends StatefulWidget {
  const DetailOrdre({super.key, required this.id});
  final int id;

  @override
  State<DetailOrdre> createState() => _DetailOrdreState();
}

class _DetailOrdreState extends State<DetailOrdre> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitForSomeOrdre();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    bool loading = api_provider.loading;
    final user = api_provider.user;
    List<Users> users = api_provider.users;
    List<Annonces> annonces = api_provider.annonces;
    List<DonneurOrdres> donneur_ordres = api_provider.donneur_ordres;
    List<EntiteFactures> entite_factures = api_provider.entite_factures;
    List<BonCommandes> ordres = api_provider.ordres;
    BonCommandes ordre = function.ordre(ordres, widget.id);
    EntiteFactures entite_facture =
        function.entite_facture(entite_factures, ordre.entite_facture_id);
    DonneurOrdres donneur_ordre =
        function.donneur_ordres(donneur_ordres, ordre.donneur_ordre_id);
    List<Entreprises> entreprises = api_provider.entreprises;
    Entreprises entite_facture_entreprise =
        function.entite_entreprise(entreprises, entite_facture.id);
    Entreprises donneur_ordre_entreprise =
        function.donneur_entreprise(entreprises, donneur_ordre.id);
    Annonces annonce = function.annonce(annonces, ordre.annonce_id);
    Users donneur_user = function.user(users, donneur_ordre.user_id);
    Users entite_user = function.user(users, entite_facture.user_id);
    List<Marchandises> marchandises = api_provider.marchandises;
    marchandises = function.annonce_marchandises(marchandises, annonce.id);
    List<Tarifications> tarifications = api_provider.tarifications;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<Expeditions> expeditions = api_provider.expeditions;
    List<Destinataires> destinataires = api_provider.destinataires;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    List<Camions> camions = api_provider.camions;
    List<Expediteurs> expediteurs = api_provider.expediteurs;
    Expediteurs expediteur =
        function.expediteur(expediteurs, annonce.expediteur_id);
    Users expediteur_user = function.user(users, expediteur.user_id);
    Entreprises expediteur_entreprise =
        function.expediteur_entreprise(entreprises, expediteur.id);
    List<Devises> devises = api_provider.devises;
    List<TypeChargements> type_chargements = api_provider.type_chargements;
    List<Unites> unites = api_provider.unites;
    List<Statuts> statuts = api_provider.statuts;
    return Scaffold(
      backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
      drawer: DrawerExpediteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Ordre de transport",
          style: TextStyle(
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              ))
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
              color: MyColors.secondary,
            ))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: MyColors.secondary,
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: MyColors.light,
                            )),
                        Text(
                          ordre.numero_bon_commande,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: MyColors.light,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                            onPressed: () {
                              showAllFromOrdre(
                                  context,
                                  annonce,
                                  ordre,
                                  donneur_user.id == user.id &&
                                      ordre.deleted == 0,
                                  ordre.is_validated == 0,
                                  entite_facture,
                                  donneur_ordre,
                                  entite_facture_entreprise,
                                  donneur_ordre_entreprise,
                                  entite_user,
                                  donneur_user);
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: MyColors.light,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40, left: 15, right: 15, bottom: 80),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Référence de l'annonce",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            annonce.numero_annonce,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w300,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Date de publication de l'annonce",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            function.date(annonce.created_at),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w300,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Statut de l'annonce",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        annonce.is_active == 1
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Annonce publiée",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.green),
                                ),
                              )
                            : Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Annonce non publiée",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.red),
                                ),
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Numéro du BL",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                annonce.numero_bl ?? " Non défini",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.textColor,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: MyColors.secondary,
                                      ),
                                      height: 40,
                                      width: double.infinity,
                                      child: Text(
                                        "Expéditeur / Commissionnaire en douane / Transitaire",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: MyColors.light,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Identifiant",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur.numero_expediteur,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Nom",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur_user.name,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Contact",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur_user.telephone,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Adresse électronique",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur_user.email ??
                                                  "Non définie",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Adresse de résidence",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur_user.adresse ??
                                                  "Non définie",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          expediteur_entreprise.id > 0
                                              ? Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Nom de l'entreprise",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        expediteur_entreprise
                                                            .name,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "IFU/Numéro Fiscal",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        expediteur_entreprise
                                                                .ifu ??
                                                            "Non définie",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.textColor,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: MyColors.secondary,
                                      ),
                                      height: 40,
                                      width: double.infinity,
                                      child: Text(
                                        "Informations de l'ordre de transport",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: MyColors.light,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Identifiant",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              ordre.numero_bon_commande,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Délai de chargement",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              ordre.delai_chargement
                                                      .toString() +
                                                  " Heures",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Frais de stationnement sur retard de chargement",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              function.formatAmount(ordre
                                                      .amende_delai_chargement) +
                                                  " XOF /Camion/Jour",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Frais de stationnement sur retard de déchargement",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              function.formatAmount(ordre
                                                      .amende_dechargement) +
                                                  " XOF/Camion/Jour",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Statut de l'ordre de transport",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          ordre.is_validated == 1
                                              ? Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Ordre de transport validé",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.green),
                                                  ),
                                                )
                                              : Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Ordre de transport non validé",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                          ordre.is_validated == 1
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Date de validation",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        function.date(
                                                            ordre.updated_at),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors.textColor,
                                                      style:
                                                          BorderStyle.solid)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: MyColors.secondary,
                                                    ),
                                                    height: 40,
                                                    width: double.infinity,
                                                    child: Text(
                                                      "Donneur d'ordre",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: MyColors.light,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Référence",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            donneur_ordre
                                                                .reference,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Nom",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            donneur_user.name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Contact",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            donneur_user
                                                                .telephone,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Adresse électronique",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            donneur_user
                                                                    .email ??
                                                                "Non définie",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Adresse de résidence",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            donneur_user
                                                                    .adresse ??
                                                                "Non définie",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        donneur_ordre_entreprise
                                                                    .id >
                                                                0
                                                            ? Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "Nom de l'entreprise",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      donneur_ordre_entreprise
                                                                          .name,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .w300,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "IFU/Numéro Fiscal",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      donneur_ordre_entreprise
                                                                              .ifu ??
                                                                          "Non définie",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .w300,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                ],
                                                              )
                                                            : Container()
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors.textColor,
                                                      style:
                                                          BorderStyle.solid)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: MyColors.secondary,
                                                    ),
                                                    height: 40,
                                                    width: double.infinity,
                                                    child: Text(
                                                      "Entité à facturer",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: MyColors.light,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Référence",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            entite_facture
                                                                .reference,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Nom",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            entite_user.name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Contact",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            entite_user
                                                                .telephone,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Adresse électronique",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            entite_user.email ??
                                                                "Non définie",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Adresse de résidence",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            entite_user
                                                                    .adresse ??
                                                                "Non définie",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        entite_facture_entreprise
                                                                    .id >
                                                                0
                                                            ? Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "Nom de l'entreprise",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      entite_facture_entreprise
                                                                          .name,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .w300,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "IFU/Numéro Fiscal",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      entite_facture_entreprise
                                                                              .ifu ??
                                                                          "Non définie",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .w300,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                ],
                                                              )
                                                            : Container()
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                marchandises.length > 1
                                    ? Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: MyColors.secondary,
                                        ),
                                        height: 40,
                                        width: double.infinity,
                                        child: Text(
                                          "Marchandises transportées",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.light,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: MyColors.secondary,
                                        ),
                                        height: 40,
                                        width: double.infinity,
                                        child: Text(
                                          "Marchandise transportée",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.light,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                Column(
                                  children: (marchandises).map((marchandise) {
                                    TypeChargements type_cahrgement =
                                        function.type_chargement(
                                            type_chargements,
                                            marchandise.type_chargement_id);
                                    Devises devise = function.devise(
                                        devises, marchandise.devise_id);
                                    Expeditions expedition =
                                        function.marchandise_expedition(
                                            expeditions, marchandise);
                                    Statuts statut = function.statut(statuts,
                                        expedition.statu_expedition_id);
                                    Localisations localisation =
                                        function.marchandise_localisation(
                                            localisations, marchandise.id);
                                    Pays pay_depart = function.pay(
                                        pays, localisation.pays_exp_id);
                                    Pays pay_dest = function.pay(
                                        pays, localisation.pays_liv_id);
                                    Villes ville_dep = function.ville(
                                        all_villes, localisation.city_exp_id);
                                    Villes ville_dest = function.ville(
                                        all_villes, localisation.city_liv_id);
                                    Tarifications tarification =
                                        function.marchandise_tarification(
                                            tarifications, marchandise.id);
                                    Destinataires destinataire =
                                        function.marchandise_destinataire(
                                            destinataires, marchandise);
                                    Entreprises destinataire_entreprise =
                                        function.destinataire_entreprise(
                                            entreprises, destinataire.id);

                                    Users destinataire_user = function.user(
                                        users, destinataire.user_id);
                                    Transporteurs transporteur =
                                        function.expedition_transporteur(
                                            transporteurs, expedition);
                                    Users transporteur_user = function.user(
                                        users, transporteur.user_id);
                                    Entreprises transporteur_entreprise =
                                        function.transporteur_entreprise(
                                            entreprises, transporteur.id);
                                    Camions camion = function.expedition_camion(
                                        camions, expedition);
                                    Unites unite = function.unite(
                                        unites, marchandise.unite_id);

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      style: BorderStyle.solid,
                                                      width: 1,
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors
                                                              .textColor)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            MyColors.textColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    height: 40,
                                                    width: double.infinity,
                                                    child: Text(
                                                      marchandise.nom,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: MyColors.light,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Identifiant",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            marchandise
                                                                .numero_marchandise,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Quantité",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            function.formatAmount(
                                                                marchandise
                                                                    .quantite
                                                                    .toDouble()),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Poids",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            marchandise.poids
                                                                    .toString() +
                                                                " " +
                                                                unite.name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        type_cahrgement.id > 0
                                                            ? Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "Type de chargement",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      type_cahrgement
                                                                          .name,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .w300,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                ],
                                                              )
                                                            : Container(),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Nombre de camions exigé",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            marchandise
                                                                .nombre_camions
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Tarif d'expédition",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            function.formatAmount(
                                                                    tarification
                                                                        .prix_expedition) +
                                                                " " +
                                                                devise.nom,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Date de chargement prévue",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            function.date(
                                                                marchandise
                                                                    .date_chargement),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Lieu de chargement",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            pay_depart.name +
                                                                " - " +
                                                                ville_dep.name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Lieu de déchargement",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            pay_dest.name +
                                                                " - " +
                                                                ville_dest.name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        destinataire.id > 0
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            20),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.textColor,
                                                                          style: BorderStyle.solid)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          color:
                                                                              MyColors.secondary,
                                                                        ),
                                                                        height:
                                                                            40,
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          "Destinataire de la marchandise",
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              color: MyColors.light,
                                                                              fontFamily: "Poppins",
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Référence",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire.numero_destinataire,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Nom",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire_user.name,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Contact",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire_user.telephone,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Adresse électronique",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire_user.email ?? "Non définie",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Adresse de résidence",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire_user.adresse ?? "Non définie",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            destinataire_entreprise.id > 0
                                                                                ? Column(
                                                                                    children: [
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          "Nom de l'entreprise",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 4,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          destinataire_entreprise.name,
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          "IFU/Numéro Fiscal",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 4,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          destinataire_entreprise.ifu ?? "Non définie",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : Container()
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                        expedition.id > 0
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            20),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      border: Border.all(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          width:
                                                                              1,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.textColor)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          color:
                                                                              MyColors.secondary,
                                                                        ),
                                                                        height:
                                                                            40,
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          "Expédition de la marchandise",
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              color: MyColors.light,
                                                                              fontFamily: "Poppins",
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Référence",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                expedition.numero_expedition,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Lieu de chargement",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                pay_depart.name + " - " + ville_dep.name,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Date de chargement",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                function.date(expedition.date_depart),
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Lieu de  déchargement",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                pay_dest.name + " - " + ville_dest.name,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            function.date(expedition.date_arrivee).isNotEmpty
                                                                                ? Column(
                                                                                    children: [
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          "Date de déchargement",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 4,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          function.date(expedition.date_arrivee),
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          "Statut de l'expédition",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 4,
                                                                                      ),
                                                                                      statut.name == "TERMINE"
                                                                                          ? Container(
                                                                                              alignment: Alignment.centerLeft,
                                                                                              child: Text(
                                                                                                "Expédition terminée".toUpperCase(),
                                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: Colors.green),
                                                                                              ),
                                                                                            )
                                                                                          : statut.name == "EN COURS"
                                                                                              ? Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Expédition en cours".toUpperCase(),
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: MyColors.primary),
                                                                                                  ),
                                                                                                )
                                                                                              : Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Expédition non démarrée".toUpperCase(),
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: MyColors.secondary),
                                                                                                  ),
                                                                                                ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : Container(),
                                                                            transporteur.id > 0
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.only(bottom: 15),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(width: 1, style: BorderStyle.solid, color: user.dark_mode == 1 ? MyColors.light : MyColors.secondary)),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Container(
                                                                                            alignment: Alignment.center,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(15),
                                                                                              color: MyColors.secondary,
                                                                                            ),
                                                                                            height: 40,
                                                                                            width: double.infinity,
                                                                                            child: Text(
                                                                                              "Transporteur de la marchandise",
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              style: TextStyle(color: MyColors.light, fontFamily: "Poppins", fontWeight: FontWeight.w500),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                            child: Column(
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Référence",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur.numero_transporteur,
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Nom",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur_user.name,
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Contact",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur_user.telephone,
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Adresse électronique",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur_user.email ?? "Non définie",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Adresse de résidence",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur_user.adresse ?? "Non définie",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                transporteur_entreprise.id > 0
                                                                                                    ? Column(
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              "Nom de l'entreprise",
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 4,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              transporteur_entreprise.name,
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 15,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              "IFU/Numéro Fiscal",
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 4,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              transporteur_entreprise.ifu ?? "Non définie",
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 15,
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    : Container(),
                                                                                                camion.id > 0
                                                                                                    ? Column(
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              "Immatriculation du camion",
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 4,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              function.immatriculation(camion.num_immatriculation),
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 15,
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    : Container(),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Container()
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

Future<dynamic> DeleteOrdre(BuildContext context, BonCommandes ordre) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);

      return AlertDialog(
        title: Text(
          "Suppression de l'ordre de transport",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer l'ordre de transport " +
              ordre.numero_bon_commande,
          style: TextStyle(
              color: function.convertHexToColor("#79747E"),
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.of(dialocontext).pop();
                  },
                  child: Text(
                    "Annulez",
                    style: TextStyle(
                        color: function.convertHexToColor("#DE2402"),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 1),
                  )),
              TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () async {
                    final String statut = await service.deleteOrdre(ordre);
                    if (statut == "202") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Une erreur s'est produite",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "100") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Données invalid',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "401") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Ordre de transport déjà supprimé',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "404") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "L'annonce de cet ordre de transport a été supprimé",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "403") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Impossible de supprimer cet ordre de transport. Il a été déjà validé ou n'existe pas",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "422") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Erreur de validation',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "200") {
                      Navigator.of(dialocontext).pop();
                      Navigator.of(dialocontext).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) => Align(
                            alignment: Alignment.topLeft,
                            child: MesOrdreTransport(),
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                      final snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "L'ordre de transport a été supprimé avec succès",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    "Supprimez",
                    style: TextStyle(
                        color: MyColors.secondary,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 1),
                  )),
            ],
          ),
        ],
      );
    },
  );
}

void showAllFromOrdre(
    BuildContext context,
    Annonces annonce,
    BonCommandes ordre,
    bool can_delete,
    bool can_validate,
    EntiteFactures entite_facture,
    DonneurOrdres donneur_ordre,
    Entreprises entite_entreprise,
    Entreprises donneur_entreprise,
    Users entite_user,
    Users donneur_user) {
  if (can_delete) {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.85,
          message: "Supprimez l'ordre",
          backgroundColor: Colors.red,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();

            DeleteOrdre(dialogcontext, ordre);
          },
        );
      },
    );
  }

  // Afficher l'alerte "Perte"
  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvAddOrdre>(dialogcontext);
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.75,
          message: "Modifiez l'ordre de transport",
          backgroundColor: MyColors.secondary,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();
            provider.change_ordre(
                ordre,
                entite_facture,
                donneur_ordre,
                entite_user,
                donneur_user,
                donneur_entreprise,
                entite_entreprise);
            Navigator.of(dialogcontext).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return UpOrdreTransport(id: ordre.id);
                },
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return ScaleTransition(
                    scale:
                        Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                    child: child,
                  );
                },
              ),
            );
          },
        );
      },
    );
  });

  Future.delayed(Duration(milliseconds: 800), () {
    if (can_validate) {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.65,
            message: "Validez l'ordre",
            backgroundColor: MyColors.primary,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();
              ValidateOrdre(dialogcontext, ordre);
            },
          );
        },
      );
    }
  });

  Future.delayed(Duration(milliseconds: 800), () {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.55,
          message: "Visualisez l'annonce",
          backgroundColor: Colors.brown,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();
            Navigator.of(dialogcontext).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return DetailAnnonce(id: annonce.id);
                },
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return ScaleTransition(
                    scale:
                        Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                    child: child,
                  );
                },
              ),
            );
          },
        );
      },
    );
  });
}

Future<dynamic> ValidateOrdre(BuildContext context, BonCommandes ordre) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      final api_provider = Provider.of<ApiProvider>(dialocontext);

      return AlertDialog(
        title: Text(
          "Validation de l'ordre de transport",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Voulez-vous vraiment valider l'ordre de transport " +
              ordre.numero_bon_commande,
          style: TextStyle(
              color: function.convertHexToColor("#79747E"),
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.of(dialocontext).pop();
                  },
                  child: Text(
                    "Annulez",
                    style: TextStyle(
                        color: function.convertHexToColor("#DE2402"),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 1),
                  )),
              TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () async {
                    final String statut = await service.validateOrdre(ordre);

                    if (statut == "202") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Une erreur s'est produite",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "100") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Données invalid',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "401") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Ordre de transport supprimé',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "404") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "L'annonce de cet ordre de transport a été supprimé",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "403") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Impossible de supprimer cet ordre de transport. Il a été déjà validé ou n'existe pas",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "422") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Erreur de validation',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "200") {
                      await api_provider.InitForSomeOrdre();
                      Navigator.of(dialocontext).pop();
                      final snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "L'ordre de transport a été validé avec succès",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    "Validez",
                    style: TextStyle(
                        color: MyColors.secondary,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 1),
                  )),
            ],
          ),
        ],
      );
    },
  );
}
