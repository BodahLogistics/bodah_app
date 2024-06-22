// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/localisations.dart';
import 'package:bodah/modals/marchandises.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/ui/users/expediteur/marchandises/expeditions/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/expeditions.dart';
import '../../../../../modals/pays.dart';
import '../../../../../providers/api/api_data.dart';

class ListExpExp extends StatefulWidget {
  const ListExpExp({super.key});

  @override
  State<ListExpExp> createState() => _ListExpExpState();
}

class _ListExpExpState extends State<ListExpExp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitExpedition();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    bool loading = api_provider.loading;
    List<Expeditions> expeditions = api_provider.expeditions;
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
        : expeditions.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: MyColors.secondary,
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: expeditions.length,
                  itemBuilder: (context, index) {
                    Expeditions expedition = expeditions[index];
                    Marchandises marchandise = function.marchandise(
                        marchandises, expedition.marchandise_id);
                    Localisations localisation =
                        function.marchandise_localisation(
                            localisations, marchandise.id);
                    List<AnnoncePhotos> pictures = function.marchandise_photos(
                        annonce_photos, marchandise.id);
                    Unites unite = function.unite(unites, marchandise.unite_id);
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
                                return DetailExpedition(
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
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 5),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: pictures.isEmpty
                                      ? Container()
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: CachedNetworkImage(
                                            imageUrl: pictures.last.image_path,
                                            fit: BoxFit.cover,
                                            height: 120,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              color: MyColors.secondary,
                                            ),
                                            errorWidget:
                                                (context, url, error) => Icon(
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
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          marchandise.nom,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 35),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Poids : ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.primary,
                                                fontFamily: "Poppins",
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "${marchandise.poids} ${unite.name}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${pay_depart.name.toUpperCase()}, ${ville_dep.name}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "- ${pay_dest.name.toUpperCase()}, ${ville_dest.name}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.black,
                                                fontFamily: "Poppins",
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
                  },
                ),
              );
  }
}
