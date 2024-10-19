// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_adjacent_string_concatenation

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/bfus.dart';
import 'package:bodah/modals/exports.dart';
import 'package:bodah/ui/users/expediteur/export/details/index.dart';
import 'package:bodah/ui/users/expediteur/import/details/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/cargaison.dart';
import '../../../../../../modals/cargaison_client.dart';
import '../../../../../../modals/chargement.dart';
import '../../../../../../modals/import.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/positions.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../drawer/index.dart';
import '../../annonces/detail.dart';
import '../../nav_bottom/index.dart';

class MesBfus extends StatelessWidget {
  const MesBfus({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Bfu> datas = api_provider.bfus;
    List<Annonces> annonces = api_provider.annonces;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<Import> imports = api_provider.imports;
    List<Exports> exports = api_provider.exports;
    List<Cargaison> cargaison = api_provider.cargaisons;
    List<CargaisonClient> cargaison_client = api_provider.cargaison_clients;
    List<Chargement> chargements = api_provider.chargements;
    List<Positions> positions = api_provider.positions;
    Future<void> refresh() async {
      await api_provider.InitBfu();
    }

    return Scaffold(
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
          "Bordereau de Frais Unique (BFU)",
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
      body: datas.isEmpty
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      Bfu data = datas[index];

                      if (data.modele_type.contains("Annonce")) {
                        Annonces annonce =
                            function.annonce(annonces, data.modele_id);

                        Marchandises marchandise = function
                            .annonce_marchandises(marchandises, annonce.id)
                            .first;
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
                                    return DetailAnnonce(
                                      id: data.modele_id,
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
                                  color: Colors.grey.withOpacity(.2),
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
                                          "Nom/Référence : ",
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
                                            data.doc_id ?? data.reference,
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
                                      height: 10,
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
                                      height: 10,
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
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date : ",
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
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      child: SizedBox(
                                        height: 25,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              /*  String url =
                                                  "https://test.bodah.bj/storage/" +
                                                      data.path;
                                              downloadDocument(context, url);*/
                                            },
                                            child: Text(
                                              "Téléchargez",
                                              style: TextStyle(
                                                  color: MyColors.light,
                                                  fontSize: 10,
                                                  fontFamily: "Poppins"),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        List<Cargaison> cargaisons = [];
                        if (data.modele_type.contains("Import")) {
                          Import import =
                              function.import(imports, data.modele_id);
                          cargaisons = function.data_cargaisons(
                              cargaison, import.id, "Import");
                        } else {
                          Exports export =
                              function.export(exports, data.modele_id);
                          cargaisons = function.data_cargaisons(
                              cargaison, export.id, "Export");
                        }

                        if (cargaisons.isEmpty) {
                          cargaisons = [
                            Cargaison(
                              id: 0,
                              reference: "",
                              modele_type: "",
                              modele_id: 0,
                              nom: "",
                            )
                          ];
                        }

                        List<CargaisonClient> cargaison_clients =
                            function.cargaison_cargaison_clients(
                                cargaisons.first, cargaison_client);
                        if (cargaison_clients.isEmpty) {
                          cargaison_clients = [
                            CargaisonClient(
                              id: 0,
                              client_id: 0,
                              cargaison_id: 0,
                              quantite: 0,
                            )
                          ];
                        }
                        Chargement chargement =
                            function.cargaison_client_chargement(
                                chargements, cargaison_clients.first);

                        if (cargaison_clients.isEmpty) {
                          cargaison_clients = [
                            CargaisonClient(
                              id: 0,
                              client_id: 0,
                              cargaison_id: 0,
                              quantite: 0,
                            )
                          ];
                        }

                        Positions position = function.cargaison_client_position(
                            positions, cargaison_clients.first);

                        Pays pay_depart =
                            function.pay(pays, position.pay_dep_id);
                        Pays pay_dest = function.pay(pays, position.pay_liv_id);
                        Villes ville_dep =
                            function.ville(all_villes, position.city_dep_id);
                        Villes ville_dest =
                            function.ville(all_villes, position.city_liv_id);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: TextButton(
                            onPressed: () {
                              if (data.modele_type.contains("Import")) {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return DetailImport(
                                        import_id: data.modele_id,
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
                              } else {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return DetailExport(
                                        export_id: data.modele_id,
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
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.2),
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
                                          "Nom/Référence : ",
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
                                            data.doc_id ?? data.reference,
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
                                      height: 10,
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
                                        position.address_dep?.isEmpty ?? true
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
                                                  (position.address_dep ?? "") +
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
                                      height: 10,
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
                                        position.address_liv?.isEmpty ?? true
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
                                                  position.address_liv ??
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
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date : ",
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
                                            function.date(chargement.debut),
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
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      child: SizedBox(
                                        height: 25,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              /* String url =
                                                  "https://test.bodah.bj/storage/" +
                                                      data.path;
                                              downloadDocument(context, url);*/
                                            },
                                            child: Text(
                                              "Téléchargez",
                                              style: TextStyle(
                                                  color: MyColors.light,
                                                  fontSize: 10,
                                                  fontFamily: "Poppins"),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    itemCount: datas.length,
                  ),
                ),
              ),
            ),
    );
  }
}
