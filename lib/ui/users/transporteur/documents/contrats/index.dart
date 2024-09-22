// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_adjacent_string_concatenation

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/letrre_voyage.dart';
import 'package:bodah/ui/users/transporteur/drawer/index.dart';
import 'package:bodah/ui/users/transporteur/expeditions/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
import '../../../../../modals/statut_expeditions.dart';
import '../../../../../modals/transporteurs.dart';

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
          ? Center(
              child: Text("Vous n'avez aucune letre de voiture disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: user.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.w500,
                  )))
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    LetreVoitures data = datas[index];

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
                    StatutExpeditions statut = function.statut(
                        statuts, expedition.statu_expedition_id);
                    Camions camion =
                        function.camion(camions, expedition.vehicule_id);
                    Transporteurs transporteur = function.transporteur(
                        transporteurs, expedition.transporteur_id);
                    Users chauffeur_user =
                        function.user(users, transporteur.user_id);
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
                                              (localisation.address_exp ?? "") +
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
                                                  chauffeur_user.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Contact : ",
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
                                                  chauffeur_user.telephone,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                        function.date(expedition.date_arrivee),
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
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
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
                                          /* String url =
                                                "https://test.bodah.bj/storage/" +
                                                    data.path;
                                            downloadDocument(context, url);*/
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
    );
  }
}