// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_adjacent_string_concatenation, deprecated_member_use

import 'dart:io';

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/charges.dart';
import 'package:bodah/modals/letrre_voyage.dart';
import 'package:bodah/modals/paiement_solde.dart';
import 'package:bodah/modals/signature.dart';
import 'package:bodah/modals/tarifs.dart';
import 'package:bodah/modals/type_paiements.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:bodah/ui/users/transporteur/drawer/index.dart';
import 'package:bodah/ui/users/transporteur/expeditions/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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
import '../../../../../modals/bordereau_livraisons.dart';
import '../../../../../modals/camions.dart';
import '../../../../../modals/destinataires.dart';
import '../../../../../modals/entreprises.dart';
import '../../../../../modals/expediteurs.dart';
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
    List<Signatures> signatures = api_provider.signatures;

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
              child: SingleChildScrollView(
                physics:
                    AlwaysScrollableScrollPhysics(), // Permet toujours le défilement
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.7, // Prend toute la hauteur de l'écran
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
                      Signatures signature =
                          function.signature(signatures, data.signature_id);
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
                                                      solde,
                                                      signature);
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
                                    "Impossible de signer ce bordereau de livraison",
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
                                    "Impossible de signer ce bordereau de livraison",
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

void downloadBordereau(
    BuildContext context,
    Expeditions data,
    BordereauLivraisons bordereau,
    Transporteurs transporteur,
    Users transporteur_user,
    Expediteurs expediteur,
    Users expediteur_user,
    Destinataires destinataire,
    Users destinataire_user,
    Entreprises entreprise,
    Entreprises dest_entreprise,
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
    Signatures transp_sign,
    Signatures exped_sign) {
  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvDown>(dialogcontext);
        final function = Provider.of<Functions>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        bool affiche = provider.affiche;

        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Text(
            "Bordereau de livraison",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                fontWeight: FontWeight.bold),
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

                            if (transp_sign.id == 0 || exped_sign.id == 0) {
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Veuillez récharger d'abord la page",
                                  Colors.redAccent);
                              provider.change_affiche(false);
                            } else {
                              await generateBordereau(
                                  data,
                                  bordereau,
                                  transporteur,
                                  transporteur_user,
                                  expediteur,
                                  expediteur_user,
                                  destinataire,
                                  destinataire_user,
                                  entreprise,
                                  dest_entreprise,
                                  camion,
                                  marchandise,
                                  localisation,
                                  pay_depart,
                                  pay_livraison,
                                  city_depart,
                                  city_livraison,
                                  piece,
                                  quantite,
                                  poids,
                                  transp_sign,
                                  exped_sign,
                                  function);
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Le document a été généré avec succès",
                                  Colors.green);
                              Navigator.of(dialogcontext).pop();
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
    double solde,
    Signatures signature) {
  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvDown>(dialogcontext);
        final function = Provider.of<Functions>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        bool affiche = provider.affiche;
        List<TypePaiements> types = api_provider.type_piaments;
        TypePaiements type =
            function.type_piament(types, data.type_paiement_id);

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
                            if (signature.id == 0) {
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Veuillez récharger votre page et réessayer",
                                  Colors.redAccent);
                              provider.change_affiche(false);
                            } else {
                              await generateContrat(
                                  data,
                                  contrat,
                                  transporteur,
                                  transporteur_user,
                                  camion,
                                  marchandise,
                                  localisation,
                                  pay_depart,
                                  pay_livraison,
                                  city_depart,
                                  city_livraison,
                                  piece,
                                  quantite,
                                  poids,
                                  montant,
                                  accompte,
                                  solde,
                                  signature,
                                  type,
                                  function);
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Le document a été généré avec succès",
                                  Colors.green);
                              Navigator.of(dialogcontext).pop();
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

