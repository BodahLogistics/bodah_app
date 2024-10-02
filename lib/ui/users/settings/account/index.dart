// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:bodah/functions/function.dart';
import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/auth/prov_sign_up.dart';
import 'package:bodah/ui/account/account_deleted.dart';
import 'package:bodah/ui/users/settings/account/edit.dart';
import 'package:bodah/ui/users/settings/account/edit_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../modals/rules.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../providers/connection/index.dart';
import '../../../../services/data_base_service.dart';
import '../../../../wrappers/wrapper.dart';
import '../../../account/account_disabled.dart';
import '../../../auth/sign_in.dart';
import '../../expediteur/drawer/index.dart';
import '../../transporteur/drawer/index.dart';
import 'edit_password.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvSignUp>(context);
    Users? user = api_provider.user;
    Rules? rule = api_provider.rule;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes = api_provider.villes;
    Pays pay = function.pay(pays, user?.country_id ?? 24);
    Villes ville = function.ville(villes, user?.city_id ?? 0);
    final connexionProvider = Provider.of<ProvConnexion>(context);
    bool isConnected = connexionProvider.isConnected;

    if (!isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showNoConnectionState(
            context, connexionProvider); // Affiche le popup si déconnecté
      });
    }

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
          "Mon compte",
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
              provider.change_user_data(user, pay, ville);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return UpdateAccount();
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
              Icons.manage_accounts,
              color: user.dark_mode == 1 ? MyColors.light : null,
            ),
            title: Text(
              "Mes informations",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return UpdatePhoneNumber();
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
              Icons.phone,
              color: user.dark_mode == 1 ? MyColors.light : null,
            ),
            title: Text(
              "Changez de numéro",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return UpdatePassword();
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
              Icons.security,
              color: user.dark_mode == 1 ? MyColors.light : null,
            ),
            title: Text(
              "Changez de mot de passe",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              DisableAccount(context);
            },
            leading: Icon(
              Icons.person_off,
              color: user.dark_mode == 1 ? MyColors.light : null,
            ),
            title: Text(
              "Désactivez votre compte",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              DeleteAccount(context);
            },
            leading: Icon(
              Icons.delete,
              color: user.dark_mode == 1 ? MyColors.light : null,
            ),
            title: Text(
              "Supprimez votre compte",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              logOut(context);
            },
            leading: Icon(
              Icons.logout,
              color: user.dark_mode == 1 ? MyColors.light : null,
            ),
            title: Text(
              "Déconnexion",
              style: TextStyle(
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

void DisableAccount(BuildContext context) {
  // Afficher l'alerte "Perte"
  Future.delayed(Duration(milliseconds: 500), () {
    TextEditingController Password = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvSignUp>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        String password = provider.password;
        bool affiche = provider.affiche;
        final service = Provider.of<DBServices>(dialogcontext);
        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Text(
            "Désactivation du compte",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Saisissez votre mot de passe pour confirmer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: user.dark_mode == 1
                          ? MyColors.light
                          : MyColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: Password,
                      obscureText: true,
                      onChanged: (value) => provider.change_password(value),
                      decoration: InputDecoration(
                          suffixIcon: Password.text.isNotEmpty &&
                                  password.length < 8
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          labelText: "Mot de passe",
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Poppins"),
                          hintStyle:
                              TextStyle(fontSize: 14, fontFamily: "Poppins")),
                    ),
                  ),
                ),
              ],
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
                        provider.change_affiche(false);
                        Navigator.of(dialogcontext).pop();
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
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);
                            String statut = await service.DisableAccount(
                                password, api_provider);

                            if (statut == "403") {
                              showCustomSnackBar(dialogcontext,
                                  "Mot de passe incorrect", Colors.redAccent);
                              provider.change_affiche(false);
                            } else if (statut == "202") {
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Une erreur s'est produite",
                                  Colors.redAccent);
                              provider.change_affiche(false);
                            } else if (statut == "500") {
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Vérifiez votre connection  internet",
                                  Colors.redAccent);
                              provider.change_affiche(false);
                            } else {
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Votre compte a été désactivé avec succès",
                                  Colors.green);
                              provider.change_affiche(false);
                              Navigator.of(dialogcontext).pop();

                              Navigator.of(dialogcontext).pushAndRemoveUntil(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return AccountDisabled();
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
                                ModalRoute.withName("/disable"),
                              );
                            }
                          },
                    child: affiche
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

void DeleteAccount(BuildContext context) {
  // Afficher l'alerte "Perte"
  Future.delayed(Duration(milliseconds: 500), () {
    TextEditingController Password = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvSignUp>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        String password = provider.password;

        bool affiche = provider.affiche;
        final service = Provider.of<DBServices>(dialogcontext);
        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Text(
            "Suppression du compte",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Saisissez votre mot de passe pour confirmer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: user.dark_mode == 1
                          ? MyColors.light
                          : MyColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: Password,
                      obscureText: true,
                      onChanged: (value) => provider.change_password(value),
                      decoration: InputDecoration(
                          suffixIcon: Password.text.isNotEmpty &&
                                  password.length < 8
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          labelText: "Mot de passe",
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Poppins"),
                          hintStyle:
                              TextStyle(fontSize: 14, fontFamily: "Poppins")),
                    ),
                  ),
                ),
              ],
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
                        provider.change_affiche(false);
                        Navigator.of(dialogcontext).pop();
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
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);
                            String statut = await service.DeleteAccount(
                                password, api_provider);

                            if (statut == "403") {
                              showCustomSnackBar(dialogcontext,
                                  "Mot de passe incoorect", Colors.redAccent);
                              provider.change_affiche(false);
                            } else if (statut == "202") {
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Une erreur s'est produite",
                                  Colors.redAccent);
                              provider.change_affiche(false);
                            } else if (statut == "500") {
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Vérifiez votre connection  internet",
                                  Colors.redAccent);
                              provider.change_affiche(false);
                            } else {
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Votre compte a été supprimé avec succès",
                                  Colors.green);
                              provider.change_affiche(false);
                              Navigator.of(dialogcontext).pop();
                              Navigator.of(dialogcontext).pushAndRemoveUntil(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return AccountDeleted();
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
                                ModalRoute.withName("/delete"),
                              );
                            }
                          },
                    child: affiche
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
