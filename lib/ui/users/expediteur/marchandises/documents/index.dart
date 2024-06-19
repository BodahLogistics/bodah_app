// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/appeles.dart';
import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/modals/interchanges.dart';
import 'package:bodah/modals/recus.dart';
import 'package:bodah/modals/tdos.dart';
import 'package:bodah/modals/vgms.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/appeles/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/interchanges/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/recus_factures/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/bordereau_livraisons.dart';
import '../../../../../providers/api/api_data.dart';
import 'bordereaux/index.dart';

class DashBoardDocExp extends StatefulWidget {
  const DashBoardDocExp({super.key});

  @override
  State<DashBoardDocExp> createState() => _DashBoardDocExpState();
}

class _DashBoardDocExpState extends State<DashBoardDocExp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    List<BordereauLivraisons> bordereaux = api_provider.bordereaux;
    List<BonCommandes> ordres = api_provider.ordres;
    List<Appeles> appeles = api_provider.appeles;
    List<Interchanges> interchanges = api_provider.interchanges;
    List<Tdos> tdos = api_provider.tdos;
    List<Vgms> vgms = api_provider.vgms;
    List<Recus> recus = api_provider.recus;
    bool loading = api_provider.loading;

    return loading
        ? Center(
            child: CircularProgressIndicator(
              color: MyColors.secondary,
            ),
          )
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                    color: MyColors.textColor.withOpacity(.75),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "images/bord.png",
                                        scale: 2.5,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Bordereaux de livraisons",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.secondary,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    function.formatAmount(
                                            bordereaux.length.toDouble()) +
                                        " bordereaux",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
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
                      TextButton(
                        onPressed: () {},
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                    color: MyColors.textColor.withOpacity(.75),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "images/ordre.png",
                                        scale: 2.5,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Ordres de transport",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.secondary,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    function.formatAmount(
                                            ordres.length.toDouble()) +
                                        " Ordres",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                    color: MyColors.textColor.withOpacity(.75),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "images/appele.png",
                                        scale: 2.5,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Appélés",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.primary,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    function.formatAmount(
                                            appeles.length.toDouble()) +
                                        " Appélés",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                    color: MyColors.textColor.withOpacity(.75),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "images/inter.png",
                                        scale: 2.5,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Interchanges",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.primary,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    function.formatAmount(
                                            interchanges.length.toDouble()) +
                                        " Interchanges",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
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
                      TextButton(
                        onPressed: () {},
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                    color: MyColors.textColor.withOpacity(.75),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "images/tdo.png",
                                        scale: 2.5,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "TDO",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.secondary,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    function.formatAmount(
                                            tdos.length.toDouble()) +
                                        " TDO",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
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
                      TextButton(
                        onPressed: () {},
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                    color: MyColors.textColor.withOpacity(.75),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "images/vgm.png",
                                        scale: 2.5,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "VGM",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.secondary,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    function.formatAmount(
                                            vgms.length.toDouble()) +
                                        " VGM",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                    color: MyColors.textColor.withOpacity(.75),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "images/recu.png",
                                        scale: 2.5,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Reçus",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.primary,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    function.formatAmount(
                                            recus.length.toDouble()) +
                                        " Reçus",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                    color: MyColors.textColor.withOpacity(.75),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "images/fact.png",
                                        scale: 2.5,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Factures",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: MyColors.primary,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    function.formatAmount(
                                            recus.length.toDouble()) +
                                        " Factures",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
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
                    height: 40,
                  ),
                ],
              ),
            ),
          );
  }
}
