// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/modals/letrre_voyage.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../colors/color.dart';
import '../../../../../../../functions/function.dart';
import '../../../../../../../modals/appeles.dart';
import '../../../../../../../modals/expeditions.dart';
import '../../../../../../../modals/interchanges.dart';
import '../../../../../../../modals/recus.dart';
import '../../../../../../../modals/tdos.dart';
import '../../../../../../../modals/users.dart';
import '../../../../../../../modals/vgms.dart';
import '../../../../../../../providers/api/api_data.dart';
import '../../../../../../modals/camions.dart';
import '../../../../../../modals/charges.dart';
import '../../../../../../modals/destinataires.dart';
import '../../../../../../modals/entreprises.dart';
import '../../../../../../modals/expediteurs.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/paiement_solde.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/pieces.dart';
import '../../../../../../modals/signature.dart';
import '../../../../../../modals/tarifs.dart';
import '../../../../../../modals/villes.dart';
import '../../../../expediteur/import/details/docs/index.dart';
import '../../../documents/contrats/index.dart';

class DocsChargement extends StatelessWidget {
  const DocsChargement({super.key, required this.annonce});
  final Annonces annonce;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);

    List<Transporteurs> transporteurs = api_provider.transporteurs;
    List<Expeditions> expeditions = api_provider.expeditions;
    expeditions = function.annonce_expeditions(expeditions, annonce);
    expeditions = function.mesTransports(transporteurs, expeditions);
    List<Appeles> appeles = api_provider.appeles;
    appeles = function.expedition_appeles(appeles, expeditions);
    List<Interchanges> interchanges = api_provider.interchanges;
    interchanges = function.expedition_interchanges(interchanges, expeditions);
    List<Tdos> tdos = api_provider.tdos;
    tdos = function.expedition_tdo(tdos, expeditions);
    List<Vgms> vgms = api_provider.vgms;
    vgms = function.expedition_vgm(vgms, expeditions);
    List<Recus> recus = api_provider.recus;
    recus = function.expedition_recus(recus, expeditions);

    List<LetreVoitures> contrats = api_provider.contrats;
    contrats = function.expedition_contrats(contrats, expeditions);

    List<BordereauLivraisons> bordereaux = api_provider.bordereaux;
    bordereaux = function.expedition_bordereaux(bordereaux, expeditions);

    Future<void> refresh() async {
      await api_provider.InitTransporteursDocuments();
    }

    return RefreshIndicator(
      color: MyColors.secondary,
      onRefresh: refresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (contrats.isNotEmpty) {
                          showContrats(context, contrats);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            contrats.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune lettre de voiture",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : contrats.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          contrats.length.toString() +
                                              " lettre de voiture",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          contrats.length.toString() +
                                              " lettres de voiture",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (bordereaux.isNotEmpty) {
                          showBordereaux(context, bordereaux);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            bordereaux.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun bordereau de livraison",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : bordereaux.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (bordereaux.length).toString() +
                                              " bordereau de livraison",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (bordereaux.length).toString() +
                                              " bordereaux de livraisons",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (interchanges.isNotEmpty) {
                          showInterchanges(
                              context, annonce.id, "Expedition", interchanges);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            interchanges.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune interchange",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : interchanges.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          interchanges.length.toString() +
                                              " interchange",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          interchanges.length.toString() +
                                              " interchanges",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (recus.isNotEmpty) {
                          showRecus(context, annonce.id, "Annonce", recus);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            recus.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun reçu",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : recus.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (recus.length).toString() + " reçus",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (recus.length).toString() + " reçus",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (tdos.isNotEmpty) {
                          showTdo(context, annonce.id, "Annonce", tdos);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            tdos.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune TDO",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      tdos.length.toString() + " TDO",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (vgms.isNotEmpty) {
                          showVgm(context, annonce.id, "Annonce", vgms);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            vgms.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun VGM",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      (vgms.length).toString() + " VGM",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (appeles.isNotEmpty) {
                          showApeles(context, annonce.id, "Annonce", appeles);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            appeles.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune iappélé",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : appeles.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          appeles.length.toString() + " appélé",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          appeles.length.toString() +
                                              " appélés",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(.70)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.secondary,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.receipt,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Autres",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: MyColors.textColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> showBordereauxExpediteur(
    BuildContext context, List<BordereauLivraisons> bordereaux) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext dialogContext) {
      double columnWidth = MediaQuery.of(context).size.width / 10;
      final function = Provider.of<Functions>(dialogContext);
      final api_provider = Provider.of<ApiProvider>(dialogContext);
      List<Expeditions> expeditions = api_provider.expeditions;
      Users? user = api_provider.user;
      List<Annonces> annonces = api_provider.annonces;
      List<Marchandises> marchandises = api_provider.marchandises;
      List<Localisations> localisations = api_provider.localisations;
      List<Pays> pays = api_provider.pays;
      List<Villes> all_villes = api_provider.all_villes;
      List<Transporteurs> transporteurs = api_provider.transporteurs;
      List<Camions> camions = api_provider.camions;
      List<Users> users = api_provider.users;
      List<Charge> charges = api_provider.charges;
      List<Pieces> pieces = api_provider.pieces;
      List<Entreprises> entreprises = api_provider.entreprises;
      List<Destinataires> destinataires = api_provider.destinataires;
      List<Expediteurs> expediteurs = api_provider.expediteurs;
      List<Signatures> signatures = api_provider.signatures;

      return AlertDialog(
        title: Text(
          "Bordereaux de livraison",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: bordereaux.isEmpty
            ? Center(
                child: Text(
                  "Aucune donnée disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user!.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Référence",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: user!.dark_mode == 1
                                ? MyColors.light
                                : MyColors.black,
                            fontFamily: "Poppins",
                            fontSize: 10),
                      ),
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: bordereaux.map((data) {
                    Expeditions expedition =
                        function.expedition(expeditions, data.expedition_id);

                    Marchandises marchandise = function.expedition_marchandise(
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
                    Camions camion =
                        function.camion(camions, expedition.vehicule_id);
                    Transporteurs transporteur = function.transporteur(
                        transporteurs, expedition.transporteur_id);
                    Users chauffeur_user =
                        function.user(users, transporteur.user_id);

                    Pieces piece = function.data_piece(
                        pieces, transporteur.id, "Transporteur");

                    String quantite = "";
                    String poids = "";

                    List<Charge> data_charges =
                        function.expedition_charges(charges, expedition);
                    if (data_charges.isNotEmpty) {
                      for (var i = 0; i < data_charges.length; i++) {
                        quantite += data_charges[i].quantite;
                        poids += data_charges[i].poids;
                      }
                    }

                    Annonces annonce =
                        function.annonce(annonces, expedition.annonce_id);

                    Expediteurs expediteur =
                        function.expediteur(expediteurs, annonce.expediteur_id);
                    Entreprises entreprise = function.expediteur_entreprise(
                        entreprises, expediteur.id);
                    Users expediteur_user =
                        function.user(users, expediteur.user_id);
                    Destinataires destinataire = function
                        .marchandise_destinataire(destinataires, marchandise);
                    Users destinataire_user =
                        function.user(users, destinataire.user_id);

                    Signatures transp_sign =
                        function.signature(signatures, data.transp_sign_id);
                    Signatures exped_sign =
                        function.signature(signatures, data.dest_sign_id);
                    Expediteurs exped = function.user_expediteur(
                        expediteurs, destinataire_user);
                    Entreprises dest_entreprise =
                        function.expediteur_entreprise(entreprises, exped.id);
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.numero_borderau,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          data.dest_sign_id != null &&
                                  data.transp_sign_id != null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: () {
                                      downloadBordereau(
                                          dialogContext,
                                          expedition,
                                          data,
                                          transporteur,
                                          chauffeur_user,
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
                                          pay_dest,
                                          ville_dep,
                                          ville_dest,
                                          piece,
                                          quantite,
                                          poids,
                                          transp_sign,
                                          exped_sign);
                                    },
                                    icon: Icon(
                                      Icons.download,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              : data.dest_sign_id == null
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      child: SizedBox(
                                        height: 25,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              signerDestinataire(
                                                  dialogContext, expedition);
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
                                  : Container(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
      );
    },
  );
}

Future<dynamic> showBordereaux(
    BuildContext context, List<BordereauLivraisons> bordereaux) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext dialogContext) {
      double columnWidth = MediaQuery.of(context).size.width / 10;
      final function = Provider.of<Functions>(dialogContext);
      final api_provider = Provider.of<ApiProvider>(dialogContext);
      List<Expeditions> expeditions = api_provider.expeditions;
      Users? user = api_provider.user;
      List<Annonces> annonces = api_provider.annonces;
      List<Marchandises> marchandises = api_provider.marchandises;
      List<Localisations> localisations = api_provider.localisations;
      List<Pays> pays = api_provider.pays;
      List<Villes> all_villes = api_provider.all_villes;
      List<Transporteurs> transporteurs = api_provider.transporteurs;
      List<Camions> camions = api_provider.camions;
      List<Users> users = api_provider.users;
      List<Charge> charges = api_provider.charges;
      List<Pieces> pieces = api_provider.pieces;
      List<Entreprises> entreprises = api_provider.entreprises;
      List<Destinataires> destinataires = api_provider.destinataires;
      List<Expediteurs> expediteurs = api_provider.expediteurs;
      List<Signatures> signatures = api_provider.signatures;

      return AlertDialog(
        title: Text(
          "Bordereaux de livraison",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: bordereaux.isEmpty
            ? Center(
                child: Text(
                  "Aucune donnée disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user!.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Référence",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: user!.dark_mode == 1
                                ? MyColors.light
                                : MyColors.black,
                            fontFamily: "Poppins",
                            fontSize: 10),
                      ),
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: bordereaux.map((data) {
                    Expeditions expedition =
                        function.expedition(expeditions, data.expedition_id);

                    Marchandises marchandise = function.expedition_marchandise(
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
                    Camions camion =
                        function.camion(camions, expedition.vehicule_id);
                    Transporteurs transporteur = function.transporteur(
                        transporteurs, expedition.transporteur_id);
                    Users chauffeur_user =
                        function.user(users, transporteur.user_id);

                    Pieces piece = function.data_piece(
                        pieces, transporteur.id, "Transporteur");

                    String quantite = "";
                    String poids = "";

                    List<Charge> data_charges =
                        function.expedition_charges(charges, expedition);
                    if (data_charges.isNotEmpty) {
                      for (var i = 0; i < data_charges.length; i++) {
                        quantite += data_charges[i].quantite;
                        poids += data_charges[i].poids;
                      }
                    }

                    Annonces annonce =
                        function.annonce(annonces, expedition.annonce_id);

                    Expediteurs expediteur =
                        function.expediteur(expediteurs, annonce.expediteur_id);
                    Entreprises entreprise = function.expediteur_entreprise(
                        entreprises, expediteur.id);
                    Users expediteur_user =
                        function.user(users, expediteur.user_id);
                    Destinataires destinataire = function
                        .marchandise_destinataire(destinataires, marchandise);
                    Users destinataire_user =
                        function.user(users, destinataire.user_id);
                    Signatures transp_sign =
                        function.signature(signatures, data.transp_sign_id);
                    Signatures exped_sign =
                        function.signature(signatures, data.dest_sign_id);
                    Expediteurs exped = function.user_expediteur(
                        expediteurs, destinataire_user);
                    Entreprises dest_entreprise =
                        function.expediteur_entreprise(entreprises, exped.id);
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.numero_borderau,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          data.dest_sign_id != null &&
                                  data.transp_sign_id != null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: () {
                                      downloadBordereau(
                                          dialogContext,
                                          expedition,
                                          data,
                                          transporteur,
                                          chauffeur_user,
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
                                          pay_dest,
                                          ville_dep,
                                          ville_dest,
                                          piece,
                                          quantite,
                                          poids,
                                          transp_sign,
                                          exped_sign);
                                    },
                                    icon: Icon(
                                      Icons.download,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              : data.transp_sign_id == null
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      child: SizedBox(
                                        height: 25,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              signerTransporteur(
                                                  dialogContext, expedition);
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
                                  : Container(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
      );
    },
  );
}

Future<dynamic> showContrats(
    BuildContext context, List<LetreVoitures> contrats) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext dialogContext) {
      double columnWidth = MediaQuery.of(context).size.width / 10;
      final function = Provider.of<Functions>(dialogContext);
      final api_provider = Provider.of<ApiProvider>(dialogContext);
      Users? user = api_provider.user;
      List<Expeditions> expeditions = api_provider.expeditions;
      List<Annonces> annonces = api_provider.annonces;
      List<Marchandises> marchandises = api_provider.marchandises;
      List<Localisations> localisations = api_provider.localisations;
      List<Pays> pays = api_provider.pays;
      List<Villes> all_villes = api_provider.all_villes;
      List<Transporteurs> transporteurs = api_provider.transporteurs;
      List<Camions> camions = api_provider.camions;
      List<Users> users = api_provider.users;
      List<Charge> charges = api_provider.charges;
      List<Tarif> tarifs = api_provider.tarifs;
      List<Pieces> pieces = api_provider.pieces;
      List<PaiementSolde> paiements = api_provider.paiement_soldes;
      List<Signatures> signatures = api_provider.signatures;

      return AlertDialog(
        title: Text(
          "Lettres de voiture",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: contrats.isEmpty
            ? Center(
                child: Text(
                  "Aucune donnée disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user!.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Référence",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: user!.dark_mode == 1
                                ? MyColors.light
                                : MyColors.black,
                            fontFamily: "Poppins",
                            fontSize: 10),
                      ),
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: contrats.map((data) {
                    Expeditions expedition =
                        function.expedition(expeditions, data.expedition_id);

                    Marchandises marchandise = function.expedition_marchandise(
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
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          data.signature_id != null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: () {
                                      downloadContrat(
                                          dialogContext,
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
                                    icon: Icon(
                                      Icons.download,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: SizedBox(
                                    height: 25,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          signerContrat(
                                              dialogContext, expedition);
                                        },
                                        child: Text(
                                          "Signez",
                                          style: TextStyle(
                                              color: MyColors.light,
                                              fontSize: 10,
                                              fontFamily: "Poppins"),
                                        )),
                                  ),
                                ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
      );
    },
  );
}
