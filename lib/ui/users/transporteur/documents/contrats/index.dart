// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_adjacent_string_concatenation, deprecated_member_use

import 'dart:io';

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/charges.dart';
import 'package:bodah/modals/letrre_voyage.dart';
import 'package:bodah/modals/paiement_solde.dart';
import 'package:bodah/modals/tarifs.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:bodah/ui/users/transporteur/drawer/index.dart';
import 'package:bodah/ui/users/transporteur/expeditions/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/expeditions.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../modals/camions.dart';
import '../../../../../modals/pieces.dart';
import '../../../../../modals/statut_expeditions.dart';
import '../../../../../modals/transporteurs.dart';
import '../../../../../providers/api/download.dart';
import '../../../../../services/data_base_service.dart';

class ChargContrats extends StatelessWidget {
  const ChargContrats({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<Expeditions> expeditions = api_provider.expeditions;
    Users? user = api_provider.user;
    List<LetreVoitures> datas = api_provider.contrats;
    List<Annonces> annonces = api_provider.annonces;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<StatutExpeditions> statuts = api_provider.statut_expeditions;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    Transporteurs user_transporteur =
        function.user_transporteur(user, transporteurs);
    List<Camions> camions = api_provider.camions;
    List<Users> users = api_provider.users;
    List<Charge> charges = api_provider.charges;
    List<Tarif> tarifs = api_provider.tarifs;
    List<Pieces> pieces = api_provider.pieces;
    List<PaiementSolde> paiements = api_provider.paiement_soldes;
    Future<void> refresh() async {
      await api_provider.InitTransporteurContrat();
      await api_provider.InitTransporteurExpeditionForAnnonce();
    }

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      drawer: DrawerTransporteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Letre de voiture",
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
      body: datas.isEmpty
          ? RefreshIndicator(
              color: MyColors.secondary,
              onRefresh: refresh,
              child: Center(
                  child: Text("Vous n'avez aucune letre de voiture disponible",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color:
                            user.dark_mode == 1 ? MyColors.light : Colors.black,
                        fontWeight: FontWeight.w500,
                      ))),
            )
          : RefreshIndicator(
              color: MyColors.secondary,
              onRefresh: refresh,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      LetreVoitures data = datas[index];

                      Expeditions expedition =
                          function.expedition(expeditions, data.expedition_id);

                      Marchandises marchandise =
                          function.expedition_marchandise(
                              expedition, marchandises, annonces);
                      Localisations localisation =
                          function.marchandise_localisation(
                              localisations, marchandise.id);
                      Pays pay_depart =
                          function.pay(pays, localisation.pays_exp_id);
                      Pays pay_dest =
                          function.pay(pays, localisation.pays_liv_id);
                      Villes ville_dep =
                          function.ville(all_villes, localisation.city_exp_id);
                      Villes ville_dest =
                          function.ville(all_villes, localisation.city_liv_id);
                      StatutExpeditions statut = function.statut(
                          statuts, expedition.statu_expedition_id);
                      Camions camion =
                          function.camion(camions, expedition.vehicule_id);
                      Transporteurs transporteur = function.transporteur(
                          transporteurs, expedition.transporteur_id);
                      Users chauffeur_user =
                          function.user(users, transporteur.user_id);
                      Pieces piece = function.data_piece(
                          pieces, transporteur.id, "Transporteur");
                      List<PaiementSolde> paies = function.data_paiement(
                          paiements, "Expedition", expedition.id);
                      String quantite = "";
                      String poids = "";
                      double montant = 0;
                      double accompte = 0;
                      double solde = 0;
                      List<Charge> data_charges =
                          function.expedition_charges(charges, expedition);
                      if (data_charges.isNotEmpty) {
                        for (var i = 0; i < data_charges.length; i++) {
                          quantite += data_charges[i].quantite;
                          poids += data_charges[i].poids;
                          Tarif tarif =
                              function.charge_tarif(tarifs, data_charges[i]);
                          montant += tarif.montant;
                          accompte += tarif.accompte;
                        }
                      }

                      solde = montant -
                          accompte -
                          paies.fold(
                              0,
                              (previousValue, data) =>
                                  previousValue + data.montant);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return DetailChargement(
                                    id: expedition.id,
                                  );
                                },
                                transitionsBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                    Widget child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(1.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: index % 2 != 0
                                    ? Colors.grey.withOpacity(.2)
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.textColor,
                                    width: 0.1,
                                    style: BorderStyle.solid)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Référence : ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          data.reference,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Départ : ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      pay_depart.id == 0
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://test.bodah.bj/countries/${pay_depart.flag}",
                                                fit: BoxFit.cover,
                                                height: 15,
                                                width: 20,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress,
                                                  color: MyColors.secondary,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(),
                                              ),
                                            ),
                                      localisation.address_exp?.isEmpty ?? true
                                          ? Expanded(
                                              child: Text(
                                                ville_dep.name +
                                                    " , " +
                                                    pay_depart.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: user.dark_mode == 1
                                                        ? MyColors.light
                                                        : MyColors.textColor,
                                                    fontFamily: "Poppins",
                                                    fontSize: 10),
                                              ),
                                            )
                                          : Expanded(
                                              child: Text(
                                                (localisation.address_exp ??
                                                        "") +
                                                    " , " +
                                                    ville_dep.name +
                                                    " , " +
                                                    pay_depart.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: user.dark_mode == 1
                                                        ? MyColors.light
                                                        : MyColors.textColor,
                                                    fontFamily: "Poppins",
                                                    fontSize: 10),
                                              ),
                                            )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Destination : ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      pay_dest.id == 0
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://test.bodah.bj/countries/${pay_dest.flag}",
                                                fit: BoxFit.cover,
                                                height: 15,
                                                width: 20,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress,
                                                  color: MyColors.secondary,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(),
                                              ),
                                            ),
                                      localisation.address_liv?.isEmpty ?? true
                                          ? Expanded(
                                              child: Text(
                                                ville_dest.name +
                                                    " , " +
                                                    pay_dest.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: user.dark_mode == 1
                                                        ? MyColors.light
                                                        : MyColors.textColor,
                                                    fontFamily: "Poppins",
                                                    fontSize: 10),
                                              ),
                                            )
                                          : Expanded(
                                              child: Text(
                                                localisation.address_liv ??
                                                    "" +
                                                        " , " +
                                                        ville_dest.name +
                                                        " , " +
                                                        pay_dest.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: user.dark_mode == 1
                                                        ? MyColors.light
                                                        : MyColors.textColor,
                                                    fontFamily: "Poppins",
                                                    fontSize: 10),
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Immatriculation : ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          camion.num_immatriculation,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  user_transporteur.id != transporteur.id
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Chauffeur : ",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors.black,
                                                      fontFamily: "Poppins",
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    chauffeur_user.name,
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
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Contact : ",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors.black,
                                                      fontFamily: "Poppins",
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    chauffeur_user.telephone,
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
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        )
                                      : Container(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Début de chargement : ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          function.date(expedition.date_depart),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Fin de chargement : ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          function
                                              .date(expedition.date_arrivee),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Statut :",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      statut.id == 2
                                          ? Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Terminée".toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.green),
                                              ),
                                            )
                                          : statut.id == 1
                                              ? Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "EN COURS".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.blue),
                                                  ),
                                                )
                                              : Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Non démarée".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.yellow),
                                                  ),
                                                ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  data.signature_id != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: SizedBox(
                                            height: 25,
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
                                                  downloadContrat(
                                                      context,
                                                      expedition,
                                                      data,
                                                      transporteur,
                                                      chauffeur_user,
                                                      camion,
                                                      marchandise,
                                                      localisation,
                                                      pay_depart,
                                                      pay_dest,
                                                      ville_dep,
                                                      ville_dest,
                                                      piece,
                                                      quantite,
                                                      poids,
                                                      montant,
                                                      accompte,
                                                      solde);
                                                },
                                                child: Text(
                                                  "Téléchargez",
                                                  style: TextStyle(
                                                      color: MyColors.light,
                                                      fontSize: 10,
                                                      fontFamily: "Poppins"),
                                                )),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: SizedBox(
                                            height: 25,
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
                                                  signerContrat(
                                                      context, expedition);
                                                },
                                                child: Text(
                                                  "Signez",
                                                  style: TextStyle(
                                                      color: MyColors.light,
                                                      fontSize: 10,
                                                      fontFamily: "Poppins"),
                                                )),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: datas.length,
                  ),
                ),
              ),
            ),
    );
  }
}