Future<void> generateBordereau(
    Expeditions data,
    BordereauLivraisons bordereau,
    Transporteurs transporteur,
    Users transporteur_user,
    Expediteurs expediteur,
    Users expediteur_user,
    Destinataires destinataire,
    Users destinataire_user,
    Entreprises entreprise,
    Entreprises dest_entreprise,
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
    Signatures trans_sign,
    Signatures exped_sign,
    Functions function) async {
  final pdf = pw.Document();

  try {
    final signUrl = "https://test.bodah.bj/storage/${trans_sign.path}";

    final response = await http.get(Uri.parse(signUrl));

    final ExpsignUrl = "https://test.bodah.bj/storage/${exped_sign.path}";

    final Expresponse = await http.get(Uri.parse(ExpsignUrl));

    if (response.statusCode == 200 && Expresponse.statusCode == 200) {
      final fontData = await rootBundle.load("fonts/Poppins-Regular.ttf");
      final ttf = pw.Font.ttf(fontData);

      final headerImageData = await rootBundle.load('images/entete.png');
      final footerImageData = await rootBundle.load('images/footer.png');

      final headerImage = pw.MemoryImage(headerImageData.buffer.asUint8List());
      final footerImage = pw.MemoryImage(footerImageData.buffer.asUint8List());

      final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()) +
          " à " +
          DateFormat('HH:mm:ss').format(DateTime.now());

      final signatureDriver = pw.MemoryImage(response.bodyBytes);
      final ExpsignatureDriver = pw.MemoryImage(Expresponse.bodyBytes);
      final ref = DateFormat("yyyy").format(bordereau.created_at) +
          " " +
          DateFormat("MM").format(bordereau.created_at) +
          " " +
          DateFormat("dd").format(bordereau.created_at) +
          " " +
          DateFormat("HH:mm:ss").format(bordereau.created_at);
      pdf.addPage(
        pw.MultiPage(
          maxPages: 100,
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(20),
          header: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(currentDate,
                    style: pw.TextStyle(font: ttf, fontSize: 7)),
                pw.Image(headerImage, height: 50),
              ],
            );
          },
          footer: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Text('CONFIEZ-VOUS AUX PROFESSIONNELS !',
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Image(footerImage, height: 40),
              ],
            );
          },
          build: (pw.Context context) => [
            pw.Column(
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 10),
                  child: pw.Column(
                    children: [
                      // Section du titre et du QR code
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Bordereau de livraison sécurisé ${bordereau.numero_borderau}'
                                .toUpperCase(),
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 9,
                                fontWeight: pw.FontWeight.bold),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Column(
                            children: [
                              pw.BarcodeWidget(
                                barcode: pw.Barcode.qrCode(),
                                data: entreprise.id != 0
                                    ? "${bordereau.numero_borderau} ${dest_entreprise.name} ${transporteur_user.name} $ref"
                                    : "${bordereau.numero_borderau} ${destinataire_user.name} ${transporteur_user.name} $ref",
                                width: 60,
                                height: 60,
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                  'Scannez ici pour authentifier le document',
                                  style: pw.TextStyle(font: ttf, fontSize: 3)),
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),

                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(7), // 20% largeur
                          1: pw.FlexColumnWidth(1), // 50% largeur
                          2: pw.FlexColumnWidth(2), // 30% largeur
                        },
                        children: [
                          pw.TableRow(
                            decoration: pw.BoxDecoration(
                              color: PdfColors.orange, // Couleur d'en-tête
                            ),
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Text(
                                  'TRANSPORTEUR',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10,
                                    color: PdfColors.black,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    'DATE',
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
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    function.date(bordereau.created_at),
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8,
                                      color: PdfColors.white,
                                    ),
                                    textAlign: pw.TextAlign.center,
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
                          'Entreprise',
                          'IFU',
                          'Adresse',
                          'Tél',
                          'Email',
                          'Date'
                        ],
                        headerStyle: pw.TextStyle(
                          font: ttf, // Police
                          fontSize: 10, // Taille de police
                          fontWeight: pw.FontWeight.bold, // En gras
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                          5: pw.Alignment.center,
                        },
                        data: [
                          [
                            'BODAH LOGISTICS SARL',
                            '32 02 32 27 30 95 2',
                            'RNIE1, Godomey, Abomey-Calavi, Bénin',
                            '+229 20 22 60 42',
                            'info@bodah.bj',
                            '14-10-2024'
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                      ),

                      pw.SizedBox(height: 10),

                      pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.orange,
                        ),
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "EXPEDITEUR/CAD/TRANSITAIRE",
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),

                      pw.Table.fromTextArray(
                        border: pw.TableBorder.all(),
                        headers: ['Nom', 'IFU', 'Adresse', 'Tél', 'Email'],
                        headerStyle: pw.TextStyle(
                          font: ttf, // Police
                          fontSize: 10, // Taille de police
                          fontWeight: pw.FontWeight.bold, // En gras
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                        },
                        data: [
                          [
                            entreprise.id != 0
                                ? entreprise.name
                                : expediteur_user.name,
                            entreprise.id != 0
                                ? entreprise.ifu ?? "----"
                                : "---",
                            expediteur_user.adresse ?? "---",
                            expediteur_user.telephone,
                            expediteur_user.email ?? "----"
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                      ),

                      pw.SizedBox(height: 10),

                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(6), // 20% largeur
                          1: pw.FlexColumnWidth(1.5), // 50% largeur
                          2: pw.FlexColumnWidth(2.5), // 30% largeur
                        },
                        children: [
                          pw.TableRow(
                            decoration: pw.BoxDecoration(
                              color: PdfColors.orange, // Couleur d'en-tête
                            ),
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Text(
                                  'MARCHANDISE',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10,
                                    color: PdfColors.black,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    'N° SUIVI',
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
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    data.numero_expedition,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8,
                                      color: PdfColors.white,
                                    ),
                                    textAlign: pw.TextAlign.center,
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
                          "Référence",
                          'Nature',
                          'Quantité',
                          'Poids',
                          'Lieu de chargement',
                          'Date de chargement',
                          'Lieu de livraison',
                          'Date de livraison'
                        ],
                        headerStyle: pw.TextStyle(
                          font: ttf, // Police
                          fontSize: 7, // Taille de police
                          fontWeight: pw.FontWeight.bold, // En gras
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        data: [
                          [
                            marchandise.numero_marchandise,
                            marchandise.nom,
                            quantite,
                            poids,
                            localisation.address_exp != null
                                ? "${localisation.address_exp} , ${city_depart.name}, ${pay_depart.name}"
                                : "${city_depart.name} , ${pay_depart.name}",
                            function.date(data.date_depart),
                            localisation.address_liv != null
                                ? "${localisation.address_liv} , ${city_livraison.name}, ${pay_livraison.name}"
                                : "${city_livraison.name} , ${pay_livraison.name}",
                            function.date(data.date_arrivee)
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 6, // Taille de police pour les cellules
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                          5: pw.Alignment.center,
                          6: pw.Alignment.center,
                          7: pw.Alignment.center,
                        },
                      ),
                      pw.SizedBox(height: 10),

                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(6), // 20% largeur
                          1: pw.FlexColumnWidth(1.5), // 50% largeur
                          2: pw.FlexColumnWidth(2.5), // 30% largeur
                        },
                        children: [
                          pw.TableRow(
                            decoration: pw.BoxDecoration(
                              color: PdfColors.orange, // Couleur d'en-tête
                            ),
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Text(
                                  'CONDUCTEUR',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10,
                                    color: PdfColors.black,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    'IDENTIFIANT',
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
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    transporteur.numero_transporteur,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
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
                          'Nom',
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
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        data: [
                          [
                            transporteur_user.name,
                            piece.num_piece,
                            camion.num_immatriculation,
                            transporteur_user.adresse ?? "---",
                            transporteur_user.telephone,
                            transporteur_user.email ?? "---"
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                          5: pw.Alignment.center,
                        },
                      ),

                      pw.SizedBox(height: 10),

                      pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.orange,
                        ),
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "DESTINATAIRE",
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),

                      pw.Table.fromTextArray(
                        border: pw.TableBorder.all(),
                        headers: [
                          'Entreprise',
                          'IFU',
                          'Adresse',
                          'Tél',
                          'Email',
                        ],
                        headerStyle: pw.TextStyle(
                          font: ttf, // Police
                          fontSize: 10, // Taille de police
                          fontWeight: pw.FontWeight.bold, // En gras
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                        },
                        data: [
                          [
                            dest_entreprise.id != 0
                                ? dest_entreprise.name
                                : destinataire_user.name,
                            dest_entreprise.id != 0
                                ? dest_entreprise.ifu ?? "----"
                                : "---",
                            destinataire_user.adresse ?? "---",
                            destinataire_user.telephone,
                            destinataire_user.email ?? "----"
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                      ),

                      pw.SizedBox(height: 20),

                      // Section de Règlement (Termes)
                      pw.Container(
                        width: double
                            .infinity, // Pour prendre toute la largeur disponible
                        padding: const pw.EdgeInsets.all(7),
                        decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1),
                        ),
                        child: pw.Text(
                          "Observations particulières",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              fontSize: 8,
                              color: PdfColors.black),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),

                      pw.Container(
                        width: double.infinity,
                        padding: const pw.EdgeInsets.all(7),
                        decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1),
                        ),
                        child: pw.Text(
                          data.obs ?? "Néant",
                          maxLines: 10,
                          overflow: pw.TextOverflow.visible,
                          style: pw.TextStyle(
                              font: ttf, fontSize: 7, color: PdfColors.red),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),

                      pw.SizedBox(height: 20),

                      // Signature section (avec les images préchargées)
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: [
                          pw.Column(
                            children: [
                              pw.Text("CONDUCTEUR",
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black)),
                              pw.SizedBox(height: 0),
                              pw.Image(signatureDriver, width: 80, height: 70),
                              pw.SizedBox(height: 10),
                              pw.Text(transporteur_user.name,
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black)),
                            ],
                          ),
                          pw.Column(
                            children: [
                              dest_entreprise.id != 0
                                  ? pw.Text(dest_entreprise.name,
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.black))
                                  : pw.Text("DESTINATAIRE",
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.black)),
                              pw.SizedBox(height: 0),
                              pw.Image(ExpsignatureDriver,
                                  width: 80, height: 70),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  bordereau.representant ??
                                      destinataire_user.name,
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

      final current = DateFormat('yyyy-MM-dd').format(DateTime.now()) +
          "_" +
          DateFormat('HH-mm-ss').format(DateTime.now());
      String fileName = "borcereau_livraison_sécurisée_$current.pdf";
      final output = await getExternalStorageDirectory();
      final file = File("${output!.path}/$fileName");
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path);
    }
  } catch (e) {}
}

