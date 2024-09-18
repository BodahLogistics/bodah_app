// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/add.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/detail.dart';
import 'package:bodah/wrappers/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../colors/color.dart';
import '../../../../../../../functions/function.dart';
import '../../../../../../../modals/appeles.dart';
import '../../../../../../../modals/autre_docs.dart';
import '../../../../../../../modals/avds.dart';
import '../../../../../../../modals/bfus.dart';
import '../../../../../../../modals/bl.dart';
import '../../../../../../../modals/bon_commandes.dart';
import '../../../../../../../modals/cartificat_origine.dart';
import '../../../../../../../modals/certificat_phyto_sanitaire.dart';
import '../../../../../../../modals/declaration.dart';
import '../../../../../../../modals/expeditions.dart';
import '../../../../../../../modals/fiche_technique.dart';
import '../../../../../../../modals/interchanges.dart';
import '../../../../../../../modals/lta.dart';
import '../../../../../../../modals/recus.dart';
import '../../../../../../../modals/tdos.dart';
import '../../../../../../../modals/users.dart';
import '../../../../../../../modals/vgms.dart';
import '../../../../../../../providers/api/api_data.dart';
import '../../../../import/details/docs/index.dart';

class ListDocAnnonce extends StatefulWidget {
  const ListDocAnnonce({super.key, required this.annonce});
  final Annonces annonce;

  @override
  State<ListDocAnnonce> createState() => _ListDocAnnonceState();
}

class _ListDocAnnonceState extends State<ListDocAnnonce> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    bool loading = api_provider.loading;
    List<Expeditions> expeditions = api_provider.expeditions;
    expeditions = function.annonce_expeditions(expeditions, widget.annonce);
    List<Appeles> appeles = api_provider.appeles;
    appeles = function.expedition_appeles(appeles, expeditions);
    List<Interchanges> interchanges = api_provider.interchanges;
    interchanges = function.expedition_interchanges(interchanges, expeditions);
    List<Tdos> tdos = api_provider.tdos;
    tdos = function.expedition_tdo(tdos, expeditions);
    List<Vgms> vgms = api_provider.vgms;
    vgms = function.expedition_vgm(vgms, expeditions);
    List<Recus> recus = api_provider.recus;
    recus = function.annonce_recus(widget.annonce, expeditions, recus);
    List<AutreDocs> autre_docs = api_provider.autre_docs;
    autre_docs =
        function.data_autre_docs(autre_docs, widget.annonce.id, "Annonce");
    List<Avd> avds = api_provider.avds;
    avds = function.data_avds(avds, widget.annonce.id, "Annonce");
    List<Bl> bls = api_provider.bls;
    bls = function.data_bl(bls, widget.annonce.id, "Annonce");
    List<Lta> ltas = api_provider.ltas;
    ltas = function.data_lta(ltas, widget.annonce.id, "Annonce");
    List<Bfu> bfus = api_provider.bfus;
    bfus = function.data_bfus(bfus, widget.annonce.id, "Annonce");
    List<CO> cos = api_provider.cos;
    cos = function.data_cos(cos, widget.annonce.id, "Annonce");
    List<CPS> cps = api_provider.cps;
    cps = function.data_cps(cps, widget.annonce.id, "Annonce");
    List<Declaration> declarations = api_provider.declarations;
    declarations =
        function.data_declarations(declarations, widget.annonce.id, "Annonce");
    List<FicheTechnique> fiche_techniques = api_provider.fiche_techniques;
    fiche_techniques =
        function.data_fiches(fiche_techniques, widget.annonce.id, "Annonce");
    List<BonCommandes> ordres = api_provider.ordres;
    BonCommandes ordre = function.annonce_bon_commande(ordres, widget.annonce);

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
                            showInterchanges(context, widget.annonce.id,
                                "Expedition", interchanges);
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
                            showRecus(
                                context, widget.annonce.id, "Annonce", recus);
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
                          if (ltas.isNotEmpty) {
                            showLta(context, widget.annonce.id, "Annonce");
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
                                        : user!.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ltas.isEmpty
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
                          if (fiche_techniques.isNotEmpty) {
                            showFiches(context, widget.annonce.id, "Annonce");
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
                                              : user!.dark_mode == 1
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
                          if (tdos.isNotEmpty) {
                            showTdo(
                                context, widget.annonce.id, "Annonce", tdos);
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (ordre.id > 0) {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return DetailOrdre(
                                    id: ordre.id,
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
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return AddOrdreTransport(
                                    annonce: widget.annonce,
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
                                    color: ordre.id > 0
                                        ? Colors.green
                                        : user!.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ordre.id == 0
                                ? Icon(
                                    Icons.add,
                                    size: 20,
                                    color: user!.dark_mode == 1
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
                          if (bfus.isNotEmpty) {
                            showBfu(context, widget.annonce.id, "Annonce");
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
                                        : user!.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            bfus.isEmpty
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
                          if (cos.isNotEmpty) {
                            showCo(context, widget.annonce.id, "Annonce");
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
                                              : user!.dark_mode == 1
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
                            showVgm(
                                context, widget.annonce.id, "Annonce", vgms);
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
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (bls.isNotEmpty) {
                            showBl(context, widget.annonce.id, "Annonce");
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
                                        : user!.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            bls.isEmpty
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
                          if (avds.isNotEmpty) {
                            showAvd(context, widget.annonce.id, "Annonce");
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
                                        : user!.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            avds.isEmpty
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
                          if (cps.isNotEmpty) {
                            showCps(context, widget.annonce.id, "Annonce");
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
                                              : user!.dark_mode == 1
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
                                context, widget.annonce.id, "Annonce", appeles);
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (declarations.isNotEmpty) {
                            showDecla(context, widget.annonce.id, "Annonce");
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
                                              : user!.dark_mode == 1
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
                            if (autre_docs.isNotEmpty) {
                              showAutreDoc(
                                  context, widget.annonce.id, "Annonce");
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
                                          : user!.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              autre_docs.isEmpty
                                  ? Container()
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
