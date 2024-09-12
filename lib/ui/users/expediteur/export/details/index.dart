// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, prefer_const_literals_to_create_immutables

import 'package:bodah/modals/exports.dart';
import 'package:bodah/providers/users/expediteur/export/home.dart';
import 'package:bodah/ui/users/expediteur/export/list.dart';
import 'package:bodah/ui/users/expediteur/export/route/add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/cargaison.dart';
import '../../../../../modals/chargement_effectues.dart';
import '../../../../../modals/livraison_cargaison.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../../services/data_base_service.dart';
import '../../../../auth/sign_in.dart';
import '../../drawer/index.dart';
import '../../import/details/docs/index.dart';
import '../../import/details/liv/index.dart';
import '../../import/details/march/index.dart';
import '../../import/details/transp/index.dart';
import '../../marchandises/nav_bottom/index.dart';

class DetailExport extends StatelessWidget {
  const DetailExport({super.key, required this.export_id});
  final int export_id;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final provider = Provider.of<ProvHoExport>(context);
    int current_index = provider.current_index;
    final user = api_provider.user;
    List<Exports> exports = api_provider.exports;
    Exports export = function.export(exports, export_id);
    List<Cargaison> cargaisons = api_provider.cargaisons;
    cargaisons = function.data_cargaisons(cargaisons, export_id, "Export");
    List<ChargementEffectue> chargement_effectues =
        api_provider.chargement_effectues;
    chargement_effectues = function.data_chargemnt_effectues(
        chargement_effectues, export_id, "Export");
    List<LivraisonCargaison> livraisons = api_provider.livraisons;
    livraisons = function.data_livraisons(livraisons, export_id, "Export");

    PageController pageController = PageController(initialPage: current_index);
    final pages = [
      ListCargaison(data_id: export.id, data_modele: "Export"),
      ListTransporteur(data_id: export.id, data_modele: "Export"),
      ListLivraisons(data_id: export.id, data_modele: "Export"),
      ListDocuments(data_id: export.id, data_modele: "Export"),
    ];

    return Scaffold(
      backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
      bottomNavigationBar: NavigBot(),
      drawer: DrawerExpediteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Mon exoortation",
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
                    export.reference,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {
                        DeleteExport(context, export);
                      },
                      icon: Icon(
                        Icons.delete,
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
                            "Transporteur",
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
                            "Livraison",
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
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView.builder(
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return pages[current_index];
                },
                controller: pageController,
                onPageChanged: (value) => provider.change_index(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7, left: 7, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            NewTranspExp(context, export.id);
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Icon(
                                  Icons.add,
                                  color: MyColors.secondary,
                                ),
                              ),
                              Text(
                                "Transporteur",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9,
                                    color: MyColors.secondary,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            NewMarchExp(context, export.id);
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Icon(
                                  Icons.add,
                                  color: MyColors.secondary,
                                ),
                              ),
                              Text(
                                "Marchandise",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9,
                                    color: MyColors.secondary,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            NewLivExp(context, export.id);
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Icon(
                                  Icons.add,
                                  color: MyColors.secondary,
                                ),
                              ),
                              Text(
                                "Livraison",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9,
                                    color: MyColors.secondary,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> DeleteExport(BuildContext context, Exports export) {
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
          "Exportation éffectuée",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer l'exportation " +
              export.reference +
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
                              await service.deleteExport(export);
                          if (statut == "500") {
                            showCustomSnackBar(dialocontext,
                                "Echec de suppression", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            await provider.InitImportData();
                            showCustomSnackBar(
                                dialocontext,
                                "L'exportation a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                            Navigator.of(dialocontext).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Align(
                                  alignment: Alignment.topLeft,
                                  child: MesExports(),
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
