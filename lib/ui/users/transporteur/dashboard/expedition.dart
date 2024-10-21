// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:bodah/modals/localisations.dart';
import 'package:bodah/modals/marchandises.dart';
import 'package:bodah/modals/statut_expeditions.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/ui/users/transporteur/expeditions/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/annonces.dart';
import '../../../../../modals/expeditions.dart';
import '../../../../../modals/pays.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../modals/camions.dart';
import '../../../../modals/gps.dart';
import '../../../../modals/transporteurs.dart';
import '../expeditions/location.dart';

class MesTransport extends StatelessWidget {
  const MesTransport({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Expeditions> expeditions = api_provider.expeditions;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<Annonces> annonces = api_provider.annonces;
    List<StatutExpeditions> statuts = api_provider.statut_expeditions;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    Transporteurs user_transporteur =
        function.user_transporteur(user, transporteurs);
    List<Camions> camions = api_provider.camions;
    List<Users> users = api_provider.users;
    List<Gps> gps = api_provider.gps;

    Future<void> refresh() async {
      await api_provider.InitTransporteurExpedition();
    }

    return RefreshIndicator(
      color: MyColors.secondary,
      onRefresh: refresh,
      child: expeditions.isEmpty
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
                          color: user!.dark_mode == 1
                              ? MyColors.light
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: expeditions.length,
                itemBuilder: (context, index) {
                  Expeditions data = expeditions[index];
                  Marchandises marchandise = function.expedition_marchandise(
                      data, marchandises, annonces);
                  Localisations localisation = function
                      .marchandise_localisation(localisations, marchandise.id);
                  Pays pay_depart =
                      function.pay(pays, localisation.pays_exp_id);
                  Pays pay_dest = function.pay(pays, localisation.pays_liv_id);
                  Villes ville_dep =
                      function.ville(all_villes, localisation.city_exp_id);
                  Villes ville_dest =
                      function.ville(all_villes, localisation.city_liv_id);
                  StatutExpeditions statut =
                      function.statut(statuts, data.statu_expedition_id);
                  Camions camion = function.camion(camions, data.vehicule_id);
                  Transporteurs transporteur = function.transporteur(
                      transporteurs, data.transporteur_id);
                  Users chauffeur_user =
                      function.user(users, transporteur.user_id);
                  Gps location =
                      function.location(gps, chauffeur_user.id, "User");

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
                              return DetailChargement(id: data.id);
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
                      child: Container(
                        decoration: BoxDecoration(
                            color: index % 2 != 0
                                ? Colors.grey.withOpacity(.2)
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: user!.dark_mode == 1
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
                                      data.numero_expedition,
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
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://test.bodah.bj/countries/${pay_depart.flag}",
                                            fit: BoxFit.cover,
                                            height: 15,
                                            width: 20,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                              value: downloadProgress.progress,
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
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://test.bodah.bj/countries/${pay_dest.flag}",
                                            fit: BoxFit.cover,
                                            height: 15,
                                            width: 20,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                              value: downloadProgress.progress,
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
                                      function.date(data.date_depart),
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
                                      function.date(data.date_arrivee),
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
                                                    fontWeight: FontWeight.w300,
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
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.yellow),
                                              ),
                                            ),
                                ],
                              ),
                              statut.id == 1 && location.id != 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      child: SizedBox(
                                        height: 25,
                                        width: 150,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  transitionDuration: Duration(
                                                      milliseconds: 500),
                                                  pageBuilder: (BuildContext
                                                          context,
                                                      Animation<double>
                                                          animation,
                                                      Animation<double>
                                                          secondaryAnimation) {
                                                    return LocationChargement(
                                                        chargement_id: data.id);
                                                  },
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return ScaleTransition(
                                                      scale: Tween<double>(
                                                              begin: 0.0,
                                                              end: 1.0)
                                                          .animate(animation),
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Text(
                                                  "Localisation",
                                                  style: TextStyle(
                                                      color: MyColors.light,
                                                      fontSize: 10,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ],
                                            )),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
