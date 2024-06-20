// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/camions.dart';
import 'package:bodah/modals/destinataires.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/ui/users/expediteur/drawer/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/annonces.dart';
import '../../../../../../modals/expeditions.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';

class DetailExpedition extends StatelessWidget {
  const DetailExpedition({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<Expeditions> expeditions = api_provider.expeditions;
    final user = api_provider.user;
    List<Users> users = api_provider.users;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Tarifications> tarifications = api_provider.tarifications;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    Expeditions expedition = function.expedition(expeditions, id);
    Marchandises marchandise =
        function.marchandise(marchandises, expedition.marchandise_id);
    Localisations localisation =
        function.marchandise_localisation(localisations, marchandise.id);
    Pays pay_depart = function.pay(pays, localisation.pays_exp_id);
    Pays pay_dest = function.pay(pays, localisation.pays_liv_id);
    Villes ville_dep = function.ville(all_villes, localisation.city_exp_id);
    Villes ville_dest = function.ville(all_villes, localisation.city_liv_id);
    Tarifications tarification =
        function.marchandise_tarification(tarifications, marchandise.id);
    List<Annonces> annonces = api_provider.annonces;
    Annonces annonce = function.marchandise_annonce(annonces, marchandise);
    List<Destinataires> destinataires = api_provider.destinataires;
    Destinataires destinataire =
        function.marchandise_destinataire(destinataires, marchandise);
    Users destinataire_user = function.user(users, destinataire.user_id);
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    Transporteurs transporteur =
        function.expedition_transporteur(transporteurs, expedition);
    Users transporteur_user = function.user(users, transporteur.user_id);
    List<Camions> camions = api_provider.camions;
    Camions camion = function.expedition_camion(camions, expedition);

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
          "Expédition de la marchandise",
          style: TextStyle(
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
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
                    expedition.numero_expedition,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.download,
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
                      "Date de piublication de l'annonce",
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
                      "Référence de l'expédition",
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
                      expedition.numero_expedition,
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
                      "Marchandise expédiée",
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
                      marchandise.nom,
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
                      "Référence de la marchandise",
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
                      marchandise.numero_marchandise,
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
                      "Tarif de l'expédition",
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
                      function.formatAmount(tarification.prix_expedition),
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
                      "Lieu de chargement",
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
                      pay_depart.name + " - " + ville_dep.name,
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
                      "Date de chargement",
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
                      function.date(expedition.date_depart),
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
                      "Lieu de  déchargement",
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
                      pay_dest.name + " - " + ville_dest.name,
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
                  function.date(expedition.date_arrivee).isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Date de déchargement",
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
                                function.date(expedition.date_arrivee),
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
                          ],
                        )
                      : Container(),
                  destinataire.id > 0
                      ? Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              color: MyColors.secondary,
                              height: 40,
                              width: double.infinity,
                              child: Text(
                                "Destinataire de la marchandise",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Référence du destinataire",
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
                                destinataire.numero_destinataire,
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
                                "Nom du destinataire",
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
                                destinataire_user.name,
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
                                "Téléphhone du destinataire",
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
                                destinataire_user.telephone,
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
                          ],
                        )
                      : Container(),
                  transporteur.id > 0
                      ? Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              color: MyColors.secondary,
                              height: 40,
                              width: double.infinity,
                              child: Text(
                                "Transporteur de la marchandise",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Référence du transporteur",
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
                                transporteur.numero_transporteur,
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
                                "Nom du transporteur",
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
                                transporteur_user.name,
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
                                "Téléphhone du transporteur",
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
                                transporteur_user.telephone,
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
                            camion.id > 0
                                ? Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Immatriculation du camion",
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
                                          function.immatriculation(
                                              camion.num_immatriculation),
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
                                    ],
                                  )
                                : Container(),
                          ],
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
