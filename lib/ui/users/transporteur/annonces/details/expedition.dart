// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/camions.dart';
import 'package:bodah/modals/expeditions.dart';
import 'package:bodah/modals/pieces.dart';
import 'package:bodah/modals/statut_expeditions.dart';
import 'package:bodah/modals/tarifs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../colors/color.dart';
import '../../../../../../../functions/function.dart';
import '../../../../../../../modals/annonces.dart';
import '../../../../../../../modals/charges.dart';
import '../../../../../../../modals/transporteurs.dart';
import '../../../../../../../modals/users.dart';
import '../../../../../../../providers/api/api_data.dart';
import '../../../../../../../wrappers/loading.dart';

class MesChargements extends StatefulWidget {
  const MesChargements({super.key, required this.annonce});
  final Annonces annonce;

  @override
  State<MesChargements> createState() => _MesChargementsState();
}

class _MesChargementsState extends State<MesChargements> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false)
        .InitTransporteurExpeditionForAnnonce();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Users> users = api_provider.users;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    List<Pieces> pieces = api_provider.pieces;
    List<Camions> camions = api_provider.camions;
    List<StatutExpeditions> statuts = api_provider.statut_expeditions;
    List<Charge> charges = api_provider.charges;
    List<Tarif> tarifs = api_provider.tarifs;
    List<Expeditions> expeditions = api_provider.expeditions;
    expeditions = function.annonce_expeditions(expeditions, widget.annonce);
    expeditions = function.mesTransports(transporteurs, expeditions);
    bool loading = api_provider.loading;

    return loading
        ? Loading()
        : expeditions.isEmpty
            ? Center(
                child: Text(
                "Auncune expédition disponible",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: user!.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ))
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        Expeditions expedition = expeditions[index];
                        StatutExpeditions statut = function.statut(
                            statuts, expedition.statu_expedition_id);
                        int quantite = 0;
                        double poids = 0;
                        double montant = 0;
                        double accompte = 0;
                        Transporteurs transporteur = function.transporteur(
                            transporteurs, expedition.transporteur_id);
                        Users transporteur_user =
                            function.user(users, transporteur.user_id);
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

                        Pieces piece = function.data_piece(
                            pieces, transporteur.id, "Transporteur");
                        Camions camion =
                            function.camion(camions, expedition.vehicule_id);

                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 4, left: 8, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: user!.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.textColor,
                                    width: 0.1,
                                    style: BorderStyle.solid)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 15, top: 15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
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
                                              expedition.numero_expedition,
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
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Id du chauffeur",
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
                                              transporteur.numero_transporteur,
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
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Chauffeur ",
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
                                              transporteur_user.name,
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
                                                0.43,
                                        child: Column(
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
                                              transporteur_user.telephone,
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
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Adresse ",
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
                                              transporteur_user.adresse ??
                                                  "----",
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
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Email",
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
                                              transporteur_user.email ?? "----",
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
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "N° Permis",
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
                                              piece.num_piece,
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
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "N° Camion",
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
                                              camion.num_immatriculation,
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
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Chargement : ",
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
                                              function
                                                  .date(expedition.date_depart),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Column(
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
                                              function.date(
                                                  expedition.date_arrivee),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 9),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Quantité",
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
                                              quantite.toString(),
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
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Poids",
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
                                              poids.toString(),
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
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tarif",
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
                                              function.formatAmount(montant) +
                                                  " XOF",
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
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Acompte",
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
                                              function.formatAmount(accompte) +
                                                  " XOF",
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
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Solde",
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
                                                      montant - accompte) +
                                                  " XOF",
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
                                                0.43,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Statut",
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
                                            statut.id == 2
                                                ? Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Terminée".toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.green),
                                                    ),
                                                  )
                                                : statut.id == 2
                                                    ? Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "EN COURS"
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      )
                                                    : Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Non démarée"
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: Colors
                                                                  .yellow),
                                                        ),
                                                      ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: expeditions.length),
                ),
              );
  }
}
