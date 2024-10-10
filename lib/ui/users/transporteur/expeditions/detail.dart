// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/camions.dart';
import 'package:bodah/modals/statut_expeditions.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/ui/users/transporteur/annonces/details/index.dart';
import 'package:bodah/ui/users/transporteur/drawer/index.dart';
import 'package:bodah/wrappers/load.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/annonces.dart';
import '../../../../../../modals/expeditions.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../modals/charges.dart';
import '../../../../../modals/pieces.dart';
import '../../../../../modals/tarifs.dart';

class DetailChargement extends StatelessWidget {
  const DetailChargement({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<Expeditions> expeditions = api_provider.expeditions;
    Users? user = api_provider.user;
    List<Annonces> annonces = api_provider.annonces;
    List<Users> users = api_provider.users;
    Expeditions expedition = function.expedition(expeditions, id);
    Annonces annonce = function.annonce(annonces, expedition.annonce_id);
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    Transporteurs transporteur =
        function.expedition_transporteur(transporteurs, expedition);
    Users transporteur_user = function.user(users, transporteur.user_id);
    List<Camions> camions = api_provider.camions;
    Camions camion = function.expedition_camion(camions, expedition);
    List<Pieces> pieces = api_provider.pieces;
    List<StatutExpeditions> statuts = api_provider.statut_expeditions;
    List<Charge> charges = api_provider.charges;
    List<Tarif> tarifs = api_provider.tarifs;
    Pieces piece = function.data_piece(pieces, transporteur.id, "Transporteur");
    StatutExpeditions statut =
        function.statut(statuts, expedition.statu_expedition_id);
    String quantite = "";
    String poids = "";
    double montant = 0;
    double accompte = 0;
    List<Charge> data_charges =
        function.expedition_charges(charges, expedition);
    if (data_charges.isNotEmpty) {
      for (var i = 0; i < data_charges.length; i++) {
        quantite += data_charges[i].quantite;
        poids += data_charges[i].poids;
        Tarif tarif = function.charge_tarif(tarifs, data_charges[i]);
        montant += tarif.montant;
        accompte += tarif.accompte;
      }
    }

    bool loading = api_provider.loading;

    return loading
        ? LoadingPage()
        : Scaffold(
            backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
            drawer: DrawerTransporteur(),
            appBar: AppBar(
              backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
              iconTheme: IconThemeData(
                  color: user.dark_mode == 1 ? MyColors.light : Colors.black),
              centerTitle: true,
              elevation: 0,
              title: Text(
                "Chargement éffectué",
                style: TextStyle(
                    color: user.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                    ))
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        expedition.numero_expedition,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: MyColors.light,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          onPressed: () {
                            showAnnonce(context, annonce);
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: MyColors.light,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: user.dark_mode == 1
                                ? MyColors.light
                                : MyColors.textColor,
                            width: 0.1,
                            style: BorderStyle.solid)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 15, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      transporteur_user.adresse ?? "----",
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      function.date(expedition.date_depart),
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      function.date(expedition.date_arrivee),
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      function.formatAmount(montant) + " XOF",
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      function.formatAmount(accompte) + " XOF",
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                alignment: Alignment.centerLeft,
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
                                                alignment: Alignment.centerLeft,
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

void showAnnonce(BuildContext context, Annonces annonce) {
  // Afficher l'alerte "Perte"
  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.85,
          message: "Voir l'annonce",
          backgroundColor: MyColors.secondary,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();
            Navigator.of(dialogcontext).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return DetailsMarchandises(id: annonce.id);
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

Widget buildAlertDialog({
  required String message,
  required Color backgroundColor,
  required Color textColor,
  required double bottom,
  required BuildContext context,
  required Function() onPressed,
}) {
  return GestureDetector(
    onTap: () {
      // Fermer toutes les AlertDialogs
      Navigator.of(context).popUntil((route) => route.isFirst);
    },
    child: Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom, right: 20),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(milliseconds: 500),
          builder: (BuildContext context, double value, Widget? child) {
            return Transform.translate(
              offset: Offset((1 - value) * 100, (1 - value) * 100),
              child: Opacity(
                opacity: value,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: EdgeInsets.zero,
                    backgroundColor: backgroundColor,
                  ),
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      message,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
