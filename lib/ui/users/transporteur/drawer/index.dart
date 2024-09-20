// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'package:bodah/modals/rules.dart';
import 'package:bodah/providers/users/transporteur/drawer/index.dart';
import 'package:bodah/ui/users/transporteur/trajets/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../../expediteur/drawer/index.dart';
import '../chauffeur/list.dart';

class DrawerTransporteur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    final provider = Provider.of<ProvDrawTransporteur>(context);
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
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
              onTap: () {
                provider.change_index(0);
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
              provider.change_index(1);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return MesChauffeurs();
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
              Icons.local_taxi,
              color: current_index == 1
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 1 ? MyColors.secondary : null,
            title: Text(
              "Mes chauffeurs",
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
          ListTile(
            onTap: () {
              provider.change_index(2);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return ListTrajets();
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
              Icons.route,
              color: current_index == 2
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 2 ? MyColors.secondary : null,
            title: Text(
              "Mes trajets",
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
          ListTile(
            onTap: () {
              provider.change_index(3);
            },
            leading: Icon(
              Icons.local_shipping,
              color: current_index == 3
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 3 ? MyColors.secondary : null,
            title: Text(
              "Annonces d'expédition",
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
              provider.change_index(4);
            },
            leading: Icon(
              Icons.subscriptions,
              color: current_index == 4
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 4 ? MyColors.secondary : null,
            title: Text(
              "Mes souscriptions",
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
            },
            leading: Icon(
              Icons.check_circle_outline,
              color: current_index == 5
                  ? Colors.white
                  : user.dark_mode == 1
                      ? MyColors.light
                      : null,
            ),
            tileColor: current_index == 5 ? MyColors.secondary : null,
            title: Text(
              "Mes transports",
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
                    String statut_code = await service.darkMode();
                    if (statut_code == "202") {
                      showCustomSnackBar(context, "Une erreur s'est produite",
                          Colors.redAccent);
                    } else if (statut_code == "500") {
                      showCustomSnackBar(
                          context,
                          "Vérifiez votre connection  internet",
                          Colors.redAccent);
                    } else {
                      await api_provider.InitUser();
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
