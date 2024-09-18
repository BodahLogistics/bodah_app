// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:bodah/ui/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/detail.dart';
import 'package:bodah/wrappers/load.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/annonces.dart';
import '../../../../../../modals/bon_commandes.dart';
import '../../../../../../modals/donneur_ordres.dart';
import '../../../../../../modals/entite_factures.dart';
import '../../../../../../modals/entreprises.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../../providers/users/expediteur/marchandises/annoces/odres/add.dart';
import '../../expeditions/detail.dart';
import 'edit.dart';

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
    Users? user = api_provider.user;
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

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
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
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.w500,
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
          ? LoadingPage()
          : ordre.id == 0
              ? Center(
                  child: Text(
                  "Aucun ordre de transport n'est émis pour cette annonce",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ))
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(.2)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 4, bottom: 10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: double.infinity,
                                  child: Text(
                                    "Informations de l'ordre de transport",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Référence ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.black,
                                                fontFamily: "Poppins",
                                                fontSize: 10),
                                          ),
                                          Text(
                                            ordre.numero_bon_commande,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontSize: 9),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Franchisse",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.black,
                                                fontFamily: "Poppins",
                                                fontSize: 10),
                                          ),
                                          Text(
                                            ordre.delai_chargement.toString() +
                                                " Heures",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontSize: 9),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Statitionnement",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.black,
                                                fontFamily: "Poppins",
                                                fontSize: 10),
                                          ),
                                          Text(
                                            function.formatAmount(ordre
                                                    .amende_delai_chargement) +
                                                " XOF/Jour/Camion",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontSize: 9),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Déchargement",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.black,
                                                fontFamily: "Poppins",
                                                fontSize: 10),
                                          ),
                                          Text(
                                            function.formatAmount(
                                                    ordre.amende_dechargement) +
                                                " XOF/Jour/Camion",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontSize: 9),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Statut ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ordre.is_validated == 1
                                                ? Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Validé".toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 10,
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
                                                      "Non Validé"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Action",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 5),
                                              child: SizedBox(
                                                height: 25,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                    onPressed: () {
                                                      if (ordre.is_validated ==
                                                          0) {
                                                        showAllFromOrdre(
                                                            context,
                                                            annonce,
                                                            ordre,
                                                            donneur_user.id ==
                                                                    user.id &&
                                                                ordre.deleted ==
                                                                    0,
                                                            ordre.is_validated ==
                                                                0,
                                                            entite_facture,
                                                            donneur_ordre,
                                                            entite_facture_entreprise,
                                                            donneur_ordre_entreprise,
                                                            entite_user,
                                                            donneur_user);
                                                      }
                                                    },
                                                    child: ordre.is_validated ==
                                                            0
                                                        ? Text(
                                                            "Exécutez",
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .light,
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          )
                                                        : Text(
                                                            "Téléchargez",
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .light,
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: double.infinity,
                                    child: Text(
                                      "Donneur d'ordre",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nom ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              donneur_user.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Contact",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              donneur_user.telephone,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Email ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              donneur_user.email ?? "----",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Adresse",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              donneur_user.adresse ?? "-----",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  donneur_ordre_entreprise.id == 0
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Entreprise ",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontFamily: "Poppins",
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      donneur_ordre_entreprise
                                                          .name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .textColor,
                                                          fontFamily: "Poppins",
                                                          fontSize: 9),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "IFU/N° Fisacle",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontFamily: "Poppins",
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      donneur_ordre_entreprise
                                                              .ifu ??
                                                          "----",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .textColor,
                                                          fontFamily: "Poppins",
                                                          fontSize: 9),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: double.infinity,
                                    child: Text(
                                      "Entité à facturer",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nom ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              entite_user.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Contact",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              entite_user.telephone,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Email ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              entite_user.email ?? "----",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Adresse",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              entite_user.adresse ?? "-----",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  entite_facture_entreprise.id == 0
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Entreprise ",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontFamily: "Poppins",
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      entite_facture_entreprise
                                                          .name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .textColor,
                                                          fontFamily: "Poppins",
                                                          fontSize: 9),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "IFU/N° Fisacle",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontFamily: "Poppins",
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      entite_facture_entreprise
                                                              .ifu ??
                                                          "----",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .textColor,
                                                          fontFamily: "Poppins",
                                                          fontSize: 9),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
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

            DeleteOrdre(dialogcontext, annonce, ordre);
          },
        );
      },
    );
  }

  if (ordre.is_validated == 0) {
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
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return UpOrdreTransport(id: ordre.id);
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0)
                          .animate(animation),
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
