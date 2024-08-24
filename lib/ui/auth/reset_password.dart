// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_declarations, deprecated_member_use, prefer_const_constructors_in_immutables

import 'package:bodah/providers/auth/prov_reset_password.dart';
import 'package:bodah/services/data_base_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors/color.dart';
import '../../functions/function.dart';
import 'sign_in.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController Password = TextEditingController();

  TextEditingController ConfirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvResetPassword>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvResetPassword>(context);
    String password = provider.password;
    String confirm_password = provider.confirm_password;
    bool affiche = provider.affiche;
    bool hide_password = provider.hide_password;
    final service = Provider.of<DBServices>(context);
    final user = provider.user;

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Réinitialisation de mot de passe",
                  style: TextStyle(
                      color: function.convertHexToColor("#222523"),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Entrez puis confirmez le nouveau mot de passe",
                  style: TextStyle(
                    color: function.convertHexToColor("#79747E"),
                    fontFamily: "Poppins",
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: Password,
                  obscureText: hide_password,
                  onChanged: (value) => provider.change_password(value),
                  decoration: InputDecoration(
                      suffixIcon:
                          Password.text.isNotEmpty && password.length < 8
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: "Nouveau mot de passe",
                      hintText: "Nouveau mot de passe",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                      hintStyle:
                          TextStyle(fontSize: 14, fontFamily: "Poppins")),
                ),
              ),
            ),
            Password.text.isEmpty
                ? Container()
                : password.length < 8
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Mot de passe moins sécurisé",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Container(
                              color: MyColors.secondary,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mot de passe fort",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 13),
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: ConfirmPassword,
                  obscureText: hide_password,
                  onChanged: (value) => provider.change_confirm_password(value),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            provider.change_hide_password();
                          },
                          icon: hide_password
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: "Confirmation",
                      hintText: "Confirmez le mot de passe",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                      hintStyle:
                          TextStyle(fontSize: 14, fontFamily: "Poppins")),
                ),
              ),
            ),
            ConfirmPassword.text.isEmpty
                ? Container()
                : confirm_password != password
                    ? Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Mot de passe mal confirmé",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      )
                    : Container(),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: MyColors.secondary),
                  onPressed: () async {
                    provider.change_affiche(true);

                    if (password.length < 8 || confirm_password.length < 8) {
                      provider.change_affiche(false);
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Données invalides',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (password != confirm_password) {
                      provider.change_affiche(false);
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Mot de passe mal confirmé',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      String statut_code = await service.change_password(
                          user, password, confirm_password);

                      if (statut_code == "422") {
                        provider.change_affiche(false);
                        final snackBar = SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            "Erreur de validation",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (statut_code == "500") {
                        provider.change_affiche(false);
                        final snackBar = SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            "Une erreur s'est produite. Vérifier votre connection internet et réessayer",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (statut_code == "404") {
                        provider.change_affiche(false);
                        final snackBar = SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            "Compte non retrouvé",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (statut_code == "101") {
                        provider.change_affiche(false);
                        final snackBar = SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            "Le code est expiré",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        provider.change_affiche(false);
                        provider.reset();
                        Navigator.of(context).push(
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

                        final snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "Votre mot de passe a été modifié avec succès",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      affiche
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                      Text(
                        "Enregistrez",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
