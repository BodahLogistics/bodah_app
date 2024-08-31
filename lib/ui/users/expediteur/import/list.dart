// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/cargaison_client.dart';
import 'package:bodah/modals/transport_mode.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/detail.dart';
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
import '../drawer/index.dart';
import '../marchandises/nav_bottom/index.dart';

class MesImports extends StatelessWidget {
  const MesImports({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
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
          "Importations" + transport_modes.length.toString(),
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
              child: CircularProgressIndicator(
                color: MyColors.secondary,
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Import import = imports[index];
                    List<Cargaison> cargaisons =
                        function.import_cargaisons(cargaison, import);
                    List<CargaisonClient> cargaison_clients =
                        function.cargaison_cargaison_clients(
                            cargaisons.first, cargaison_client);
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
                                  id: import.id,
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
                                          fontSize: 10),
                                    ),
                                    Text(
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
                                          fontSize: 10),
                                    ),
                                    Text(
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
                                          fontSize: 10),
                                    ),
                                    position.address_dep!.isEmpty
                                        ? Text(
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
                                          )
                                        : Text(
                                            position.address_dep ??
                                                "" +
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
                                          fontSize: 10),
                                    ),
                                    position.address_liv!.isEmpty
                                        ? Text(
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
                                          )
                                        : Text(
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
                                          fontSize: 10),
                                    ),
                                    Text(
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
      final function = Provider.of<Functions>(dialocontext);
      final apiProvider = Provider.of<ApiProvider>(dialocontext);
      List<TransportMode> transport_modes = apiProvider.transport_modes;

      return AlertDialog(
        title: Text(
          "Mode de transport",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: ListView.separated(
            itemBuilder: (context, index) {
              TransportMode mode = transport_modes[index];
              return ListTile(
                title: Text(
                  mode.nom,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                trailing: Icon(Icons.track_changes),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: transport_modes.length),
      );
    },
  );
}
