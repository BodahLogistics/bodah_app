// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'package:bodah/providers/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/dashboard/index.dart';
import 'package:bodah/ui/users/expediteur/export/list.dart';
import 'package:bodah/ui/users/expediteur/import/list.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/list.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/home.dart';
import 'package:bodah/ui/users/expediteur/marchandises/expeditions/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../modals/rules.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../../settings/index.dart';
import '../marchandises/dashboard/index.dart';

class DrawerExpediteur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    final provider = Provider.of<ProvDrawExpediteur>(context);
    int current_index = provider.current_index;
    final service = Provider.of<DBServices>(context);
    Rules? rule = api_provider.rule;

    return Drawer(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(45))),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: user.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  rule!.nom,
                  style: TextStyle(
                    color: MyColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListTile(
              onTap: () {
                provider.change_index(2);
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return DashMarchExp();
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
              leading: Icon(
                FontAwesomeIcons.truck,
                color: current_index == 2
                    ? Colors.white
                    : user.dark_mode == 1
                        ? MyColors.light
                        : null,
              ),
              tileColor: current_index == 2 ? MyColors.secondary : null,
              title: Text(
                "Envoi de marchandise",
                style: TextStyle(
                    fontSize: 12,
                    color: current_index == 2
                        ? Colors.white
                        : user.dark_mode == 1
                            ? MyColors.light
                            : function.convertHexToColor("#222523"),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(1);
            },
            leading: Icon(
              FontAwesomeIcons.box,
              color: current_index == 1
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 1 ? MyColors.secondary : null,
            title: Text(
              "Envoi de colis",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 1
                      ? Colors.white
                      : user.dark_mode == 1
                          ? MyColors.light
                          : function.convertHexToColor("#222523"),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
              onTap: () {
                provider.change_index(0);
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ExpediteurDashBoard(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              leading: Icon(
                Icons.dashboard,
                color: current_index == 0
                    ? Colors.white
                    : user.dark_mode == 1
                        ? MyColors.light
                        : null,
              ),
              tileColor: current_index == 0 ? MyColors.secondary : null,
              title: Text(
                "Accueil",
                style: TextStyle(
                    fontSize: 12,
                    color: current_index == 0
                        ? Colors.white
                        : user.dark_mode == 1
                            ? MyColors.light
                            : function.convertHexToColor("#222523"),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(3);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return AnnonceMarchandises();
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
            leading: Icon(
              FontAwesomeIcons.truck,
              color: current_index == 3
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 3 ? MyColors.secondary : null,
            title: Text(
              "Mes annonces",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 3
                      ? Colors.white
                      : user.dark_mode == 1
                          ? MyColors.light
                          : function.convertHexToColor("#222523"),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(11);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return MesExpeditions();
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
            leading: Icon(
              Icons.check_circle_outline,
              color: current_index == 11
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 11 ? MyColors.secondary : null,
            title: Text(
              "Mes expéditions",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 11
                      ? Colors.white
                      : user.dark_mode == 1
                          ? MyColors.light
                          : function.convertHexToColor("#222523"),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(4);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return MesImports();
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
            leading: Icon(
              Icons.local_shipping,
              color: current_index == 4
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 4 ? MyColors.secondary : null,
            title: Text(
              "Mes importations",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 4
                      ? Colors.white
                      : user.dark_mode == 1
                          ? MyColors.light
                          : function.convertHexToColor("#222523"),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(5);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return MesExports();
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
            leading: Icon(
              Icons.directions_boat,
              color: current_index == 5
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 5 ? MyColors.secondary : null,
            title: Text(
              "Mes exportations",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 5
                      ? Colors.white
                      : user.dark_mode == 1
                          ? MyColors.light
                          : function.convertHexToColor("#222523"),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(6);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return MesDocuments();
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
            leading: Icon(
              Icons.receipt,
              color: current_index == 6
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 6 ? MyColors.secondary : null,
            title: Text(
              "Mes documents",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 6
                      ? Colors.white
                      : user.dark_mode == 1
                          ? MyColors.light
                          : function.convertHexToColor("#222523"),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(7);
            },
            leading: Icon(
              Icons.share,
              color: current_index == 7
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 7 ? MyColors.secondary : null,
            title: Text(
              "Partagez",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 7
                      ? Colors.white
                      : user.dark_mode == 1
                          ? MyColors.light
                          : function.convertHexToColor("#222523"),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
              trailing: IconButton(
                  onPressed: () async {
                    String statut_code = await service.darkMode(api_provider);
                    if (statut_code == "202") {
                      showCustomSnackBar(context, "Une erreur s'est produite",
                          Colors.redAccent);
                    } else if (statut_code == "500") {
                      showCustomSnackBar(
                          context,
                          "Vérifiez votre connection  internet",
                          Colors.redAccent);
                    } else {
                      showCustomSnackBar(
                          context, "Effectué avec succès", Colors.green);
                    }
                  },
                  icon: user.dark_mode == 1
                      ? Icon(
                          Icons.toggle_on,
                          color: MyColors.secondary,
                        )
                      : Icon(
                          Icons.toggle_off,
                          color: user.dark_mode == 1 ? MyColors.light : null,
                        )),
              leading: Icon(
                Icons.brightness_6,
                color: user.dark_mode == 1 ? MyColors.light : null,
              ),
              title: Text(
                "Mode sombre",
                style: TextStyle(
                    fontSize: 12,
                    color: user.dark_mode == 1
                        ? MyColors.light
                        : function.convertHexToColor("#222523"),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(8);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return MySettings();
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
            leading: Icon(
              Icons.settings,
              color: current_index == 8
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 8 ? MyColors.secondary : null,
            title: Text(
              "Paramètres",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 8
                      ? Colors.white
                      : user.dark_mode == 1
                          ? MyColors.light
                          : function.convertHexToColor("#222523"),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
            onTap: () {
              provider.change_index(9);
              logOut(context);
            },
            leading: Icon(
              Icons.logout,
              color: current_index == 9 ? Colors.white : Colors.red,
            ),
            tileColor: current_index == 9 ? MyColors.secondary : null,
            title: Text(
              "Déconnexion",
              style: TextStyle(
                  fontSize: 12,
                  color: current_index == 9 ? Colors.white : Colors.red,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

void logOut(BuildContext context) {
  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        final apiProvider = Provider.of<ApiProvider>(dialogContext);
        final user = apiProvider.user;
        final service = Provider.of<DBServices>(dialogContext);
        bool delete = apiProvider.delete;

        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Text(
            "Déconnexion",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Voulez-vous vraiment vous déconnecter ?",
            style: TextStyle(
              fontSize: 12,
              color: user.dark_mode == 1 ? MyColors.light : MyColors.textColor,
              fontWeight: FontWeight.w500,
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
                          padding: EdgeInsets.only(left: 7, right: 7),
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        apiProvider.change_delete(false);
                        Navigator.of(dialogContext).pop();
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
                        backgroundColor: Colors.green),
                    onPressed: delete
                        ? null
                        : () async {
                            apiProvider.change_delete(true);
                            String statut = await service.logout();
                            if (statut == "202") {
                              showCustomSnackBar(
                                  dialogContext,
                                  "Une erreur s'est produite",
                                  Colors.redAccent);
                              apiProvider.change_delete(false);
                            } else if (statut == "500") {
                              showCustomSnackBar(
                                  dialogContext,
                                  "Vérifiez votre connection  internet",
                                  Colors.redAccent);
                            } else {
                              showCustomSnackBar(
                                  dialogContext,
                                  "Vous avez été déconnecté avec succès",
                                  Colors.green);
                              apiProvider.change_delete(false);
                              Navigator.of(dialogContext).pop();

                              Navigator.of(dialogContext).pushAndRemoveUntil(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return SignIn();
                                  },
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                      Widget child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                                ModalRoute.withName("/login"),
                              );
                            }
                          },
                    child: delete
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: MyColors.light,
                              ),
                            ),
                          )
                        : Text(
                            "Confirmez",
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
  });
}
