// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/providers/users/expediteur/marchandises/annoces/details/home.dart';
import 'package:bodah/services/data_base_service.dart';
import 'package:bodah/ui/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/details/doc/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/details/exp/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/details/march/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/add.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/detail.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/annonces.dart';
import '../../../../../../modals/expeditions.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../modals/users.dart';
import '../../../../auth/sign_in.dart';
import '../expeditions/detail.dart';
import 'list.dart';

class DetailAnnonce extends StatelessWidget {
  const DetailAnnonce({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<Expeditions> expeditions = api_provider.expeditions;
    Users? user = api_provider.user;
    List<Annonces> annonces = api_provider.annonces;
    Annonces annonce = function.annonce(annonces, id);
    List<BonCommandes> ordres = api_provider.ordres;
    BonCommandes ordre = function.annonce_bon_commande(ordres, annonce);
    List<Expeditions> annonce_expeditions =
        function.annonce_expeditions(expeditions, annonce);
    bool cant_delete = function.cant_delete_annonce(annonce_expeditions, ordre);

    final provider = Provider.of<ProvHoAnn>(context);
    int current_index = provider.current_index;
    PageController pageController = PageController(initialPage: current_index);

    final pages = [
      ListMarchs(annonce: annonce),
      ListExp(annonce: annonce),
      MonOrdreTransport(id: ordre.id),
      ListDocAnnonce(annonce: annonce),
    ];

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      drawer: DrawerExpediteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Annonce publiée",
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
                    annonce.numero_annonce,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {
                        showAllFromAnnonce(
                            context, annonce, cant_delete, ordre);
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: MyColors.light,
                      )),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 7, left: 7, top: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: current_index == 0 ? MyColors.secondary : null,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            provider.change_index(0);
                          },
                          child: Text(
                            "Marchandise",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: current_index == 0
                                    ? MyColors.light
                                    : MyColors.secondary,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: current_index == 1 ? MyColors.secondary : null,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            provider.change_index(1);
                          },
                          child: Text(
                            "Chargement",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: current_index == 1
                                    ? MyColors.light
                                    : MyColors.secondary,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: current_index == 2 ? MyColors.secondary : null,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            provider.change_index(2);
                          },
                          child: Text(
                            "Ordre de transport",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: current_index == 2
                                    ? MyColors.light
                                    : MyColors.secondary,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: current_index == 3 ? MyColors.secondary : null,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            provider.change_index(3);
                          },
                          child: Text(
                            "Docs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: current_index == 3
                                    ? MyColors.light
                                    : MyColors.secondary,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: PageView.builder(
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return pages[current_index];
                },
                controller: pageController,
                onPageChanged: (value) => provider.change_index(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showAllFromAnnonce(
  BuildContext context,
  Annonces annonce,
  bool cant_delete,
  BonCommandes ordre,
) {
  if (cant_delete) {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.9,
          message: "Supprimez l'annonce",
          backgroundColor: Colors.red,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();

            DeleteAnnonce(dialogcontext, annonce);
          },
        );
      },
    );
  }

  // Afficher l'alerte "Perte"
  Future.delayed(Duration(milliseconds: 500), () {
    if (ordre.id <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.8,
            message: "Ajoutez l'ordre de transport",
            backgroundColor: MyColors.secondary,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();
              Navigator.of(dialogcontext).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return AddOrdreTransport(
                      annonce: annonce,
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
    }
  });

  if (ordre.is_validated == 0) {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.6,
          message: "Supprimez l'ordre",
          backgroundColor: Colors.red,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();

            DeleteOrdre(dialogcontext, annonce, ordre);
          },
        );
      },
    );
  }

  // Afficher l'alerte "Perte"
  Future.delayed(Duration(milliseconds: 500), () {
    if (ordre.id > 0) {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.5,
            message: "Visualisez l'ordre de transport",
            backgroundColor: MyColors.secondary,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();

              Navigator.of(dialogcontext).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return DetailOrdre(id: ordre.id);
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
    }
  });
}

Future<dynamic> DeleteAnnonce(BuildContext context, Annonces annonce) {
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
          "Annonce publiée",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer l'annonce " +
              annonce.numero_annonce +
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
                              await service.deleteAnnonce(annonce);
                          if (statut == "404" || statut == "403") {
                            showCustomSnackBar(
                                dialocontext,
                                "Vous ne pouvez pas supprimer cette annonce",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "422" || statut == "500") {
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
                            await provider.InitAnnonce();
                            showCustomSnackBar(
                                dialocontext,
                                "L'annonce a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                            Navigator.of(dialocontext).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Align(
                                  alignment: Alignment.topLeft,
                                  child: AnnonceMarchandises(),
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
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

Future<dynamic> DeleteMarchandise(
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
          "Marchandise",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer la marchandise " +
              marchandise.nom +
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
                          fontSize: 10,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 100,
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
                              await service.deleteMarchandise(marchandise);
                          if (statut == "404" ||
                              statut == "401" ||
                              statut == "403") {
                            showCustomSnackBar(
                                dialocontext,
                                "Vous ne pouvez pas supprimer cette marchandise",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "422" || statut == "500") {
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
                            await provider.InitForSomeAnnonce();
                            showCustomSnackBar(
                                dialocontext,
                                "La marchandise a été supprimée avec succès",
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
                              fontSize: 10,
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

Future<dynamic> ValidateOrdre(BuildContext context, BonCommandes ordre) {
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
          "Ordre de transport",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment valider l'ordre de transport " +
              ordre.numero_bon_commande +
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
                      backgroundColor: Colors.green),
                  onPressed: delete
                      ? null
                      : () async {
                          provider.change_delete(true);
                          final String statut =
                              await service.validateOrdre(ordre);
                          if (statut == "404" ||
                              statut == "401" ||
                              statut == "403") {
                            showCustomSnackBar(
                                dialocontext,
                                "Vous ne pouvez pas valider l'ordre de transport",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            await provider.InitForSomeOrdre();
                            showCustomSnackBar(
                                dialocontext,
                                "L'ordre de transport a été validé avec succès",
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
                            width: 20,
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
}

Future<dynamic> DeleteOrdre(
    BuildContext context, Annonces annonce, BonCommandes ordre) {
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
          "Ordre de transport",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer l'ordre de transport " +
              ordre.numero_bon_commande +
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
                          fontSize: 10,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 100,
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
                              await service.deleteOrdre(ordre);
                          if (statut == "404" ||
                              statut == "401" ||
                              statut == "403") {
                            showCustomSnackBar(
                                dialocontext,
                                "Vous ne pouvez pas supprimer l'ordre de transport",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            showCustomSnackBar(
                                dialocontext,
                                "L'ordre de transport a été supprimé avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                            Navigator.of(dialocontext).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        DetailAnnonce(id: annonce.id),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
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
                              fontSize: 10,
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
