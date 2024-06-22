// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/modals/expeditions.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../modals/annonce_photos.dart';
import '../../../../modals/localisations.dart';
import '../../../../modals/marchandises.dart';
import '../../../../modals/pays.dart';
import '../../../../modals/unites.dart';
import '../../../../modals/villes.dart';
import '../../../../providers/api/api_data.dart';

class HomeMarchExp extends StatefulWidget {
  const HomeMarchExp({super.key});

  @override
  State<HomeMarchExp> createState() => _HomeMarchExpState();
}

class _HomeMarchExpState extends State<HomeMarchExp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitAnnonce();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    List<Annonces> annonces = api_provider.annonces;
    List<Expeditions> expeditions = api_provider.expeditions;
    List<BordereauLivraisons> bordereaux = api_provider.bordereaux;
    bool loading = api_provider.loading;
    List<AnnoncePhotos> annonce_photos = api_provider.photos;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Unites> unites = api_provider.unites;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;

    return loading
        ? Center(
            child: CircularProgressIndicator(
              color: MyColors.secondary,
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: user.dark_mode == 1
                                ? MyColors.textColor
                                : function
                                    .convertHexToColor("#00000040")
                                    .withOpacity(.10)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.local_shipping,
                                      color: MyColors.secondary,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Text(
                                  function
                                      .formatAmount(annonces.length.toDouble()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.secondary,
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: MyColors.secondary,
                                        width: 5,
                                        height: 10,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Annonces d'expédition",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: MyColors.secondary,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.secondary.withOpacity(.10)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      FontAwesomeIcons.desktop,
                                      color: MyColors.primary,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                Text(
                                  function.formatAmount(
                                      expeditions.length.toDouble()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.primary,
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: MyColors.primary,
                                        width: 5,
                                        height: 10,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Expéditions",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: MyColors.primary,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.primary),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      FontAwesomeIcons.userCheck,
                                      color: MyColors.primary,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                Text(
                                  function.formatAmount(
                                      expeditions.length.toDouble()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.light,
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: Colors.green,
                                        width: 5,
                                        height: 10,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Suivi d'expédition",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.secondary),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      FontAwesomeIcons.box,
                                      color: MyColors.secondary,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                Text(
                                  function.formatAmount(
                                      bordereaux.length.toDouble()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.light,
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: MyColors.secondary,
                                        width: 5,
                                        height: 10,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Bordereaux de livraisons",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                annonces.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mes annonces",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 1,
                                childAspectRatio: 2,
                                children: annonces.map((annonce) {
                                  Marchandises marchandise = function
                                      .annonce_marchandises(
                                          marchandises, annonce.id)
                                      .first;
                                  Localisations localisation =
                                      function.marchandise_localisation(
                                          localisations, marchandise.id);
                                  List<AnnoncePhotos> pictures =
                                      function.annonce_pictures(annonce,
                                          marchandises, annonce_photos);
                                  Unites unite = function.unite(
                                      unites, marchandise.unite_id);
                                  Pays pay_depart = function.pay(
                                      pays, localisation.pays_exp_id);
                                  Pays pay_dest = function.pay(
                                      pays, localisation.pays_liv_id);
                                  Villes ville_dep = function.ville(
                                      all_villes, localisation.city_exp_id);
                                  Villes ville_dest = function.ville(
                                      all_villes, localisation.city_liv_id);

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            transitionDuration:
                                                Duration(milliseconds: 500),
                                            pageBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secondaryAnimation) {
                                              return DetailAnnonce(
                                                id: annonce.id,
                                              );
                                            },
                                            transitionsBuilder:
                                                (BuildContext context,
                                                    Animation<double> animation,
                                                    Animation<double>
                                                        secondaryAnimation,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.textColor,
                                                width: 1,
                                                style: BorderStyle.solid)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 5,
                                              top: 5),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: pictures.isEmpty
                                                    ? Container()
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: pictures
                                                              .last.image_path,
                                                          fit: BoxFit.cover,
                                                          height: 120,
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
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          marchandise.nom,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 35),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Poids : ",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  user.dark_mode ==
                                                                          1
                                                                      ? MyColors
                                                                          .light
                                                                      : MyColors
                                                                          .primary,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 10),
                                                        ),
                                                        Text(
                                                          "${marchandise.poids} ${unite.name}",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  user.dark_mode ==
                                                                          1
                                                                      ? MyColors
                                                                          .light
                                                                      : MyColors
                                                                          .textColor,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "${pay_depart.name.toUpperCase()}, ${ville_dep.name}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black,
                                                                fontFamily:
                                                                    "Poppins",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "- ${pay_dest.name.toUpperCase()}, ${ville_dest.name}",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color:
                                                                  user.dark_mode ==
                                                                          1
                                                                      ? MyColors
                                                                          .light
                                                                      : MyColors
                                                                          .black,
                                                              fontFamily:
                                                                  "Poppins",
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          );
  }
}
