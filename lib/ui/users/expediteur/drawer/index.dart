// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'package:bodah/providers/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/dashboard/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/list.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../marchandises/dashboard/index.dart';

class DrawerExpediteur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    final provider = Provider.of<ProvDrawExpediteur>(context);
    int current_index = provider.current_index;
    final service = Provider.of<DBServices>(context);

    return Drawer(
      backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
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
                  "Bodah",
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
              provider.change_index(4);
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
              color: current_index == 4
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 4 ? MyColors.secondary : null,
            title: Text(
              "Mes documents",
              style: TextStyle(
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
            },
            leading: Icon(
              Icons.share,
              color: current_index == 5
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 5 ? MyColors.secondary : null,
            title: Text(
              "Partagez",
              style: TextStyle(
                  color: current_index == 5
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
                    String statut_code = await service.darkMode();
                    if (statut_code == "202") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Une erreur s'est produite",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (statut_code == "500") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Vérifiez votre connection  internet",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      await api_provider.InitUser();
                      final snackBar = SnackBar(
                        backgroundColor: MyColors.secondary,
                        content: Text(
                          "Effectué avec succès",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              provider.change_index(6);
            },
            leading: Icon(
              Icons.settings,
              color: current_index == 6
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 6 ? MyColors.secondary : null,
            title: Text(
              "Paramètres",
              style: TextStyle(
                  color: current_index == 6
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
              provider.change_index(7);
              logOut(context);
            },
            leading: Icon(
              Icons.logout,
              color: current_index == 7 ? Colors.white : Colors.red,
            ),
            tileColor: current_index == 7 ? MyColors.secondary : null,
            title: Text(
              "Déconnexion",
              style: TextStyle(
                  color: current_index == 7 ? Colors.white : Colors.red,
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
        final apiProvider =
            Provider.of<ApiProvider>(dialogContext, listen: false);
        final user = apiProvider.user;
        final service = Provider.of<DBServices>(dialogContext);

        return AlertDialog(
          backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
          title: Text(
            "Déconnexion",
            style: TextStyle(
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Voulez-vous vraiment vous déconnecter ?",
            style: TextStyle(
              color: user.dark_mode == 1 ? MyColors.light : MyColors.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    "Annuler",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () async {
                    String statut_code = await service.logout();
                    if (statut_code == "202") {
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.8,
                          left: MediaQuery.of(context).size.width * 0.5,
                          right: 20,
                        ),
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Une erreur s'est produite",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialogContext)
                          .showSnackBar(snackBar);
                    } else if (statut_code == "500") {
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.8,
                          left: MediaQuery.of(context).size.width * 0.5,
                          right: 20,
                        ),
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Vérifiez votre connection  internet",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialogContext)
                          .showSnackBar(snackBar);
                    } else {
                      Navigator.of(dialogContext).pop();
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.8,
                          left: MediaQuery.of(context).size.width * 0.5,
                          right: 20,
                        ),
                        backgroundColor: MyColors.secondary,
                        content: Text(
                          "Vous avez été déconnecté avec succès",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialogContext)
                          .showSnackBar(snackBar);

                      Navigator.of(dialogContext).pushAndRemoveUntil(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
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
                  child: Text(
                    "Validez",
                    style: TextStyle(
                      color: MyColors.secondary,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: 1,
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
