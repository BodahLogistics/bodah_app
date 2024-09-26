// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:bodah/ui/users/settings/account/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../colors/color.dart';
import '../../../modals/rules.dart';
import '../../../modals/users.dart';
import '../../../providers/api/api_data.dart';
import '../../../services/data_base_service.dart';
import '../../auth/sign_in.dart';
import '../expediteur/drawer/index.dart';
import '../transporteur/drawer/index.dart';

class MySettings extends StatelessWidget {
  const MySettings({super.key});

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final service = Provider.of<DBServices>(context);
    Users? user = api_provider.user;
    Rules? rule = api_provider.rule;
    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      drawer: rule!.nom == "Transporteur"
          ? DrawerTransporteur()
          : DrawerExpediteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Paramètre",
          style: TextStyle(
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
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
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return MyAccount();
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
              Icons.person_outline,
              size: 30,
              color: MyColors.secondary,
            ),
            title: Text(
              "Mon compte",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Modifiez les infromations de votre compte, changer de numéro de téléphone ou déconnectez",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 11,
                  color:
                      user.dark_mode == 1 ? MyColors.light : MyColors.textColor,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            trailing: IconButton(
                onPressed: () async {
                  String statut_code = await service.darkMode(api_provider);
                  if (statut_code == "202") {
                    showCustomSnackBar(
                        context, "Une erreur s'est produite", Colors.redAccent);
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
              size: 30,
              color: MyColors.secondary,
            ),
            title: Text(
              "Mode sombre",
              style: TextStyle(
                  fontSize: 12,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Activer ou désactiver le mode sombre",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 11,
                  color:
                      user.dark_mode == 1 ? MyColors.light : MyColors.textColor,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.notifications,
              size: 30,
              color: MyColors.secondary,
            ),
            title: Text(
              "Notifications",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Consulter vos notifications",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 11,
                  color:
                      user.dark_mode == 1 ? MyColors.light : MyColors.textColor,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.chat,
              size: 30,
              color: MyColors.secondary,
            ),
            title: Text(
              "Contactez l'entreprise",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Contacter nous et échanger avec nos experts",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 11,
                  color:
                      user.dark_mode == 1 ? MyColors.light : MyColors.textColor,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