void signerDestinataire(BuildContext context, Expeditions data) {
  Future.delayed(Duration(milliseconds: 500), () {
    SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvDown>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        bool affiche = provider.affiche;
        final service = Provider.of<DBServices>(dialogcontext);

        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Votre signature",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColors.secondary),
                child: IconButton(
                  icon: Icon(Icons.close, size: 15, color: MyColors.light),
                  onPressed: () {
                    controller.clear();
                    provider.change_affiche(false);
                    Navigator.of(dialogcontext).pop(); // Ferme le dialogue
                  },
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 200, // La hauteur exacte que vous souhaitez
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Prendre uniquement l'espace nécessaire
              children: [
                Signature(
                  controller: controller,
                  height: 200, // Hauteur définie pour le widget de signature
                  backgroundColor: Colors.grey[200]!,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 80,
                  height: 30,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          padding: EdgeInsets.only(left: 7, right: 7),
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        controller.clear();
                        provider.change_affiche(false);
                      },
                      child: Text(
                        "Reprenez",
                        style: TextStyle(
                            color: MyColors.light,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                            letterSpacing: 1),
                      )),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.green),
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);
                            Directory tempDir = await getTemporaryDirectory();
                            String filePath = '${tempDir.path}/signature.png';
                            var signatureImage = await controller.toPngBytes();

                            if (signatureImage != null) {
                              File file = File(filePath);
                              await file.writeAsBytes(signatureImage);

                              String satatutCode =
                                  await service.signatureDestinataire(
                                      data, file, api_provider);

                              if (satatutCode == "202") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Une erreur inattendue s'est produite",
                                    const Color.fromARGB(255, 233, 186, 186));
                              } else if (satatutCode == "404") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Impossible de signer cette lettre de voiture",
                                    Colors.redAccent);
                              } else if (satatutCode == "422") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Vous n'avez pas signer avant dee valider",
                                    Colors.redAccent);
                              } else if (satatutCode == "500") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Vérifiez votre connection internet et réessayer plus tard",
                                    Colors.redAccent);
                              } else if (satatutCode == "200") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Votre signature a été enregistrée avec succès",
                                    Colors.green);
                                controller.clear();
                                Navigator.of(dialogcontext).pop();
                              }
                            } else {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Vous devez signer avant de valider",
                                  Colors.redAccent);
                            }
                          },
                    child: affiche
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SizedBox(
                              height: 20,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: MyColors.light,
                              ),
                            ),
                          )
                        : Text(
                            "Validez",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  });
}

