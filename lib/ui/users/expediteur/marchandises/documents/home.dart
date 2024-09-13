// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/appeles.dart';
import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/modals/interchanges.dart';
import 'package:bodah/modals/recus.dart';
import 'package:bodah/modals/tdos.dart';
import 'package:bodah/modals/vgms.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/appeles/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/interchanges/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/recus_factures/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/tdos/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/vgms/index.dart';
import 'package:bodah/wrappers/load.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../modals/autre_docs.dart';
import '../../../../../modals/avds.dart';
import '../../../../../modals/bfus.dart';
import '../../../../../modals/bl.dart';
import '../../../../../modals/bordereau_livraisons.dart';
import '../../../../../modals/cartificat_origine.dart';
import '../../../../../modals/certificat_phyto_sanitaire.dart';
import '../../../../../modals/declaration.dart';
import '../../../../../modals/fiche_technique.dart';
import '../../../../../modals/lta.dart';
import '../../../../../modals/ordre_transport.dart';
import '../../../../../providers/api/api_data.dart';
import '../../drawer/index.dart';
import '../nav_bottom/index.dart';
import 'autre_dcos/index.dart';
import 'avds/index.dart';
import 'bfu/index.dart';
import 'bls/index.dart';
import 'bordereaux/index.dart';
import 'cos/index.dart';
import 'cps/index.dart';
import 'declarations/index.dart';
import 'fiches/index.dart';
import 'lta/index.dart';

class MesDocuments extends StatefulWidget {
  const MesDocuments({super.key});

  @override
  State<MesDocuments> createState() => _MesDocumentsState();
}

class _MesDocumentsState extends State<MesDocuments> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    List<BordereauLivraisons> bordereaux = api_provider.bordereaux;
    List<BonCommandes> ordres = api_provider.ordres;
    List<Appeles> appeles = api_provider.appeles;
    List<Interchanges> interchanges = api_provider.interchanges;
    List<Tdos> tdos = api_provider.tdos;
    List<Vgms> vgms = api_provider.vgms;
    List<Recus> recus = api_provider.recus;
    List<AutreDocs> autre_docs = api_provider.autre_docs;
    List<Avd> avds = api_provider.avds;
    List<Bl> bls = api_provider.bls;
    List<Lta> ltas = api_provider.ltas;
    List<Bfu> bfus = api_provider.bfus;
    List<CO> cos = api_provider.cos;
    List<CPS> cps = api_provider.cps;
    List<Declaration> declarations = api_provider.declarations;
    List<FicheTechnique> fiche_techniques = api_provider.fiche_techniques;
    List<OrdreTransport> import_ordres = api_provider.import_ordres;
    bool loading = api_provider.loading;

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
          "Documents",
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
      body: loading
          ? LoadingPage()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: user.dark_mode == 1
                    ? MyColors.secondDark
                    : MyColors.textColor.withOpacity(.4),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Mes documents",
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
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesBordereaux();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/bord.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  bordereaux.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun bordereau",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : bordereaux.length < 2
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                bordereaux.length.toString() +
                                                    " bordereau",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                bordereaux.length.toString() +
                                                    " bordereaux",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              ChooseOrdre(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/ordre.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ordres.isEmpty && import_ordres.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun ordre de transport",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : ordres.length + import_ordres.length < 2
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                (ordres.length +
                                                            import_ordres
                                                                .length)
                                                        .toString() +
                                                    " ordre de transport",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                (ordres.length +
                                                            import_ordres
                                                                .length)
                                                        .toString() +
                                                    " ordres de transport",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesApeles();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/appele.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  appeles.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun appélé",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : appeles.length < 2
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                appeles.length.toString() +
                                                    " appélé",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                appeles.length.toString() +
                                                    " appélés",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesInterchanges();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/inter.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  interchanges.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucune interchange",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : interchanges.length < 2
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                interchanges.length.toString() +
                                                    " interchange",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                interchanges.length.toString() +
                                                    " interchanges",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesTdos();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/tdo.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  tdos.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun TDO",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            tdos.length.toString() + " TDO",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesVgms();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/vgm.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  vgms.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun VGM",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            vgms.length.toString() + " VGM",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesAvds();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/recu.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  avds.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucune AVD",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            avds.length.toString() + " AVD",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesRecus();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/fact.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  recus.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun reçu, facture",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : recus.length < 2
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                recus.length.toString() +
                                                    " reçu, facture",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                recus.length.toString() +
                                                    " reçus, factures",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesBls();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/recu.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  bls.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun BL",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            bls.length.toString() + " BL",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesLtas();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/fact.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ltas.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucune LTA",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            ltas.length.toString() + " LTA",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesBfus();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/recu.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  bfus.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun BFU",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            bfus.length.toString() + " BFU",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesDeclarations();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/fact.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  declarations.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucune déclaration",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : declarations.length < 2
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                declarations.length.toString() +
                                                    " déclaration",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                declarations.length.toString() +
                                                    " déclarations",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesFiches();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/recu.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  fiche_techniques.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucune fiche technique",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : fiche_techniques.length < 2
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                fiche_techniques.length
                                                        .toString() +
                                                    " fiche technique",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                fiche_techniques.length
                                                        .toString() +
                                                    " fiches techniques",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesCos();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/fact.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  cos.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun CO",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            cos.length.toString() + " CO",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesCps();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/recu.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  cps.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun CPS",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            cps.length.toString() + " CPS",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return MesAutreDocs();
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(.70)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          MyColors.textColor.withOpacity(.75),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "images/fact.png",
                                          scale: 2.5,
                                          fit: BoxFit.cover,
                                          height: 20,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  autre_docs.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Aucun autre document",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        )
                                      : autre_docs.length < 2
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                autre_docs.length.toString() +
                                                    " autre document",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                autre_docs.length.toString() +
                                                    " autres documents",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
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
              ),
            ),
    );
  }
}
