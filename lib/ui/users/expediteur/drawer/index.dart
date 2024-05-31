// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'package:bodah/providers/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/dashboard/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../providers/api/api_data.dart';

class DrawerExpediteur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    final provider = Provider.of<ProvDrawExpediteur>(context);
    int current_index = provider.current_index;

    return Drawer(
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
                    color: Colors.black,
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
              },
              leading: Icon(
                FontAwesomeIcons.truck,
                color: current_index == 2 ? Colors.white : null,
              ),
              tileColor: current_index == 2 ? MyColors.secondary : null,
              title: Text(
                "Envoi de marchandise",
                style: TextStyle(
                    color: current_index == 2
                        ? Colors.white
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
              color: current_index == 1 ? Colors.white : null,
            ),
            tileColor: current_index == 1 ? MyColors.secondary : null,
            title: Text(
              "Envoi de colis",
              style: TextStyle(
                  color: current_index == 1
                      ? Colors.white
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
                color: current_index == 0 ? Colors.white : null,
              ),
              tileColor: current_index == 0 ? MyColors.secondary : null,
              title: Text(
                "Accueil",
                style: TextStyle(
                    color: current_index == 0
                        ? Colors.white
                        : function.convertHexToColor("#222523"),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(3);
            },
            leading: Icon(
              Icons.share,
              color: current_index == 3 ? Colors.white : null,
            ),
            tileColor: current_index == 3 ? MyColors.secondary : null,
            title: Text(
              "Partagez",
              style: TextStyle(
                  color: current_index == 3
                      ? Colors.white
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
                  onPressed: () async {},
                  icon: Icon(
                    Icons.toggle_on,
                    color: MyColors.secondary,
                  )),
              leading: Icon(
                Icons.brightness_6,
              ),
              title: Text(
                "Mode sombre",
                style: TextStyle(
                    color: function.convertHexToColor("#222523"),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              provider.change_index(4);
            },
            leading: Icon(
              Icons.settings,
              color: current_index == 4 ? Colors.white : null,
            ),
            tileColor: current_index == 4 ? MyColors.secondary : null,
            title: Text(
              "Paramètres",
              style: TextStyle(
                  color: current_index == 4
                      ? Colors.white
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
              provider.change_index(5);
            },
            leading: Icon(
              Icons.logout,
              color: current_index == 5 ? Colors.white : Colors.red,
            ),
            tileColor: current_index == 5 ? MyColors.secondary : null,
            title: Text(
              "Déconnexion",
              style: TextStyle(
                  color: current_index == 5 ? Colors.white : Colors.red,
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
