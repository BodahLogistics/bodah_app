// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/transport_liaison.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/users/transporteur/chauffeurs/add.dart';
import 'package:bodah/ui/users/transporteur/chauffeur/add.dart';
import 'package:bodah/ui/users/transporteur/chauffeur/detail.dart';
import 'package:bodah/ui/users/transporteur/chauffeur/edit.dart';
import 'package:bodah/wrappers/load.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../modals/pieces.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../../expediteur/marchandises/expeditions/detail.dart';
import '../drawer/index.dart';

class MesChauffeurs extends StatelessWidget {
  const MesChauffeurs({super.key});

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final function = Provider.of<Functions>(context);
    Users? user = api_provider.user;
    bool loading = api_provider.loading;
    List<TransportLiaisons> chauffeurs = api_provider.chauffeurs;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    List<Users> users = api_provider.users;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes = api_provider.all_villes;
    List<Pieces> pieces = api_provider.pieces;

    return loading
        ? LoadingPage()
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: loading ? MyColors.primary : MyColors.secondary,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return AddChauffeur();
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
                "Mes chauffeurs",
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
            body: chauffeurs.isEmpty
                ? Center(
                    child: Text(
                    "Auncun chauffeur n'est ajouté",
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
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          TransportLiaisons chauffeur = chauffeurs[index];
                          Transporteurs transporteur = function.transporteur(
                              transporteurs, chauffeur.transporteur_id);
                          Users chauffeur_user =
                              function.user(users, transporteur.user_id);
                          Pays pay =
                              function.pay(pays, chauffeur_user.country_id);
                          Villes ville = function.ville(
                              villes, chauffeur_user.city_id ?? 0);
                          Pieces piece = function.data_piece(
                              pieces, transporteur.id, "Transporteur");

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
                                      return DetailsChauffeur(
                                          chauffeur: chauffeur);
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
                                    color: function.is_pair(index)
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
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      transporteur.photo_url != null
                                          ? SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircleAvatar(
                                                radius:
                                                    40, // Ajuster la taille du cercle
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                  "https://test.bodah.bj/storage/${transporteur.photo_url}",
                                                ),
                                                backgroundColor: Colors.grey[
                                                    200], // Optionnel, couleur de fond si l'image n'est pas encore chargée
                                              ),
                                            )
                                          : Image.asset(
                                              "images/avatar.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              chauffeur_user.name,
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
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                pay.id == 0
                                                    ? Container()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 10),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              "https://test.bodah.bj/countries/${pay.flag}",
                                                          fit: BoxFit.cover,
                                                          height: 13,
                                                          width: 20,
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress,
                                                            color: MyColors
                                                                .secondary,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(),
                                                        ),
                                                      ),
                                                Expanded(
                                                  child: Text(
                                                    ville.name +
                                                        " , " +
                                                        pay.name,
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
                                            )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showAllFromChauffeur(
                                                context,
                                                chauffeur,
                                                chauffeur_user,
                                                transporteur,
                                                piece,
                                                pay,
                                                ville);
                                          },
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.green,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: chauffeurs.length),
                  ),
          );
  }
}

void showAllFromChauffeur(
    BuildContext context,
    TransportLiaisons chauffeur,
    Users user,
    Transporteurs transporteur,
    Pieces piece,
    Pays pay,
    Villes ville) {
  // Premier dialogue
  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.8,
          message:
              chauffeur.during == 1 ? "Chauffeur Actif" : "Chauffeur Non actif",
          backgroundColor:
              chauffeur.during == 1 ? Colors.green : Colors.redAccent,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();
          },
        );
      },
    );
  }).then((_) {
    Future.delayed(Duration(milliseconds: 500), () {
      // Deuxième dialogue

      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.74,
            message: "Supprimez le chauffeur",
            backgroundColor: Colors.red,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();
              DeleteChauffeur(dialogcontext, chauffeur, user);
            },
          );
        },
      );
    });
  }).then((_) {
    // Troisième dialogue
    Future.delayed(Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.67,
            message: chauffeur.during == 1
                ? "Suspendre le chauffeur"
                : "Remettre le chauffeur",
            backgroundColor:
                chauffeur.during == 1 ? Colors.redAccent : Colors.green,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();
              if (chauffeur.during == 1) {
                DisableChauffeur(dialogcontext, chauffeur, user);
              } else {
                ActiveChauffeur(dialogcontext, chauffeur, user);
              }
            },
          );
        },
      );
    });
  }).then((_) {
    // Quatrième dialogue
    Future.delayed(Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          final provider = Provider.of<ProvAddChauffeur>(dialogcontext);
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.6,
            message: "Modifiez les informations",
            backgroundColor: MyColors.secondary,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();
              provider.change_chauffeur(user, piece, pay, ville);
              Navigator.of(dialogcontext).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return UpdateChauffeur(
                      transporteur: transporteur,
                    );
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
          );
        },
      );
    });
  });
}

