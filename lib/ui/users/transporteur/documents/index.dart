// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/appeles.dart';
import 'package:bodah/modals/interchanges.dart';
import 'package:bodah/modals/letrre_voyage.dart';
import 'package:bodah/modals/recus.dart';
import 'package:bodah/modals/tdos.dart';
import 'package:bodah/modals/vgms.dart';
import 'package:bodah/ui/users/transporteur/documents/appeles/index.dart';
import 'package:bodah/ui/users/transporteur/documents/bordereaux/index.dart';
import 'package:bodah/ui/users/transporteur/documents/interchanges/index.dart';
import 'package:bodah/ui/users/transporteur/documents/recus/index.dart';
import 'package:bodah/ui/users/transporteur/documents/tdo/index.dart';
import 'package:bodah/ui/users/transporteur/drawer/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../modals/bordereau_livraisons.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../documents/contrats/index.dart';
import '../documents/vgm/index.dart';

class DocumentChargements extends StatelessWidget {
  const DocumentChargements({super.key});

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<BordereauLivraisons> bordereaux = api_provider.bordereaux;
    List<LetreVoitures> contrats = api_provider.contrats;
    List<Appeles> appeles = api_provider.appeles;
    List<Interchanges> interchanges = api_provider.interchanges;
    List<Tdos> tdos = api_provider.tdos;
    List<Vgms> vgms = api_provider.vgms;
    List<Recus> recus = api_provider.recus;

    Future<void> refresh() async {
      await api_provider.InitTransporteursDocuments();
    }

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      drawer: DrawerTransporteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Mes documents",
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
      body: RefreshIndicator(
        color: MyColors.secondary,
        onRefresh: refresh,
        child: SingleChildScrollView(
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
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ChargBordereaux();
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
                                  color: MyColors.textColor.withOpacity(.75),
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
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ChargContrats();
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
                                  color: MyColors.textColor.withOpacity(.75),
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
                              contrats.isEmpty
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Aucune letre de voiture",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11),
                                      ),
                                    )
                                  : contrats.length < 2
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            (contrats.length).toString() +
                                                " Letre de voiture",
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
                                            (contrats.length).toString() +
                                                " Letres de voiture",
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
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ChargAppeles();
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
                                  color: MyColors.textColor.withOpacity(.75),
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
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ChargInterchanges();
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
                                  color: MyColors.textColor.withOpacity(.75),
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
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ChargTdo();
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
                                  color: MyColors.textColor.withOpacity(.75),
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
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ChargVgm();
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
                                  color: MyColors.textColor.withOpacity(.75),
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
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ChargRecus();
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
                                  color: MyColors.textColor.withOpacity(.75),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
