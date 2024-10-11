// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:bodah/modals/localisations.dart';
import 'package:bodah/modals/marchandises.dart';
import 'package:bodah/modals/souscriptions.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/type_chargements.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/wrappers/load.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/pays.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../modals/transporteurs.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../annonces/details/index.dart';
import '../drawer/index.dart';

class ListSouscription extends StatelessWidget {
  const ListSouscription({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    bool loading = api_provider.loading;
    List<Souscriptions> souscriptions = api_provider.souscriptions;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<TypeChargements> type_chargements = api_provider.type_chargements;
    List<Tarifications> tarifications = api_provider.tarifications;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    List<Users> users = api_provider.users;
    Transporteurs user_transporteur =
        function.user_transporteur(user, transporteurs);
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
                "Mes souscriptions",
                style: TextStyle(
                    color: user.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
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
            body: souscriptions.isEmpty
                ? Center(
                    child: Text(
                    "Auncune souscription disponible",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color:
                            user.dark_mode == 1 ? MyColors.light : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ))
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: souscriptions.length,
                      itemBuilder: (context, index) {
                        Souscriptions data = souscriptions[index];
                        Marchandises marchandise = function.marchandise(
                            marchandises, data.marchandise_id);
                        Localisations localisation =
                            function.marchandise_localisation(
                                localisations, marchandise.id);
                        Pays pay_depart =
                            function.pay(pays, localisation.pays_exp_id);
                        Pays pay_dest =
                            function.pay(pays, localisation.pays_liv_id);
                        Villes ville_dep = function.ville(
                            all_villes, localisation.city_exp_id);
                        Villes ville_dest = function.ville(
                            all_villes, localisation.city_liv_id);
                        TypeChargements type_chargement =
                            function.type_chargement(type_chargements,
                                marchandise.type_chargement_id);

                        Tarifications tarif = function.marchandise_tarification(
                            tarifications, marchandise.id);
                        Transporteurs transporteur = function.transporteur(
                            transporteurs, data.transporteur_id);
                        Users chauffeur_user =
                            function.user(users, transporteur.user_id);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return DetailsMarchandises(
                                        id: marchandise.annonce_id);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                            data.numero_souscription,
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
                                                        color: user.dark_mode ==
                                                                1
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
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
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
                                                        color: user.dark_mode ==
                                                                1
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
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Type de chargement : ",
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
                                            type_chargement.name,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Poids : ",
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
                                            marchandise.poids,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tarif de transport : ",
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
                                            tarif.prix_transport,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date de souscription : ",
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
                                            function.date(data.created_at),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress,
                                                    color: MyColors.secondary,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(),
                                                ),
                                              ),
                                        localisation.address_exp?.isEmpty ??
                                                true
                                            ? Expanded(
                                                child: Text(
                                                  ville_dep.name +
                                                      " , " +
                                                      pay_depart.name,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress,
                                                    color: MyColors.secondary,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(),
                                                ),
                                              ),
                                        localisation.address_liv?.isEmpty ??
                                                true
                                            ? Expanded(
                                                child: Text(
                                                  ville_dest.name +
                                                      " , " +
                                                      pay_dest.name,
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date de chargement : ",
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
                                            function.date(
                                                marchandise.date_chargement),
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                        width: 110,
                                        height: 30,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            onPressed: () {
                                              DeleteSouscription(context, data);
                                            },
                                            child: Text(
                                              "Supprimez",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: MyColors.light,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10),
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
                    ),
                  ));
  }
}

Future<dynamic> DeleteSouscription(
    BuildContext context, Souscriptions souscription) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final provider = Provider.of<ApiProvider>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool delete = provider.delete;
      return AlertDialog(
        title: Text(
          "Souscription",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer la souscription " +
              souscription.numero_souscription +
              " ?",
          style: TextStyle(
              color: function.convertHexToColor("#79747E"),
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400),
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
                      provider.change_delete(false);
                      Navigator.of(dialocontext).pop();
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
                      backgroundColor: MyColors.secondary),
                  onPressed: delete
                      ? null
                      : () async {
                          provider.change_delete(true);
                          final String statut =
                              await service.DeleteSouscription(
                                  souscription, provider);
                          if (statut == "401") {
                            showCustomSnackBar(
                                dialocontext,
                                "Vous ne pouvez pas supprimer cette souscription",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "500") {
                            showCustomSnackBar(
                                dialocontext,
                                "Une erreur s'est produite. Verifiez votre connection internet et réssayer",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            showCustomSnackBar(
                                dialocontext,
                                "La souscription a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                          }
                        },
                  child: delete
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
                          "Supprimez",
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
}

Future<dynamic> AddSouscription(
    BuildContext context, Marchandises marchandise) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final provider = Provider.of<ApiProvider>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool delete = provider.delete;
      return AlertDialog(
        title: Text(
          "Souscription",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment souscrire pour le transport de marchandises de cette annonce ? ",
          style: TextStyle(
              color: function.convertHexToColor("#79747E"),
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400),
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
                      provider.change_delete(false);
                      Navigator.of(dialocontext).pop();
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
                      backgroundColor: MyColors.secondary),
                  onPressed: delete
                      ? null
                      : () async {
                          provider.change_delete(true);
                          final String statut = await service.AddSouscription(
                              marchandise, provider);
                          if (statut == "401") {
                            showCustomSnackBar(
                                dialocontext,
                                "Vous ne pouvez pas souscrire à cette annonce",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "500") {
                            showCustomSnackBar(
                                dialocontext,
                                "Une erreur s'est produite. Verifiez votre connection internet et réssayer",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            showCustomSnackBar(
                                dialocontext,
                                "La souscription a été enregistrée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                          }
                        },
                  child: delete
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
                          "Confirmez",
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
}
