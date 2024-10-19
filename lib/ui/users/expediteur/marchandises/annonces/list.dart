// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/detail.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/annonce_photos.dart';
import '../../../../../modals/localisations.dart';
import '../../../../../modals/marchandises.dart';
import '../../../../../modals/pays.dart';
import '../../../../../modals/users.dart';
import '../../../../../modals/villes.dart';
import '../../../../../providers/api/api_data.dart';
import '../../drawer/index.dart';
import '../nav_bottom/index.dart';

class AnnonceMarchandises extends StatelessWidget {
  const AnnonceMarchandises({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Annonces> annonces = api_provider.annonces;
    List<AnnoncePhotos> annonce_photos = api_provider.photos;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<Tarifications> tarifications = api_provider.tarifications;

    Future<void> refresh() async {
      await api_provider.InitAnnonce();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.secondary,
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return NewAnnonce();
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
      bottomNavigationBar: NavigBot(),
      drawer: DrawerExpediteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Mes annonces",
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
      body: annonces.isEmpty
          ? RefreshIndicator(
              color: MyColors.secondary,
              onRefresh: refresh,
              child: SingleChildScrollView(
                physics:
                    AlwaysScrollableScrollPhysics(), // Permet toujours le défilement
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      .8, // Prend toute la hauteur de l'écran
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), // Ajoute un peu de padding
                      child: Text(
                        "Aucune donnée disponible",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: user.dark_mode == 1
                              ? MyColors.light
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
          : RefreshIndicator(
              color: MyColors.secondary,
              onRefresh: refresh,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      Annonces annonce = annonces[index];
                      Marchandises marchandise = function
                          .annonce_marchandises(marchandises, annonce.id)
                          .first;
                      Tarifications tarification =
                          function.marchandise_tarification(
                              tarifications, marchandise.id);
                      Localisations localisation =
                          function.marchandise_localisation(
                              localisations, marchandise.id);
                      List<AnnoncePhotos> pictures = function.annonce_pictures(
                          annonce, marchandises, annonce_photos);

                      Pays pay_depart =
                          function.pay(pays, localisation.pays_exp_id);
                      Pays pay_dest =
                          function.pay(pays, localisation.pays_liv_id);
                      Villes ville_dep =
                          function.ville(all_villes, localisation.city_exp_id);
                      Villes ville_dest =
                          function.ville(all_villes, localisation.city_liv_id);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return DetailAnnonce(
                                    id: annonce.id,
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
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.textColor,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5, top: 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: pictures.isEmpty
                                            ? Container()
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      pictures.last.image_path,
                                                  fit: BoxFit.cover,
                                                  height: 80,
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
                                                          Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  marchandise.nom,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: user.dark_mode == 1
                                                        ? MyColors.light
                                                        : MyColors.black,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "${marchandise.poids}  / " +
                                                  function.formatAmount(
                                                      tarification
                                                          .prix_expedition) +
                                                  "XOF",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 11),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              function.date(
                                                  marchandise.date_chargement),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.textColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Row(
                                      children: [
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
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${ville_dep.name}, ${pay_depart.name.toUpperCase()} ->",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.black,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                          ),
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
                                        Expanded(
                                          child: Text(
                                            "${ville_dest.name}, ${pay_dest.name.toUpperCase()}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.black,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                        ),
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
                    itemCount: annonces.length),
              ),
            ),
    );
  }
}