// Fonction de suppression
Future<dynamic> DeleteChauffeur(
    BuildContext context, TransportLiaisons chauffeur, Users user) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final provider = Provider.of<ApiProvider>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool delete = provider.delete;
      return AlertDialog(
        title: Text(
          "Mon chauffeur",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le chauffeur " + user.name + " ?",
          style: TextStyle(
              color: MyColors.textColor,
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
                          fontSize: 8),
                    )),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      backgroundColor: MyColors.secondary),
                  onPressed: delete
                      ? null
                      : () async {
                          provider.change_delete(true);
                          final String statut = await service.deleteChauffeur(
                              chauffeur, provider);

                          if (statut == "500") {
                            showCustomSnackBar(
                                dialocontext,
                                "Une erreur inattendu s'est produite. Vérifiez vos données mobiles",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(
                                dialocontext,
                                "Veuillez réessayer plus tardr",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer ce chauffeur",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            showCustomSnackBar(
                                dialocontext,
                                "Le chauffeur a été supprimé avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                          }
                        },
                  child: delete
                      ? CircularProgressIndicator(
                          color: MyColors.light,
                        )
                      : Text(
                          "Supprimez",
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

// Fonction de suppression
Future<dynamic> ActiveChauffeur(
    BuildContext context, TransportLiaisons chauffeur, Users user) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final provider = Provider.of<ApiProvider>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool delete = provider.delete;
      return AlertDialog(
        title: Text(
          "Mon chauffeur",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment remettre le chauffeur " + user.name + " ?",
          style: TextStyle(
              color: MyColors.textColor,
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
                          fontSize: 8),
                    )),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      backgroundColor: MyColors.secondary),
                  onPressed: delete
                      ? null
                      : () async {
                          provider.change_delete(true);
                          final String statut = await service.activeChauffeur(
                              chauffeur, provider);
                          if (statut == "500") {
                            showCustomSnackBar(
                                dialocontext,
                                "Une erreur inattendu s'est produite. Vérifiez vos données mobiles",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(
                                dialocontext,
                                "Veuillez réessayer plus tardr",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Ce chauffeur est déjà supprimé",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            showCustomSnackBar(
                                dialocontext,
                                "Le chauffeur a été remis avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                          }
                        },
                  child: delete
                      ? CircularProgressIndicator(
                          color: MyColors.light,
                        )
                      : Text(
                          "Remettez",
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

// Fonction de suppression
Future<dynamic> DisableChauffeur(
    BuildContext context, TransportLiaisons chauffeur, Users user) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final provider = Provider.of<ApiProvider>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool delete = provider.delete;
      return AlertDialog(
        title: Text(
          "Mon chauffeur",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment suspendre le chauffeur " + user.name + " ?",
          style: TextStyle(
              color: MyColors.textColor,
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
                          fontSize: 8),
                    )),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      backgroundColor: MyColors.secondary),
                  onPressed: delete
                      ? null
                      : () async {
                          provider.change_delete(true);
                          final String statut = await service.disableChauffeur(
                              chauffeur, provider);
                          if (statut == "500") {
                            showCustomSnackBar(
                                dialocontext,
                                "Une erreur inattendu s'est produite. Vérifiez vos données mobiles",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(
                                dialocontext,
                                "Veuillez réessayer plus tardr",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Ce chauffeur est déjà supprimé",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            showCustomSnackBar(
                                dialocontext,
                                "Le chauffeur a été suspendu avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                          }
                        },
                  child: delete
                      ? CircularProgressIndicator(
                          color: MyColors.light,
                        )
                      : Text(
                          "Suspendez",
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
