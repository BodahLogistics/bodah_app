// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:bodah/modals/annonce_transporteurs.dart';
import 'package:bodah/modals/info_localisation.dart';
import 'package:bodah/modals/marchandise_transporteur.dart';
import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/modals/type_chargements.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/users/transporteur/trajets/add.dart';
import 'package:bodah/ui/users/transporteur/trajets/edit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../modals/camions.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../../expediteur/marchandises/expeditions/detail.dart';
import '../dashboard/trajet.dart';
import '../drawer/index.dart';
import 'add.dart';

class ListTrajets extends StatelessWidget {
  const ListTrajets({super.key});

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final function = Provider.of<Functions>(context);
    Users? user = api_provider.user;

    List<AnnonceTransporteurs> trajets = api_provider.trajets;
    List<MarchandiseTransporteur> marchandies =
        api_provider.marchandise_transporteurs;
    List<InfoLocalisations> localisations = api_provider.info_localisations;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    Transporteurs user_transporteur =
        function.user_transporteur(user, transporteurs);
    List<Camions> camions = api_provider.camions;
    List<Users> users = api_provider.users;
    List<TypeChargements> type_chargements = api_provider.type_chargements;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes = api_provider.all_villes;

    Future<void> refresh() async {
      await api_provider.InitTrajet();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.secondary,
        onPressed: () {
          if (camions.isNotEmpty) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return AddTrajet();
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
          } else {
            AddCamion(context);
          }
        },
        child: Icon(Icons.add, color: MyColors.light),
      ),
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      drawer: DrawerTransporteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Mes trajets",
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
                color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              ))
        ],
      ),
      body: trajets.isEmpty
          ? RefreshIndicator(
              color: MyColors.secondary,
              onRefresh: refresh,
              child: Center(
                  child: Text(
                "Auncun trajet disponible",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: user.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              )),
            )
          : RefreshIndicator(
              color: MyColors.secondary,
              onRefresh: refresh,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      AnnonceTransporteurs trajet = trajets[index];
                      MarchandiseTransporteur marchandise =
                          function.trajet_marchandise(marchandies, trajet);
                      InfoLocalisations localisation =
                          function.trajet_localisation(localisations, trajet);
                      Transporteurs transporteur = function.transporteur(
                          transporteurs, trajet.transporteur_id);
                      Users chauffeur_user =
                          function.user(users, transporteur.user_id);
                      TypeChargements type_chargemet = function.type_chargement(
                          type_chargements, trajet.type_chargement_id);

                      Pays pay_depart =
                          function.pay(pays, localisation.pays_dep_id);
                      Pays pay_dest =
                          function.pay(pays, localisation.pays_dest_id);
                      Villes ville_dep =
                          function.ville(villes, localisation.ville_dep_id);
                      Villes ville_dest =
                          function.ville(villes, localisation.ville_dest_id);
                      Camions camion =
                          function.camion(camions, trajet.vehicule_id);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: TextButton(
                          onPressed: () {
                            showAllFromTrajet(
                                context,
                                trajet,
                                type_chargemet,
                                pay_depart,
                                pay_dest,
                                ville_dep,
                                ville_dest,
                                marchandise.nombre_tonnes);
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
                                          trajet.numero_annonce,
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
                                          type_chargemet.name,
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
                                        "Poids maximal : ",
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
                                          marchandise.nombre_tonnes,
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
                                      Expanded(
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
                                      Expanded(
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Publié le : ",
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
                                          function.date(trajet.created_at),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: trajets.length),
              ),
            ),
    );
  }
}

void showAllFromTrajet(
    BuildContext context,
    AnnonceTransporteurs trajet,
    TypeChargements type_chargement,
    Pays pays_dep,
    Pays pays_dest,
    Villes ville_dep,
    Villes ville_dest,
    String charge) {
  showDialog(
    context: context,
    builder: (BuildContext dialogcontext) {
      return buildAlertDialog(
        context: dialogcontext,
        bottom: MediaQuery.of(dialogcontext).size.height * 0.8,
        message: "Supprimez le trajet",
        backgroundColor: Colors.red,
        textColor: MyColors.light,
        onPressed: () {
          Navigator.of(dialogcontext).pop();
          DeleteTrajet(dialogcontext, trajet);
        },
      );
    },
  );

  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvAddTrajet>(dialogcontext);
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.7,
          message: "Modifiez le trajet",
          backgroundColor: MyColors.secondary,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();
            provider.change_trajet(charge, type_chargement, pays_dep, pays_dest,
                ville_dep, ville_dest);
            Navigator.of(dialogcontext).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return UpdateTrajet(
                    trajet: trajet,
                  );
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

Future<dynamic> DeleteTrajet(
    BuildContext context, AnnonceTransporteurs trajet) {
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
          "Trajet publié",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le trajet " +
              trajet.numero_annonce +
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
                              await service.deleteTrajet(trajet, provider);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Vous ne pouvez pas supprimer cette annonce",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "500") {
                            showCustomSnackBar(
                                dialocontext,
                                "Une erreur s'est produite. Verifiez voytre connection internet et réssayer",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            showCustomSnackBar(
                                dialocontext,
                                "Le trajet a été supprimé avec succès",
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
