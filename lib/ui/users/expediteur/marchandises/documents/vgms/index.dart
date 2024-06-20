// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/vgms.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/vgms/detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/expeditions.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../drawer/index.dart';
import '../../nav_bottom/index.dart';

class MesVgms extends StatefulWidget {
  const MesVgms({super.key});

  @override
  State<MesVgms> createState() => _MesVgmsState();
}

class _MesVgmsState extends State<MesVgms> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitInterchanges();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<Expeditions> expeditions = api_provider.expeditions;
    final user = api_provider.user;
    List<Vgms> vgms = api_provider.vgms;
    bool loading = api_provider.loading;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;

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
          "Mes VGM",
          style: TextStyle(
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.bold,
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
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.secondary,
              ),
            )
          : vgms.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: MyColors.secondary,
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Vgms vgm = vgms[index];
                        Expeditions expedition =
                            function.expedition(expeditions, vgm.expedition_id);
                        Marchandises marchandise = function.marchandise(
                            marchandises, expedition.marchandise_id);
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
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: user.dark_mode == 0
                                    ? MyColors.textColor.withOpacity(.5)
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.textColor,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        return DetailVgm(
                                          id: vgm.id,
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
                                leading: Icon(Icons.file_present,
                                    size: 50,
                                    color: user.dark_mode == 1
                                        ? MyColors.secondary
                                        : function.convertHexToColor(
                                            function.couleurs[
                                                function.randomInt(
                                                    function.couleurs.length)],
                                          )),
                                title: Text(
                                  vgm.reference + " " + marchandise.nom,
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
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: user.dark_mode == 1
                                          ? MyColors.light
                                          : null,
                                    )),
                                subtitle: Column(
                                  children: [
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              function
                                                  .date(expedition.date_depart),
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
                                            "- " +
                                                function.date(
                                                    expedition.date_arrivee),
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
                            ),
                          ),
                        );
                      },
                      itemCount: vgms.length,
                    ),
                  ),
                ),
    );
  }
}