void signerTransporteur(BuildContext context, Expeditions data) {
  Future.delayed(Duration(milliseconds: 500), () {
    SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvDown>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        bool affiche = provider.affiche;
        final service = Provider.of<DBServices>(dialogcontext);

        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Votre signature",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColors.secondary),
                child: IconButton(
                  icon: Icon(Icons.close, size: 15, color: MyColors.light),
                  onPressed: () {
                    controller.clear();
                    provider.change_affiche(false);
                    Navigator.of(dialogcontext).pop(); // Ferme le dialogue
                  },
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 200, // La hauteur exacte que vous souhaitez
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Prendre uniquement l'espace nécessaire
              children: [
                Signature(
                  controller: controller,
                  height: 200, // Hauteur définie pour le widget de signature
                  backgroundColor: Colors.grey[200]!,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 80,
                  height: 30,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          padding: EdgeInsets.only(left: 7, right: 7),
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        controller.clear();
                        provider.change_affiche(false);
                      },
                      child: Text(
                        "Reprenez",
                        style: TextStyle(
                            color: MyColors.light,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                            letterSpacing: 1),
                      )),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.green),
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);
                            Directory tempDir = await getTemporaryDirectory();
                            String filePath = '${tempDir.path}/signature.png';
                            var signatureImage = await controller.toPngBytes();

                            if (signatureImage != null) {
                              File file = File(filePath);
                              await file.writeAsBytes(signatureImage);

                              String satatutCode =
                                  await service.signatureTransporteur(
                                      data, file, api_provider);

                              if (satatutCode == "202") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Une erreur inattendue s'est produite",
                                    const Color.fromARGB(255, 233, 186, 186));
                              } else if (satatutCode == "404") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Impossible de signer cette lettre de voiture",
                                    Colors.redAccent);
                              } else if (satatutCode == "422") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Vous n'avez pas signer avant dee valider",
                                    Colors.redAccent);
                              } else if (satatutCode == "500") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Vérifiez votre connection internet et réessayer plus tard",
                                    Colors.redAccent);
                              } else if (satatutCode == "200") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Votre signature a été enregistrée avec succès",
                                    Colors.green);
                                controller.clear();
                                Navigator.of(dialogcontext).pop();
                              }
                            } else {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Vous devez signer avant de valider",
                                  Colors.redAccent);
                            }
                          },
                    child: affiche
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SizedBox(
                              height: 20,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: MyColors.light,
                              ),
                            ),
                          )
                        : Text(
                            "Validez",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  });
}

