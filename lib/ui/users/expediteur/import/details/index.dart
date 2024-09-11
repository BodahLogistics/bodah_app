// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, prefer_const_literals_to_create_immutables

import 'package:bodah/providers/users/expediteur/import/home.dart';
import 'package:bodah/ui/users/expediteur/import/details/docs/index.dart';
import 'package:bodah/ui/users/expediteur/import/details/liv/index.dart';
import 'package:bodah/ui/users/expediteur/import/details/march/index.dart';
import 'package:bodah/ui/users/expediteur/import/details/transp/index.dart';
import 'package:bodah/ui/users/expediteur/import/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/cargaison.dart';
import '../../../../../modals/chargement_effectues.dart';
import '../../../../../modals/import.dart';
import '../../../../../modals/livraison_cargaison.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../../services/data_base_service.dart';
import '../../../../auth/sign_in.dart';
import '../../drawer/index.dart';
import '../../marchandises/nav_bottom/index.dart';
import '../route/add.dart';

class DetailImport extends StatelessWidget {
  const DetailImport({super.key, required this.import_id});
  final int import_id;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final provider = Provider.of<ProvHoImport>(context);
    int current_index = provider.current_index;
    final user = api_provider.user;
    List<Import> imports = api_provider.imports;
    Import import = function.import(imports, import_id);
    List<Cargaison> cargaisons = api_provider.cargaisons;
    cargaisons = function.data_cargaisons(cargaisons, import_id, "Import");
    List<ChargementEffectue> chargement_effectues =
        api_provider.chargement_effectues;
    chargement_effectues = function.data_chargemnt_effectues(
        chargement_effectues, import_id, "Import");
    List<LivraisonCargaison> livraisons = api_provider.livraisons;
    livraisons = function.data_livraisons(livraisons, import_id, "Import");

    PageController pageController = PageController(initialPage: current_index);
    final pages = [
      ListCargaison(data_id: import.id, data_modele: "Import"),
      ListTransporteur(data_id: import.id, data_modele: "Import"),
      ListLivraisons(data_id: import.id, data_modele: "Import"),
      ListDocuments(data_id: import.id, data_modele: "Import"),
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
          "Mon importation",
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
                    import.reference,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {
                        DeleteImport(context, import);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: MyColors.light,
                      )),
                  IconButton(
                      onPressed: () {},
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
                            NewTransp(context, import.id);
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
                            NewMarch(context, import.id);
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
                            NewLiv(context, import.id);
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

Future<dynamic> DeleteImport(BuildContext context, Import import) {
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
          "Importation éffectuée",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer l'importation " +
              import.reference +
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
                              await service.deleteImport(import);
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
                                "L'importation a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                            Navigator.of(dialocontext).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Align(
                                  alignment: Alignment.topLeft,
                                  child: MesImports(),
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