Future<void> generateContrat(
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
    double solde,
    Signatures signature,
    TypePaiements type_paiement,
    Functions function) async {
  final pdf = pw.Document();
  try {
    final signUrl = "https://test.bodah.bj/storage/${signature.path}";

    final response = await http.get(Uri.parse(signUrl));
    final transpData = await rootBundle.load('images/user.png');
    var transpImage = pw.MemoryImage(transpData.buffer.asUint8List());

    if (response.statusCode == 200) {
      final signatureDriver = pw.MemoryImage(response.bodyBytes);
      final fontData = await rootBundle.load("fonts/Poppins-Regular.ttf");
      final ttf = pw.Font.ttf(fontData);

      if (transporteur.photo_url != null) {
        final transpUrl =
            "https://test.bodah.bj/storage/${transporteur.photo_url}";
        final responseTransp = await http.get(Uri.parse(transpUrl));

        if (responseTransp.statusCode == 200) {
          transpImage = pw.MemoryImage(responseTransp.bodyBytes);
        }
      }

      final headerImageData = await rootBundle.load('images/entete.png');
      final footerImageData = await rootBundle.load('images/footer.png');
      final signatureBodahData = await rootBundle.load('images/bodah.jpg');

      // Convertissez les données des images en format utilisable par pw.Image
      final headerImage = pw.MemoryImage(headerImageData.buffer.asUint8List());
      final footerImage = pw.MemoryImage(footerImageData.buffer.asUint8List());
      final signatureBodah =
          pw.MemoryImage(signatureBodahData.buffer.asUint8List());

      final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()) +
          " à " +
          DateFormat('HH:mm:ss').format(DateTime.now());
      final ref = DateFormat("yyyy").format(contrat.created_at) +
          " " +
          DateFormat("MM").format(contrat.created_at) +
          " " +
          DateFormat("dd").format(contrat.created_at) +
          " " +
          DateFormat("HH:mm:ss").format(contrat.created_at);

      pdf.addPage(
        pw.MultiPage(
          maxPages: 100,
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(20),
          header: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(currentDate,
                    style: pw.TextStyle(font: ttf, fontSize: 7)),
                pw.Image(headerImage, height: 50),
              ],
            );
          },
          footer: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Text('CONFIEZ-VOUS AUX PROFESSIONNELS !',
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Image(footerImage, height: 40),
              ],
            );
          },
          build: (pw.Context context) => [
            pw.Column(
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 10),
                  child: pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Image(transpImage, width: 60, height: 65),
                          pw.Expanded(
                            child: pw.Center(
                              child: pw.Text(
                                'Lettre de voiture sécurisée ${contrat.reference}'
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
                                data:
                                    "${contrat.reference} ${transporteur_user.name} $ref",
                                width: 60,
                                height: 60,
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                  'Scannez ici pour authentifier le document',
                                  style: pw.TextStyle(font: ttf, fontSize: 3)),
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),

                      // Section du nom de la société
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.orange,
                        ),
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'BODAH LOGISTICS',
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
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
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                          5: pw.Alignment.center,
                        },
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
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                      ),

                      pw.SizedBox(height: 10),

                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Donne ordre au conducteur ci-dessous:',
                            textAlign: pw.TextAlign.start,
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 10,
                                color: PdfColors.green)),
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
                                padding: pw.EdgeInsets.all(5),
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
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    transporteur_user.name,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8,
                                      color: PdfColors.white,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
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
                                        transporteur.numero_transporteur,
                                        style: pw.TextStyle(
                                          fontSize: 8,
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
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        data: [
                          [
                            piece.num_piece,
                            camion.num_immatriculation,
                            transporteur_user.adresse ?? "---",
                            transporteur_user.telephone,
                            transporteur_user.email ?? "----"
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                        cellAlignments: {
                          0: pw.Alignment
                              .center, // Centrer la colonne 0 (N° Permis)
                          1: pw.Alignment
                              .center, // Centrer la colonne 1 (N° Camion)
                          2: pw.Alignment
                              .center, // Centrer la colonne 2 (Adresse)
                          3: pw.Alignment.center, // Centrer la colonne 3 (Tel)
                          4: pw
                              .Alignment.center, // Centrer la colonne 4 (Email)
                        },
                      ),

                      pw.SizedBox(height: 10),

                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('De charger la marchandise ci-dessous:',
                            textAlign: pw.TextAlign.start,
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 10,
                                color: PdfColors.green)),
                      ),
                      pw.SizedBox(height: 5),

                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(2), // 20% largeur
                          1: pw.FlexColumnWidth(3), // 50% largeur
                          2: pw.FlexColumnWidth(2), // 30% largeur
                          3: pw.FlexColumnWidth(3),
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
                                    "Objet du contrat",
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
                                    "Transport de marchandise", // Valeurs statiques pour exemple
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.white,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    "Réglement",
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
                                    type_paiement.nom,
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.white,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(1.9), // 20% largeur
                          1: pw.FlexColumnWidth(2.7), // 50% largeur
                          2: pw.FlexColumnWidth(1), // 30% largeur
                          3: pw.FlexColumnWidth(1.3),
                          4: pw.FlexColumnWidth(1.1),
                          5: pw.FlexColumnWidth(2),
                        },
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Référence",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    marchandise.numero_marchandise,
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Nature",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    marchandise.nom,
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Tarif",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    function.formatAmount(montant) + " XOF",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(1.9), // 20% largeur
                          1: pw.FlexColumnWidth(2.7), // 50% largeur
                          2: pw.FlexColumnWidth(1), // 30% largeur
                          3: pw.FlexColumnWidth(1.3),
                          4: pw.FlexColumnWidth(1.1),
                          5: pw.FlexColumnWidth(2),
                        },
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Lieu de chargement",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    localisation.address_exp != null
                                        ? "${localisation.address_exp} , ${city_depart.name}, ${pay_depart.name}"
                                        : "${city_depart.name} , ${pay_depart.name}",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Quantité",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    quantite,
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Accompte",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    function.formatAmount(accompte) + " XOF",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(1.9), // 20% largeur
                          1: pw.FlexColumnWidth(2.7), // 50% largeur
                          2: pw.FlexColumnWidth(1), // 30% largeur
                          3: pw.FlexColumnWidth(1.3),
                          4: pw.FlexColumnWidth(1.1),
                          5: pw.FlexColumnWidth(2),
                        },
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Lieu de livraison",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    localisation.address_liv != null
                                        ? "${localisation.address_liv} , ${city_livraison.name}, ${pay_livraison.name}"
                                        : "${city_livraison.name} , ${pay_livraison.name}",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Poids",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    poids,
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Solde",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Center(
                                  child: pw.Text(
                                    function.formatAmount(solde) + " XOF",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      pw.SizedBox(height: 20),

                      // Section de Règlement (Termes)
                      pw.Container(
                        width: double
                            .infinity, // Pour prendre toute la largeur disponible
                        padding: const pw.EdgeInsets.all(7),
                        decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1),
                        ),
                        child: pw.Text(
                          "ENGAGEMENT",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              fontSize: 8,
                              color: PdfColors.black),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),

                      pw.Container(
                        width: double.infinity,
                        padding: const pw.EdgeInsets.all(7),
                        decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "En l'absence de convention écrite ou de déclaration de valeur par le Donneur d'Ordre, la responsabilité du conducteur en cas de perte, avarie ou retard de livraison est limitée à l'indemnité prévue par le contrat type.",
                              maxLines: 10,
                              overflow: pw.TextOverflow.visible,
                              style: pw.TextStyle(font: ttf, fontSize: 7),
                              textAlign: pw.TextAlign.justify,
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              "Le conducteur du camion de transport déclare avoir parfaite connaissance de la réglementation en vigueur applicable au transport et à la manutention des marchandises et notamment celles concernant le transport du riz",
                              maxLines: 10,
                              overflow: pw.TextOverflow.visible,
                              style: pw.TextStyle(font: ttf, fontSize: 7),
                              textAlign: pw.TextAlign.justify,
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              maxLines: 10,
                              overflow: pw.TextOverflow.visible,
                              "Le conducteur du camion de transport reconnait expressément avoir toutes les autorisations requises pour exercer son activité.",
                              style: pw.TextStyle(font: ttf, fontSize: 7),
                              textAlign: pw.TextAlign.justify,
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              maxLines: 5,
                              overflow: pw.TextOverflow.visible,
                              "En cas de non renouvellement de son agrément ou d’arrêt d’activité pour quelques raisons que se soient, il en informera immédiatement son client.",
                              style: pw.TextStyle(font: ttf, fontSize: 7),
                              textAlign: pw.TextAlign.justify,
                            ),
                          ],
                        ),
                      ),

                      pw.SizedBox(height: 20),

                      // Signature section (avec les images préchargées)
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: [
                          pw.Column(
                            children: [
                              pw.Text("CONDUCTEUR",
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black)),
                              pw.SizedBox(height: 0),
                              pw.Image(signatureDriver, width: 80, height: 70),
                              pw.SizedBox(height: 10),
                              pw.Text(transporteur_user.name,
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black)),
                            ],
                          ),
                          pw.Column(
                            children: [
                              pw.Text("BODAH LOGISTICS",
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black)),
                              pw.SizedBox(height: 0),
                              pw.Image(signatureBodah, width: 80, height: 60),
                              pw.SizedBox(height: 10),
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
          ],
        ),
      );

      final current = DateFormat('yyyy-MM-dd').format(DateTime.now()) +
          "_" +
          DateFormat('HH-mm-ss').format(DateTime.now());
      String fileName = "lettre_voiture_sécurisée_$current.pdf";
      final output = await getExternalStorageDirectory();
      final file = File("${output!.path}/$fileName");
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path);
    }
  } catch (e) {}
}
