// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:bodah/modals/annonce_transporteurs.dart';
import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/transport_liaison.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/modals/type_chargements.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/users/transporteur/trajets/add.dart';
import 'package:bodah/ui/users/transporteur/chauffeur/add.dart';
import 'package:bodah/ui/users/transporteur/trajets/edit.dart';
import 'package:bodah/wrappers/load.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../../expediteur/marchandises/expeditions/detail.dart';
import '../drawer/index.dart';

class MesChauffeurs extends StatefulWidget {
  const MesChauffeurs({super.key});

  @override
  State<MesChauffeurs> createState() => _MesChauffeursState();
}

class _MesChauffeursState extends State<MesChauffeurs> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitChauffeurs();
  }

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

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: TextButton(
                              onPressed: () {},
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
                                        MainAxisAlignment.spaceAround,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
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
                                      )
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
                              await service.deleteTrajet(trajet);
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
                            await provider.InitTrajet();
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
