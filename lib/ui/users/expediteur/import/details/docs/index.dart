// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:bodah/providers/users/expediteur/import/docs/add.dart';
import 'package:bodah/services/data_base_service.dart';
import 'package:bodah/wrappers/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/appeles.dart';
import '../../../../../../modals/autre_docs.dart';
import '../../../../../../modals/avds.dart';
import '../../../../../../modals/bfus.dart';
import '../../../../../../modals/bl.dart';
import '../../../../../../modals/cartificat_origine.dart';
import '../../../../../../modals/certificat_phyto_sanitaire.dart';
import '../../../../../../modals/declaration.dart';
import '../../../../../../modals/fiche_technique.dart';
import '../../../../../../modals/interchanges.dart';
import '../../../../../../modals/lta.dart';
import '../../../../../../modals/recus.dart';
import '../../../../../../modals/tdos.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/vgms.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../auth/sign_in.dart';
import '../../../marchandises/documents/appeles/index.dart';

class ListDocuments extends StatefulWidget {
  const ListDocuments(
      {super.key, required this.data_id, required this.data_modele});
  final int data_id;
  final String data_modele;

  @override
  State<ListDocuments> createState() => _ListDocumentsState();
}

class _ListDocumentsState extends State<ListDocuments> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);

    Users user = api_provider.user;
    bool loading = api_provider.loading;
    List<Appeles> appeles = api_provider.appeles;
    appeles =
        function.data_appeles(appeles, widget.data_id, widget.data_modele);
    List<Interchanges> interchanges = api_provider.interchanges;
    interchanges = function.data_interchanges(
        interchanges, widget.data_id, widget.data_modele);
    List<Tdos> tdos = api_provider.tdos;
    tdos = function.data_tdos(tdos, widget.data_id, widget.data_modele);
    List<Vgms> vgms = api_provider.vgms;
    vgms = function.data_vgm(vgms, widget.data_id, widget.data_modele);
    List<Recus> recus = api_provider.recus;
    recus = function.data_recus(recus, widget.data_id, widget.data_modele);
    List<AutreDocs> autre_docs = api_provider.autre_docs;
    autre_docs = function.data_autre_docs(
        autre_docs, widget.data_id, widget.data_modele);
    List<Avd> avds = api_provider.avds;
    avds = function.data_avds(avds, widget.data_id, widget.data_modele);
    List<Bl> bls = api_provider.bls;
    bls = function.data_bl(bls, widget.data_id, widget.data_modele);
    List<Lta> ltas = api_provider.ltas;
    ltas = function.data_lta(ltas, widget.data_id, widget.data_modele);
    List<Bfu> bfus = api_provider.bfus;
    bfus = function.data_bfus(bfus, widget.data_id, widget.data_modele);
    List<CO> cos = api_provider.cos;
    cos = function.data_cos(cos, widget.data_id, widget.data_modele);
    List<CPS> cps = api_provider.cps;
    cps = function.data_cps(cps, widget.data_id, widget.data_modele);
    List<Declaration> declarations = api_provider.declarations;
    declarations = function.data_declarations(
        declarations, widget.data_id, widget.data_modele);
    List<FicheTechnique> fiche_techniques = api_provider.fiche_techniques;
    fiche_techniques = function.data_fiches(
        fiche_techniques, widget.data_id, widget.data_modele);

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
                            showInterchanges(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewInter(
                                context, widget.data_id, widget.data_modele);
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
                                              : user.dark_mode == 1
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
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                            showRecus(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewRecu(
                                context, widget.data_id, widget.data_modele);
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
                                              : user.dark_mode == 1
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
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                          if (ltas.isNotEmpty) {
                            showLta(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewLta(context, widget.data_id, widget.data_modele);
                          }
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "LTA",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: ltas.isNotEmpty
                                        ? Colors.green
                                        : user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ltas.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                          if (fiche_techniques.isNotEmpty) {
                            showFiches(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewFiche(
                                context, widget.data_id, widget.data_modele);
                          }
                        },
                        child: Row(
                          children: [
                            fiche_techniques.length < 2
                                ? Flexible(
                                    child: Text(
                                      "Fiche technique",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: fiche_techniques.isNotEmpty
                                              ? Colors.green
                                              : user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Flexible(
                                    child: Text(
                                      "Fiche techniques",
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
                            fiche_techniques.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                          if (tdos.isNotEmpty) {
                            showTdo(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewTdo(context, widget.data_id, widget.data_modele);
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
                                        : user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            tdos.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                        onPressed: () {},
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Ordre de transport",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.green,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Icon(
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
                          if (bfus.isNotEmpty) {
                            showBfu(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewBfu(context, widget.data_id, widget.data_modele);
                          }
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "BFU",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: bfus.isNotEmpty
                                        ? Colors.green
                                        : user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            bfus.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                          if (cos.isNotEmpty) {
                            showCo(context, widget.data_id, widget.data_modele);
                          } else {
                            NewCo(context, widget.data_id, widget.data_modele);
                          }
                        },
                        child: Row(
                          children: [
                            cos.length < 2
                                ? Flexible(
                                    child: Text(
                                      "Certificat d'origine",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: cos.isNotEmpty
                                              ? Colors.green
                                              : user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Flexible(
                                    child: Text(
                                      "Certificat d'origines",
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
                            cos.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                            showVgm(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewVgm(context, widget.data_id, widget.data_modele);
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
                                        : user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            vgms.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                          if (bls.isNotEmpty) {
                            showBl(context, widget.data_id, widget.data_modele);
                          } else {
                            NewBl(context, widget.data_id, widget.data_modele);
                          }
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "BL",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: bls.isNotEmpty
                                        ? Colors.green
                                        : user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            bls.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                          if (avds.isNotEmpty) {
                            showAvd(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewAvd(context, widget.data_id, widget.data_modele);
                          }
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "AVD",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: avds.isNotEmpty
                                        ? Colors.green
                                        : user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            avds.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                          if (cps.isNotEmpty) {
                            showCps(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewCps(context, widget.data_id, widget.data_modele);
                          }
                        },
                        child: Row(
                          children: [
                            cps.length < 2
                                ? Flexible(
                                    child: Text(
                                      "Certificat Phyto-sanitaire",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: cps.isNotEmpty
                                              ? Colors.green
                                              : user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Flexible(
                                    child: Text(
                                      "Certificat phyto-sanitaires",
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
                            cps.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (appeles.isNotEmpty) {
                            showApeles(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewApele(
                                context, widget.data_id, widget.data_modele);
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
                                              : user.dark_mode == 1
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
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                          if (declarations.isNotEmpty) {
                            showDecla(
                                context, widget.data_id, widget.data_modele);
                          } else {
                            NewDecla(
                                context, widget.data_id, widget.data_modele);
                          }
                        },
                        child: Row(
                          children: [
                            declarations.length < 2
                                ? Flexible(
                                    child: Text(
                                      "Déclaration",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: declarations.isNotEmpty
                                              ? Colors.green
                                              : user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Flexible(
                                    child: Text(
                                      "Déclarations",
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
                            declarations.isEmpty
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black,
                                  )
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
                            if (autre_docs.isNotEmpty) {
                              showAutreDoc(
                                  context, widget.data_id, widget.data_modele);
                            } else {
                              NewDoc(
                                  context, widget.data_id, widget.data_modele);
                            }
                          },
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Autre document",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: ltas.isNotEmpty
                                          ? Colors.green
                                          : user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              autre_docs.isEmpty
                                  ? Icon(
                                      Icons.add,
                                      size: 20,
                                      color: user.dark_mode == 1
                                          ? MyColors.light
                                          : MyColors.black,
                                    )
                                  : Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}

/*      Interchanges */
Future<dynamic> showInterchanges(
    BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Interchanges> interchanges = apiProvider.interchanges;
      interchanges = function.data_interchanges(interchanges, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Interchanges",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: interchanges.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun interchange disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: interchanges.map((interchange) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              interchange.doc_id ?? interchange.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(interchange.doc_id ?? "");
                                  UpdateInter(dialogContext, interchange);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteInter(dialogContext, interchange);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          interchange.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewInter(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewInter(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouvelle interchange",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code =
                                    await service.AddImportInterchange(
                                        nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitInterchanges();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateInter(BuildContext context, Interchanges interchange) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Interchange",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code = await service.UpdateInterchange(
                              nom, files, interchange);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour l'interchange",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitInterchanges();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteInter(BuildContext context, Interchanges interchange) {
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
          "Interchange",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer l'interchange" +
              (interchange.doc_id ?? interchange.reference) +
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
                              await service.DeleteInterchange(interchange);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer l'interchange",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitInterchanges();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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

/* End interchage*/

/* Recus */
Future<dynamic> showRecus(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Recus> datas = apiProvider.recus;
      datas = function.data_recus(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Reçus et factures",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun reçu ou facture disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateRecu(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteRecu(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewRecu(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewRecu(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouvel reçu/facture",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code =
                                    await service.AddImportRecu(
                                        nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitRecus();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateRecu(BuildContext context, Recus data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Reçu/facture",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateRecu(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitRecus();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteRecu(BuildContext context, Recus data) {
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
          "Reçu/facture",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteRecu(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitRecus();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End reçu*/

/* Fiche technique */
Future<dynamic> showFiches(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<FicheTechnique> datas = apiProvider.fiche_techniques;
      datas = function.data_fiches(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Fiche technique",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucune fiche technique disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateFiche(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteFiche(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewFiche(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewFiche(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouvelle fiche technique",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code =
                                    await service.AddImportFiche(
                                        nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitFicheTechnique();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateFiche(BuildContext context, FicheTechnique data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Fiche technique",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateFiche(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitFicheTechnique();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteFiche(BuildContext context, FicheTechnique data) {
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
          "Fiche technique",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteFiche(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitFicheTechnique();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End Fiche */

/* Decla  */
Future<dynamic> showDecla(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Declaration> datas = apiProvider.declarations;
      datas = function.data_declarations(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Déclaration",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucune déclaration disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateDecla(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteDecla(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewDecla(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewDecla(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouvelle déclaration",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code =
                                    await service.AddImportDeclaration(
                                        nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitDeclaration();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateDecla(BuildContext context, Declaration data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Déclaration",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateDeclaration(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitDeclaration();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteDecla(BuildContext context, Declaration data) {
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
          "Déclaration",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                              await service.DeleteDeclaration(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitDeclaration();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End decla*/

/* BFU */
Future<dynamic> showBfu(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Bfu> datas = apiProvider.bfus;
      datas = function.data_bfus(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "BFU",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun bfu disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateBfu(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteBfu(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewBfu(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewBfu(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouvel BFU",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportBfu(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitBfu();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateBfu(BuildContext context, Bfu data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "BFU",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateBfu(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitBfu();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteBfu(BuildContext context, Bfu data) {
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
          "BFU",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteBfu(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitBfu();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End bfu */

/*Appeles */
Future<dynamic> showApeles(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Appeles> datas = apiProvider.appeles;
      datas = function.data_appeles(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Appélés",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun appélé disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateApele(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteApele(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewApele(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewApele(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouveau appélé",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code =
                                    await service.AddImportApele(
                                        nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitApeles();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateApele(BuildContext context, Appeles data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Appélé",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateApele(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitApeles();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteApele(BuildContext context, Appeles data) {
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
          "Appélé",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteApele(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitApeles();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End Appélé */

/* Tdo */
Future<dynamic> showTdo(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Tdos> datas = apiProvider.tdos;
      datas = function.data_tdos(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "TDO",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun TDO disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateTdo(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteTdo(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewTdo(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewTdo(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouveau TDO",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportTdo(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitTdos();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateTdo(BuildContext context, Tdos data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "TDO",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateTdo(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitTdos();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteTdo(BuildContext context, Tdos data) {
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
          "TDO",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteTdo(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitTdos();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End TDO */

/* VGM */
Future<dynamic> showVgm(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Vgms> datas = apiProvider.vgms;
      datas = function.data_vgm(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "VGM",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun VGM disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateVgm(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteVgm(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewVgm(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewVgm(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouveau VGM",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportVgm(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitVgms();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateVgm(BuildContext context, Vgms data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "VGM",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateVgm(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitVgms();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteVgm(BuildContext context, Vgms data) {
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
          "VGM",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteVgm(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitVgms();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End VGM */

/*Appeles */
Future<dynamic> showAvd(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Avd> datas = apiProvider.avds;
      datas = function.data_avds(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "AVD",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucune AVD disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateAvd(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteAvd(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewAvd(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewAvd(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Nouvelle AVD",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportAvd(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitAvd();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateAvd(BuildContext context, Avd data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "AVD",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateAvd(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitAvd();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteAvd(BuildContext context, Avd data) {
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
          "AVD",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteAvd(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitAvd();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End AVD */

/* Co */
Future<dynamic> showCo(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<CO> datas = apiProvider.cos;
      datas = function.data_cos(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Certificat d'origine",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun certificat d'origine disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateCo(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteCo(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewCo(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewCo(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Certificat d'origine",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportCo(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitCo();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateCo(BuildContext context, CO data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Certificat d'origine",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateCo(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitCo();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteCo(BuildContext context, CO data) {
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
          "Certificat d'origine",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteCo(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitCo();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End CO */

/* CPS */
Future<dynamic> showCps(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<CPS> datas = apiProvider.cps;
      datas = function.data_cps(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Certificat Phyto-sanitaire",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun certificat phyto-sanitaire disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateCps(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteCps(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewCps(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewCps(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Certificat phyto-sanitaire",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportCps(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitCps();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateCps(BuildContext context, CPS data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Certificat phyto-sanitaire",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateCps(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitCps();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteCps(BuildContext context, CPS data) {
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
          "Certificat phyto-sanitaire",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteCps(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitCps();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End CPS */

/* Autres docs */
Future<dynamic> showAutreDoc(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<AutreDocs> datas = apiProvider.autre_docs;
      datas = function.data_autre_docs(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Autres documents",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun autre document disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.doc_id ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.doc_id ?? "");
                                  UpdateDoc(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteDoc(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url =
                                      "https://test.bodah.bj/storage/" +
                                          data.path;
                                  downloadDocument(context, url);
                                },
                                icon: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewDoc(dialogContext, dataId, modele);
                  },
                  child: Text(
                    "Ajouter",
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

Future<dynamic> NewDoc(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Autre document",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportDoc(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitAutreDocs();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateDoc(BuildContext context, AutreDocs data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Autre document",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateDoc(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitAutreDocs();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteDoc(BuildContext context, AutreDocs data) {
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
          "Autre document",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.doc_id ?? data.reference) +
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
                          final String statut = await service.DeleteDoc(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitAutreDocs();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End Autre docs */

/* BL */
Future<dynamic> showBl(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Bl> datas = apiProvider.bls;
      datas = function.data_bl(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Bill of Loading",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucun BL disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.ref ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.ref ?? "");
                                  UpdateBl(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteBl(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              data.path != null
                                  ? IconButton(
                                      onPressed: () {
                                        String url =
                                            "https://test.bodah.bj/storage/" +
                                                (data.path ?? "");
                                        downloadDocument(context, url);
                                      },
                                      icon: Icon(
                                        Icons.download,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              datas.isNotEmpty
                  ? Container()
                  : SizedBox(
                      width: 100,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: () {
                          NewBl(dialogContext, dataId, modele);
                        },
                        child: Text(
                          "Ajouter",
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

Future<dynamic> NewBl(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Bill of Loading",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportBl(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitBL();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateBl(BuildContext context, Bl data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Bill of Loading",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateBl(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitBL();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteBl(BuildContext context, Bl data) {
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
          "Bill of Loading",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.ref ?? data.reference) +
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
                          final String statut = await service.DeleteBl(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitBL();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End BL */

/* LTA */
Future<dynamic> showLta(BuildContext context, int dataId, String modele) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext, listen: false);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      List<Lta> datas = apiProvider.ltas;
      datas = function.data_lta(datas, dataId, modele);
      double columnWidth = MediaQuery.of(context).size.width / 10;
      Users user = apiProvider.user;
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      return AlertDialog(
        title: Text(
          "Lettre de Transport Aérien",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        content: datas.isEmpty
            ? Center(
                child: Text(
                  "Vous n'avez aucune LTA disponible",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          user.dark_mode == 1 ? MyColors.light : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: columnWidth * 0.9,
                  dataRowHeight: 50,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nom",
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
                    ),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          "Actions",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.dark_mode == 1
                                  ? MyColors.light
                                  : MyColors.black,
                              fontFamily: "Poppins",
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                  rows: datas.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                            child: Text(
                              data.ref ?? data.reference,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.change_doc(data.ref ?? "");
                                  UpdateLta(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: MyColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  DeleteLta(dialogContext, data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              data.path != null
                                  ? IconButton(
                                      onPressed: () {
                                        String url =
                                            "https://test.bodah.bj/storage/" +
                                                (data.path ?? "");
                                        downloadDocument(context, url);
                                      },
                                      icon: Icon(
                                        Icons.download,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        letterSpacing: 1),
                  ),
                ),
              ),
              datas.isNotEmpty
                  ? Container()
                  : SizedBox(
                      width: 100,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: () {
                          NewLta(dialogContext, dataId, modele);
                        },
                        child: Text(
                          "Ajouter",
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

Future<dynamic> NewLta(BuildContext context, int data_id, String modele) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      bool upload = provider.upload;
      bool loading = provider.loading;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Lterre de Transport Aérien",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Faculatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.primary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .takeImageWithCamera(dialogContext);
                              },
                        child: loading
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
                                "Caméra",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: MyColors.secondary),
                        onPressed: affiche
                            ? null
                            : () async {
                                await provider
                                    .selectImagesFromGallery(dialogContext);
                              },
                        child: upload
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
                                "Galérie",
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
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Fermez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);

                                String statut_code = await service.AddImportLta(
                                    nom, files, data_id, modele);

                                if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Une erreur est survenue",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  await apiProvider.InitLta();
                                  provider.reset();
                                  showCustomSnackBar(
                                      dialogContext,
                                      "Le document a été ajouté avec succès",
                                      Colors.green);
                                  Navigator.of(dialogContext).pop();
                                }
                              },
                        child: affiche
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
                                "Ajoutez",
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

Future<dynamic> UpdateLta(BuildContext context, Lta data) {
  TextEditingController Name = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddDoc>(dialogContext);
      final service = Provider.of<DBServices>(dialogContext);
      Users user = apiProvider.user;
      bool affiche = provider.affiche;
      String nom = provider.nom;
      List<File> files = provider.files_selected;

      if (Name.text.isEmpty && nom.isNotEmpty) {
        Name.text = nom;
      }

      return AlertDialog(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Lettre de Transport Aérien",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom du document (Facultatif)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              TextField(
                controller: Name,
                onChanged: (value) => provider.change_nom(value),
                decoration: InputDecoration(
                    suffixIcon: Name.text.isNotEmpty && (nom.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Name.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (nom.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: "Nom (Facultatif)",
                    labelStyle: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: MyColors.black)),
              ),
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImagesFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      provider.reset();
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);

                          String statut_code =
                              await service.UpdateLta(nom, files, data);

                          if (statut_code == "404") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Impossible de mettre à jour le document",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialogContext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialogContext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "200") {
                            await apiProvider.InitLta();
                            provider.reset();
                            showCustomSnackBar(
                                dialogContext,
                                "Le document a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: affiche
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
                          "Modifiez",
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

Future<dynamic> DeleteLta(BuildContext context, Lta data) {
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
          "Lettre de Transport Aérien",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le document" +
              (data.ref ?? data.reference) +
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
                          final String statut = await service.DeleteLta(data);
                          if (statut == "404") {
                            showCustomSnackBar(
                                dialocontext,
                                "Impossible de supprimer le document",
                                Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else if (statut == "200") {
                            await provider.InitLta();
                            showCustomSnackBar(
                                dialocontext,
                                "Le document a été supprimée avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
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
/* End LTA */