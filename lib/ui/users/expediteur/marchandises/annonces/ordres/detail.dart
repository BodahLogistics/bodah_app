// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:bodah/ui/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/detail.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/ordres/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/annonces.dart';
import '../../../../../../modals/bon_commandes.dart';
import '../../../../../../modals/destinataires.dart';
import '../../../../../../modals/donneur_ordres.dart';
import '../../../../../../modals/entite_factures.dart';
import '../../../../../../modals/entreprises.dart';
import '../../../../../../modals/expediteurs.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/paiement_solde.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/signature.dart';
import '../../../../../../modals/tarifications.dart';
import '../../../../../../modals/type_paiements.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../expeditions/detail.dart';

class DetailOrdre extends StatelessWidget {
  const DetailOrdre({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Users> users = api_provider.users;
    List<Annonces> annonces = api_provider.annonces;
    List<DonneurOrdres> donneur_ordres = api_provider.donneur_ordres;
    List<EntiteFactures> entite_factures = api_provider.entite_factures;
    List<BonCommandes> ordres = api_provider.ordres;
    BonCommandes ordre = function.ordre(ordres, id);
    EntiteFactures entite_facture =
        function.entite_facture(entite_factures, ordre.entite_facture_id);
    DonneurOrdres donneur_ordre =
        function.donneur_ordres(donneur_ordres, ordre.donneur_ordre_id);
    List<Entreprises> entreprises = api_provider.entreprises;
    Annonces annonce = function.annonce(annonces, ordre.annonce_id);
    Users donneur_user = function.user(users, donneur_ordre.user_id);
    Users entite_user = function.user(users, entite_facture.user_id);
    List<Marchandises> marchandises = api_provider.marchandises;
    marchandises = function.annonce_marchandises(marchandises, annonce.id);
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<PaiementSolde> paiements = api_provider.paiement_soldes;
    List<PaiementSolde> paiem = function.paiement_soldes(
        paiements, "Marchandise", marchandises.first.id);
    Localisations localisation =
        function.marchandise_localisation(localisations, marchandises.first.id);
    Pays pay_depart = function.pay(pays, localisation.pays_exp_id);
    Pays pay_dest = function.pay(pays, localisation.pays_liv_id);
    Villes ville_dep = function.ville(all_villes, localisation.city_exp_id);
    Villes ville_dest = function.ville(all_villes, localisation.city_liv_id);

    List<Destinataires> destinataires = api_provider.destinataires;
    List<Expediteurs> expediteurs = api_provider.expediteurs;
    List<Signatures> signatures = api_provider.signatures;
    List<TypePaiements> type_paiements = api_provider.type_piaments;
    List<Tarifications> tarifications = api_provider.tarifications;

    Expediteurs expediteur =
        function.expediteur(expediteurs, annonce.expediteur_id);
    Entreprises entreprise =
        function.expediteur_entreprise(entreprises, expediteur.id);
    Users expediteur_user = function.user(users, expediteur.user_id);
    Destinataires destinataire =
        function.marchandise_destinataire(destinataires, marchandises.first);
    Users destinataire_user = function.user(users, destinataire.user_id);
    Expediteurs destinataire_expediteur =
        function.user_expediteur(expediteurs, destinataire_user);
    Entreprises destinataire_entreprise =
        function.expediteur_entreprise(entreprises, destinataire_expediteur.id);
    Expediteurs donneur_expediteur =
        function.user_expediteur(expediteurs, donneur_user);
    Entreprises donneur_entreprise =
        function.expediteur_entreprise(entreprises, donneur_expediteur.id);
    Expediteurs entite_expediteur =
        function.user_expediteur(expediteurs, entite_user);
    Entreprises entite_entreprise =
        function.expediteur_entreprise(entreprises, entite_expediteur.id);
    Signatures signature = function.signature(signatures, ordre.signature_id);
    TypePaiements type_paiement =
        function.type_piament(type_paiements, ordre.type_paiement_id);
    Tarifications tarification =
        function.marchandise_tarification(tarifications, marchandises.first.id);
    double montant = tarification.prix_expedition;
    double accompte = ordre.montant_paye;
    double totalPay = function.totalPaiement(paiem);
    double solde = montant - accompte - totalPay;

    Future<void> refresh() async {
      await api_provider.InitForSomeOrdre();
    }

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
      body: ordre.id == 0
          ? RefreshIndicator(
              color: MyColors.secondary,
              onRefresh: refresh,
              child: SingleChildScrollView(
                physics:
                    AlwaysScrollableScrollPhysics(), // Permet toujours le défilement
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      .8, // Prend toute la hauteur de l'écran
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), // Ajoute un peu de padding
                      child: Text(
                        "Aucune donnée disponible",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: user.dark_mode == 1
                              ? MyColors.light
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
          : RefreshIndicator(
              color: MyColors.secondary,
              onRefresh: refresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
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
                                          ordre.is_validated == 1 ||
                                                  ordre.signature_id != null
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
                                                    "Non Validé".toUpperCase(),
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
                                      width: MediaQuery.of(context).size.width *
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
                                              height: 20,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5))),
                                                  onPressed: () {
                                                    if (ordre.is_validated ==
                                                            1 ||
                                                        ordre.signature_id !=
                                                            null) {
                                                      downloadOrdre(
                                                          context,
                                                          ordre,
                                                          donneur_ordre,
                                                          entite_facture,
                                                          donneur_user,
                                                          entite_user,
                                                          donneur_expediteur,
                                                          entite_expediteur,
                                                          entite_entreprise,
                                                          donneur_entreprise,
                                                          expediteur,
                                                          expediteur_user,
                                                          entreprise,
                                                          signature,
                                                          marchandises.first,
                                                          localisation,
                                                          pay_depart,
                                                          pay_dest,
                                                          ville_dep,
                                                          ville_dest,
                                                          type_paiement,
                                                          montant,
                                                          accompte,
                                                          solde,
                                                          destinataire,
                                                          destinataire_user,
                                                          destinataire_expediteur,
                                                          destinataire_entreprise,
                                                          function);
                                                    } else {
                                                      signerOrdre(
                                                          context, ordre);
                                                    }
                                                  },
                                                  child: ordre.is_validated ==
                                                              0 &&
                                                          ordre.signature_id ==
                                                              null
                                                      ? Text(
                                                          "Signez",
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
                                          donneur_entreprise.id != 0
                                              ? Text(
                                                  donneur_user.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors.textColor,
                                                      fontFamily: "Poppins",
                                                      fontSize: 9),
                                                )
                                              : Text(
                                                  donneur_user.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                      width: MediaQuery.of(context).size.width *
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
                                donneur_entreprise.id == 0
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black,
                                                        fontFamily: "Poppins",
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    donneur_entreprise.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            user.dark_mode == 1
                                                                ? MyColors.light
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black,
                                                        fontFamily: "Poppins",
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    donneur_entreprise.ifu ??
                                                        "----",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            user.dark_mode == 1
                                                                ? MyColors.light
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
                                      width: MediaQuery.of(context).size.width *
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
                                      width: MediaQuery.of(context).size.width *
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
                                entite_entreprise.id == 0
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black,
                                                        fontFamily: "Poppins",
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    entite_entreprise.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            user.dark_mode == 1
                                                                ? MyColors.light
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black,
                                                        fontFamily: "Poppins",
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    entite_entreprise.ifu ??
                                                        "----",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            user.dark_mode == 1
                                                                ? MyColors.light
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
  Future.delayed(Duration(milliseconds: 800), () {
    if (can_validate) {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.65,
            message: "Signez l'ordre",
            backgroundColor: MyColors.primary,
            textColor: MyColors.light,
            onPressed: () {
              // Navigator.of(dialogcontext).pop();
              signerOrdre(dialogcontext, ordre);
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
