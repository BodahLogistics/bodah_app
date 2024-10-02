// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/annonce_transporteurs.dart';
import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/modals/expeditions.dart';
import 'package:bodah/modals/letrre_voyage.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../modals/annonce_photos.dart';
import '../../../../modals/localisations.dart';
import '../../../../modals/marchandises.dart';
import '../../../../modals/pays.dart';
import '../../../../modals/users.dart';
import '../../../../modals/villes.dart';
import '../../../../providers/api/api_data.dart';
import '../annonces/details/index.dart';

class HomeTransporteur extends StatelessWidget {
  const HomeTransporteur({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Annonces> annonces = api_provider.annonces;
    List<Expeditions> expeditions = api_provider.expeditions;
    List<AnnonceTransporteurs> trajets = api_provider.trajets;
    List<BordereauLivraisons> bordereaux = api_provider.bordereaux;
    List<LetreVoitures> contrats = api_provider.contrats;
    List<AnnoncePhotos> annonce_photos = api_provider.photos;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<Tarifications> tarifications = api_provider.tarifications;

    return SingleChildScrollView(
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
                      color: user!.dark_mode == 1
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                Icons.check_circle_outline,
                                color: MyColors.secondary,
                                size: 30,
                              ),
                            ),
                          ),
                          Text(
                            expeditions.length.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MyColors.secondary,
                              fontSize: 14,
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
                          "Mes Transports",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: MyColors.secondary,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 11),
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
                                Icons.receipt,
                                color: MyColors.primary,
                                size: 25,
                              ),
                            ),
                          ),
                          Text(
                            bordereaux.length.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MyColors.primary,
                              fontSize: 14,
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
                          "Bordereaux de livraison",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: MyColors.primary,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 11),
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
                                Icons.receipt,
                                color: MyColors.primary,
                                size: 25,
                              ),
                            ),
                          ),
                          Text(
                            contrats.length.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MyColors.light,
                              fontSize: 14,
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
                          "Lettres de voiture",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: MyColors.light,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 11),
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
                                Icons.route,
                                color: MyColors.secondary,
                                size: 25,
                              ),
                            ),
                          ),
                          Text(
                            trajets.length.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MyColors.light,
                              fontSize: 14,
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
                          "Mes Trajets",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: MyColors.light,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 11),
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
                          "Offres d'expédition disponible",
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
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: SizedBox(
                        height: function.calculateHeight(
                          annonces.length,
                          1, // Le nombre de colonnes est maintenant 1
                          1.15,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              annonces
                                  .length, // On génère une ligne par élément
                              (index) {
                                Annonces annonce = annonces[index];
                                Marchandises marchandise = function
                                    .annonce_marchandises(
                                        marchandises, annonce.id)
                                    .first;
                                Tarifications tarification =
                                    function.marchandise_tarification(
                                        tarifications, marchandise.id);
                                Localisations localisation =
                                    function.marchandise_localisation(
                                        localisations, marchandise.id);
                                List<AnnoncePhotos> pictures =
                                    function.annonce_pictures(
                                        annonce, marchandises, annonce_photos);

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
                                            return DetailsMarchandises(
                                                id: annonce.id);
                                          },
                                          transitionsBuilder:
                                              (BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
                                                  Widget child) {
                                            return ScaleTransition(
                                              scale: Tween<double>(
                                                      begin: 0.0, end: 1.0)
                                                  .animate(animation),
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
                                        child: Column(
                                          children: [
                                            Row(
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
                                                                  .circular(
                                                                      20.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: pictures
                                                                .last
                                                                .image_path,
                                                            fit: BoxFit.cover,
                                                            height: 80,
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
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(),
                                                          ),
                                                        ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8),
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            marchandise.nom,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 12,
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
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "${marchandise.poids}  / " +
                                                            tarification
                                                                .prix_transport,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .textColor,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 11),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        function.date(marchandise
                                                            .date_chargement),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .textColor,
                                                            fontFamily:
                                                                "Poppins",
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
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child:
                                                              CachedNetworkImage(
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
                                                                  downloadProgress
                                                                      .progress,
                                                              color: MyColors
                                                                  .secondary,
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(),
                                                          ),
                                                        ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${ville_dep.name}, ${pay_depart.name.toUpperCase()} ->",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontFamily: "Poppins",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  pay_dest.id == 0
                                                      ? Container()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child:
                                                              CachedNetworkImage(
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
                                                                  downloadProgress
                                                                      .progress,
                                                              color: MyColors
                                                                  .secondary,
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(),
                                                          ),
                                                        ),
                                                  Expanded(
                                                    child: Text(
                                                      "${ville_dest.name}, ${pay_dest.name.toUpperCase()}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: user.dark_mode ==
                                                                1
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
                            ),
                          ),
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