void signerContrat(BuildContext context, Expeditions data) {
  Future.delayed(Duration(milliseconds: 500), () {
    SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvDown>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        bool affiche = provider.affiche;
        final service = Provider.of<DBServices>(dialogcontext);

        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Votre signature",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColors.secondary),
                child: IconButton(
                  icon: Icon(Icons.close, size: 15, color: MyColors.light),
                  onPressed: () {
                    controller.clear();
                    provider.change_affiche(false);
                    Navigator.of(dialogcontext).pop(); // Ferme le dialogue
                  },
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 200, // La hauteur exacte que vous souhaitez
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Prendre uniquement l'espace nécessaire
              children: [
                Signature(
                  controller: controller,
                  height: 200, // Hauteur définie pour le widget de signature
                  backgroundColor: Colors.grey[200]!,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 80,
                  height: 30,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          padding: EdgeInsets.only(left: 7, right: 7),
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        controller.clear();
                        provider.change_affiche(false);
                      },
                      child: Text(
                        "Reprenez",
                        style: TextStyle(
                            color: MyColors.light,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                            letterSpacing: 1),
                      )),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.green),
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);
                            Directory tempDir = await getTemporaryDirectory();
                            String filePath = '${tempDir.path}/signature.png';
                            var signatureImage = await controller.toPngBytes();

                            if (signatureImage != null) {
                              File file = File(filePath);
                              await file.writeAsBytes(signatureImage);

                              String satatutCode = await service
                                  .signatureContrat(data, file, api_provider);

                              if (satatutCode == "202") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Une erreur inattendue s'est produite",
                                    const Color.fromARGB(255, 233, 186, 186));
                              } else if (satatutCode == "404") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Impossible de signer cette lettre de voiture",
                                    Colors.redAccent);
                              } else if (satatutCode == "422") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Vous n'avez pas signer avant dee valider",
                                    Colors.redAccent);
                              } else if (satatutCode == "500") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Vérifiez votre connection internet et réessayer plus tard",
                                    Colors.redAccent);
                              } else if (satatutCode == "200") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Votre signature a été enregistrée avec succès",
                                    Colors.green);
                                controller.clear();
                                Navigator.of(dialogcontext).pop();
                              }
                            } else {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Vous devez signer avant de valider",
                                  Colors.redAccent);
                            }
                          },
                    child: affiche
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SizedBox(
                              height: 20,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: MyColors.light,
                              ),
                            ),
                          )
                        : Text(
                            "Validez",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  });
}

