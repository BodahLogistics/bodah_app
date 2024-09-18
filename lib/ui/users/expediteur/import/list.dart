// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:bodah/modals/cargaison_client.dart';
import 'package:bodah/modals/transport_mode.dart';
import 'package:bodah/ui/users/expediteur/import/aerien/add.dart';
import 'package:bodah/ui/users/expediteur/import/details/index.dart';
import 'package:bodah/ui/users/expediteur/import/maritime/add.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/pays.dart';
import '../../../../../modals/villes.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../modals/cargaison.dart';
import '../../../../modals/chargement.dart';
import '../../../../modals/import.dart';
import '../../../../modals/positions.dart';
import '../../../../modals/users.dart';
import '../drawer/index.dart';
import '../marchandises/nav_bottom/index.dart';
import 'route/add.dart';

class MesImports extends StatelessWidget {
  const MesImports({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Import> imports = api_provider.imports;
    List<Cargaison> cargaison = api_provider.cargaisons;
    List<CargaisonClient> cargaison_client = api_provider.cargaison_clients;
    List<Chargement> chargements = api_provider.chargements;
    List<Position> positions = api_provider.positions;
    List<TransportMode> transport_modes = api_provider.transport_modes;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.secondary,
        onPressed: () {
          ChooseMode(context);
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
          "Importations",
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
      body: imports.isEmpty
          ? Center(
              child: Text(
              "Vous n'avez encore pas ajouté d'importations",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: user.dark_mode == 1 ? MyColors.light : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ))
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Import import = imports[index];
                    List<Cargaison> cargaisons = function.data_cargaisons(
                        cargaison, import.id, 'Import');
                    if (cargaisons.isEmpty) {
                      cargaisons = [
                        Cargaison(
                            id: 0,
                            reference: "",
                            modele_type: "",
                            modele_id: 0,
                            nom: "",
                            deleted: 0)
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
                            deleted: 0)
                      ];
                    }
                    Chargement chargement =
                        function.cargaison_client_chargement(
                            chargements, cargaison_clients.first);

                    Position position = function.cargaison_client_position(
                        positions, cargaison_clients.first);

                    Pays pay_depart = function.pay(pays, position.pay_dep_id);
                    Pays pay_dest = function.pay(pays, position.pay_liv_id);
                    Villes ville_dep =
                        function.ville(all_villes, position.city_dep_id);
                    Villes ville_dest =
                        function.ville(all_villes, position.city_liv_id);
                    TransportMode mode = function.transport_mode(
                        transport_modes, import.transport_mode_id);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return DetailImport(
                                  import_id: import.id,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mode de transport : ",
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
                                        mode.nom,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Référence : ",
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
                                        import.reference,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
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
                                              overflow: TextOverflow.ellipsis,
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
                                              overflow: TextOverflow.ellipsis,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
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
                                              overflow: TextOverflow.ellipsis,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: imports.length),
            ),
    );
  }
}

Future<dynamic> ChooseMode(BuildContext context) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext dialocontext) {
      final apiProvider = Provider.of<ApiProvider>(dialocontext);
      List<TransportMode> transport_modes = apiProvider.transport_modes;

      return AlertDialog(
          title: Container(
            decoration: BoxDecoration(
                color: MyColors.secondary,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Mode de transport",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: MyColors.light,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          ),
          content: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height *
                    0.6), // Limiter la hauteur du dialog
            child: ListView.builder(
              shrinkWrap: true, // Ajuste la taille du ListView à son contenu
              itemBuilder: (context, index) {
                TransportMode mode = transport_modes[index];
                return TextButton(
                  onPressed: () {
                    Navigator.of(dialocontext).pop();

                    if (mode.id == 1) {
                      Navigator.of(dialocontext).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return NewImportRoute();
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
                    } else if (mode.id == 2) {
                      Navigator.of(dialocontext).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return NewImportMaritime();
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
                      Navigator.of(dialocontext).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return NewImportAerien();
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mode.nom,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                            mode.id == 1
                                ? Icon(
                                    Icons.local_shipping,
                                    size: 20,
                                    color: Colors.black.withOpacity(.5),
                                  )
                                : mode.id == 2
                                    ? Icon(
                                        Icons.sailing,
                                        size: 20,
                                        color: Colors.black.withOpacity(.5),
                                      )
                                    : Icon(
                                        Icons.flight,
                                        size: 20,
                                        color: Colors.black.withOpacity(.5),
                                      )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: transport_modes.length,
            ),
          ));
    },
  );
}
