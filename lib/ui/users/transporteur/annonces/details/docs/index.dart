// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/wrappers/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../colors/color.dart';
import '../../../../../../../functions/function.dart';
import '../../../../../../../modals/appeles.dart';
import '../../../../../../../modals/expeditions.dart';
import '../../../../../../../modals/interchanges.dart';
import '../../../../../../../modals/recus.dart';
import '../../../../../../../modals/tdos.dart';
import '../../../../../../../modals/users.dart';
import '../../../../../../../modals/vgms.dart';
import '../../../../../../../providers/api/api_data.dart';
import '../../../../expediteur/import/details/docs/index.dart';

class DocsChargement extends StatelessWidget {
  const DocsChargement({super.key, required this.annonce});
  final Annonces annonce;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    bool loading = api_provider.loading;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    List<Expeditions> expeditions = api_provider.expeditions;
    expeditions = function.annonce_expeditions(expeditions, annonce);
    expeditions = function.mesTransports(transporteurs, expeditions);
    List<Appeles> appeles = api_provider.appeles;
    appeles = function.expedition_appeles(appeles, expeditions);
    List<Interchanges> interchanges = api_provider.interchanges;
    interchanges = function.expedition_interchanges(interchanges, expeditions);
    List<Tdos> tdos = api_provider.tdos;
    tdos = function.expedition_tdo(tdos, expeditions);
    List<Vgms> vgms = api_provider.vgms;
    vgms = function.expedition_vgm(vgms, expeditions);
    List<Recus> recus = api_provider.recus;
    recus = function.expedition_recus(recus, expeditions);

    return loading
        ? Loading()
        : Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (interchanges.isNotEmpty) {
                            showInterchanges(context, annonce.id, "Expedition",
                                interchanges);
                          }
                        },
                        child: Row(
                          children: [
                            interchanges.length < 2
                                ? Flexible(
                                    child: Text(
                                      "Interchange",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: interchanges.isNotEmpty
                                              ? Colors.green
                                              : user!.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Flexible(
                                    child: Text(
                                      "Interchanges",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.green,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                            interchanges.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (recus.isNotEmpty) {
                            showRecus(context, annonce.id, "Annonce", recus);
                          }
                        },
                        child: Row(
                          children: [
                            recus.length < 2
                                ? Flexible(
                                    child: Text(
                                      "Reçu et facture",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: recus.isNotEmpty
                                              ? Colors.green
                                              : user!.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Flexible(
                                    child: Text(
                                      "Reçu et factures",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.green,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                            recus.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (tdos.isNotEmpty) {
                            showTdo(context, annonce.id, "Annonce", tdos);
                          }
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "TDO",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: tdos.isNotEmpty
                                        ? Colors.green
                                        : user!.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            tdos.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (vgms.isNotEmpty) {
                            showVgm(context, annonce.id, "Annonce", vgms);
                          }
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "VGM",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: vgms.isNotEmpty
                                        ? Colors.green
                                        : user!.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            vgms.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (appeles.isNotEmpty) {
                            showApeles(context, annonce.id, "Annonce", appeles);
                          }
                        },
                        child: Row(
                          children: [
                            appeles.length < 2
                                ? Flexible(
                                    child: Text(
                                      "Appélé",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: appeles.isNotEmpty
                                              ? Colors.green
                                              : user!.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Flexible(
                                    child: Text(
                                      "Appélés",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.green,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                            appeles.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
  }
}