void downloadContrat(
    BuildContext context,
    Expeditions data,
    LetreVoitures contrat,
    Transporteurs transporteur,
    Users transporteur_user,
    Camions camion,
    Marchandises marchandise,
    Localisations localisation,
    Pays pay_depart,
    Pays pay_livraison,
    Villes city_depart,
    Villes city_livraison,
    Pieces piece,
    String quantite,
    String poids,
    double montant,
    double accompte,
    double solde) {
  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvDown>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        bool affiche = provider.affiche;
        double progress = provider.progress;
        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Text(
            "Lettre de voiture",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                fontWeight: FontWeight.bold),
          ),
          content: LinearProgressIndicator(
            value: progress,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 80,
                  height: 30,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          padding: EdgeInsets.only(left: 7, right: 7),
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        provider.change_affiche(false);
                        Navigator.of(dialogcontext).pop();
                      },
                      child: Text(
                        "Annulez",
                        style: TextStyle(
                            color: MyColors.light,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                            letterSpacing: 1),
                      )),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.green),
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);
                            await generatePdf();
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogcontext,
                                "Le document a été généré avec succès",
                                Colors.green);
                            Navigator.of(dialogcontext).pop();
                          },
                    child: affiche
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SizedBox(
                              height: 20,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: MyColors.light,
                              ),
                            ),
                          )
                        : Text(
                            "Téléchargez",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  });
}

Future<void> generatePdf() async {
  final pdf = pw.Document();

  // Préchargement des ressources
  final fontData = await rootBundle.load("fonts/Poppins-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);

  // Chargez les images ici, avant de générer le PDF
  final headerImageData = await rootBundle.load('images/entete.png');
  final footerImageData = await rootBundle.load('images/footer.png');
  final signatureDriverData = await rootBundle.load('images/sign.png');
  final signatureBodahData = await rootBundle.load('images/bodah.jpg');
  final watermarkImageData =
      await rootBundle.load('images/fil.jpg'); // Filigrane
  final transpImageData =
      await rootBundle.load('images/maxwell.jpg'); // Image supplémentaire

  // Convertissez les données des images en format utilisable par pw.Image
  final headerImage = pw.MemoryImage(headerImageData.buffer.asUint8List());
  final footerImage = pw.MemoryImage(footerImageData.buffer.asUint8List());
  final signatureDriver =
      pw.MemoryImage(signatureDriverData.buffer.asUint8List());
  final signatureBodah =
      pw.MemoryImage(signatureBodahData.buffer.asUint8List());
  final watermarkImage =
      pw.MemoryImage(watermarkImageData.buffer.asUint8List());
  final transpImage = pw.MemoryImage(transpImageData.buffer.asUint8List());

  // Obtenir la date actuelle
  final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()) +
      " à " +
      DateFormat('HH:mm:ss').format(DateTime.now());

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(20),
      header: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(currentDate, style: pw.TextStyle(font: ttf, fontSize: 7)),
            pw.Image(headerImage, height: 50),
          ],
        );
      },
      footer: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('CONFIEZ-VOUS AUX PROFESSIONNELS !',
                style: pw.TextStyle(
                    font: ttf, fontSize: 10, fontWeight: pw.FontWeight.bold)),
            pw.Image(footerImage, height: 40),
          ],
        );
      },
      build: (pw.Context context) => [
        pw.Container(
          decoration: pw.BoxDecoration(
            image: pw.DecorationImage(
              image: watermarkImage,
              fit: pw.BoxFit.cover,
            ),
          ),
          child: pw.Column(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 10),
                child: pw.Column(
                  children: [
                    // Section du titre et du QR code
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(transpImage, width: 60, height: 65),
                        pw.Expanded(
                          child: pw.Center(
                            child: pw.Text(
                              'Lettre de voiture sécurisée N°12345'
                                  .toUpperCase(),
                              style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 9,
                                  fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                        pw.Column(
                          children: [
                            pw.BarcodeWidget(
                              barcode: pw.Barcode.qrCode(),
                              data: 'https://example.com',
                              width: 60,
                              height: 60,
                            ),
                            pw.SizedBox(height: 2),
                            pw.Text('Scannez ici pour authentifier le document',
                                style: pw.TextStyle(font: ttf, fontSize: 3)),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),

                    // Section du nom de la société
                    pw.Opacity(
                      opacity: 0.6,
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromInt(0xFF6600),
                        ),
                        padding: const pw.EdgeInsets.all(10),
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'BODAH LOGISTICS',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white),
                        ),
                      ),
                    ),

                    // Tableau 1
                    pw.Table.fromTextArray(
                      border: pw.TableBorder.all(),
                      headers: ['IFU', 'Adresse', 'Tél', 'Email', 'Date'],
                      headerStyle: pw.TextStyle(
                        font: ttf, // Police
                        fontSize: 10, // Taille de police
                        fontWeight: pw.FontWeight.bold, // En gras
                        color: PdfColors.black, // Couleur du texte des en-têtes
                      ),
                      data: [
                        [
                          '32 02 32 27 30 95 2',
                          'RNIE1, Godomey, Abomey-Calavi, Bénin',
                          '+229 20 22 60 42',
                          'info@bodah.bj',
                          '14-10-2024'
                        ]
                      ],
                      cellStyle: pw.TextStyle(
                        font: ttf, // Police pour le contenu
                        fontSize: 9, // Taille de police pour les cellules
                      ),
                    ),

                    pw.SizedBox(height: 10),

                    pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Donne ordre au conducteur ci-dessous:',
                          textAlign: pw.TextAlign.start,
                          style: pw.TextStyle(
                              font: ttf, fontSize: 12, color: PdfColors.green)),
                    ),
                    pw.SizedBox(height: 5),

                    // Tableau 2
                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(2), // 20% largeur
                        1: pw.FlexColumnWidth(5), // 50% largeur
                        2: pw.FlexColumnWidth(3), // 30% largeur
                      },
                      children: [
                        pw.TableRow(
                          decoration: pw.BoxDecoration(
                            color: PdfColors.orange, // Couleur d'en-tête
                          ),
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.all(8),
                              child: pw.Center(
                                child: pw.Text(
                                  'CONDUCTEUR',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10,
                                    color: PdfColors.black,
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(8),
                              child: pw.Center(
                                child: pw.Text(
                                  'John Doe', // Valeurs statiques pour exemple
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10,
                                    color: PdfColors.white,
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(8),
                              child: pw.Center(
                                child: pw.Column(
                                  children: [
                                    pw.Text(
                                      'REFERENCE',
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                      textAlign: pw.TextAlign.center,
                                    ),
                                    pw.SizedBox(height: 2),
                                    pw.Container(
                                      height: 1,
                                      color: PdfColors
                                          .black, // Petite ligne sous le texte
                                    ),
                                    pw.SizedBox(height: 2),
                                    pw.Text(
                                      '123456789', // Référence statique
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        color: PdfColors.white,
                                      ),
                                      textAlign: pw.TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    pw.Table.fromTextArray(
                      border: pw.TableBorder.all(),
                      headers: [
                        'N° Permis',
                        'N° Camion',
                        'Adresse',
                        'Tel',
                        'Email'
                      ],
                      headerStyle: pw.TextStyle(
                        font: ttf, // Police
                        fontSize: 10, // Taille de police
                        fontWeight: pw.FontWeight.bold, // En gras
                        color: PdfColors.black, // Couleur du texte des en-têtes
                      ),
                      data: [
                        [
                          '12563CA12',
                          'BJ45212/BJ45263',
                          'Abomey-Calavi',
                          '*229 98653232',
                          'John@gmail.com'
                        ]
                      ],
                      cellStyle: pw.TextStyle(
                        font: ttf, // Police pour le contenu
                        fontSize: 9, // Taille de police pour les cellules
                      ),
                    ),

                    pw.SizedBox(height: 10),

                    pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('De charger la marchandise ci-dessous:',
                          textAlign: pw.TextAlign.start,
                          style: pw.TextStyle(
                              font: ttf, fontSize: 12, color: PdfColors.green)),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Table.fromTextArray(
                      border: pw.TableBorder.all(),
                      headers: [
                        'Objet du contrat',
                        'Nature',
                        'Tarif',
                        'Quantité'
                      ],
                      data: [
                        [
                          'Transport de marchandises',
                          'Nature X',
                          '10000 CFA',
                          '2 tonnes'
                        ],
                      ],
                    ),
                    pw.SizedBox(height: 10),

                    // Section Lieu de chargement, livraison, poids, etc.
                    pw.Table.fromTextArray(
                      border: pw.TableBorder.all(),
                      headers: [
                        'Lieu de chargement',
                        'Lieu de livraison',
                        'Poids',
                        'Quantité'
                      ],
                      data: [
                        [
                          'Cotonou, Bénin',
                          'Lagos, Nigeria',
                          '1500 kg',
                          '2 tonnes'
                        ],
                      ],
                    ),
                    pw.SizedBox(height: 10),

                    // Section Accompte, Solde, Règlement
                    pw.Table.fromTextArray(
                      border: pw.TableBorder.all(),
                      headers: ['Accompte', 'Solde', 'Règlement'],
                      data: [
                        ['5000 CFA', '5000 CFA', 'Espèces'],
                      ],
                    ),

                    pw.SizedBox(height: 20),

                    // Section de Règlement (Termes)
                    pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black, width: 1),
                      ),
                      child: pw.Text(
                        'En cas de défaut du donneur d\'ordre, la responsabilité du conducteur en cas de perte ou '
                        'd\'avarie survenus aux marchandises ou en cas de retard de livraison est limitée au montant '
                        'de l\'indemnité par le type de contrat concernant le transport...',
                        style: pw.TextStyle(font: ttf, fontSize: 8),
                        textAlign: pw.TextAlign.justify,
                      ),
                    ),

                    pw.SizedBox(height: 20),

                    // Signature section (avec les images préchargées)
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          children: [
                            pw.Text('Conducteur',
                                style: pw.TextStyle(font: ttf, fontSize: 12)),
                            pw.SizedBox(height: 30),
                            pw.Image(signatureDriver, width: 80, height: 60),
                            pw.Text('John Doe'),
                          ],
                        ),
                        pw.Column(
                          children: [
                            pw.Text('Logistique Bodah',
                                style: pw.TextStyle(font: ttf, fontSize: 12)),
                            pw.SizedBox(height: 30),
                            pw.Image(signatureBodah, width: 80, height: 60),
                            pw.Text('Massaoudy TROUCOU'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final current = DateFormat('yyyy-MM-dd').format(DateTime.now()) +
      " à " +
      DateFormat('HH-mm-ss').format(DateTime.now());
  String fileName = "lettre_voiture_sécurisée_$current.pdf";
  final output = await getExternalStorageDirectory();
  final file = File("${output!.path}/$fileName");
  await file.writeAsBytes(await pdf.save());

  await OpenFile.open(file.path);
}
