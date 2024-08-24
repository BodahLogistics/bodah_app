// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:bodah/providers/auth/prov_reset_password.dart';
import 'package:bodah/ui/auth/reset_password.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../services/data_base_service.dart';

class VerificationOTP extends StatefulWidget {
  const VerificationOTP({
    super.key,
    required this.telephone,
  });

  final String telephone;

  @override
  State<VerificationOTP> createState() => _VerificationOTPState();
}

class _VerificationOTPState extends State<VerificationOTP> {
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
    String first = provider.first;
    String second = provider.second;
    String third = provider.third;
    String fourth = provider.fourth;
    String fifth = provider.fifth;
    String sixth = provider.sixth;
    bool affiche = provider.affiche;
    final service = Provider.of<DBServices>(context);
    final user = provider.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Vérification OTP",
                  style: TextStyle(
                      color: function.convertHexToColor("#222523"),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Entrez le code de vérification envoyé par sms au numéro " +
                      widget.telephone.substring(0, 5) +
                      "****" +
                      widget.telephone.substring(
                          widget.telephone.length - 4, widget.telephone.length),
                  style: TextStyle(
                      color: function.convertHexToColor("#79747E"),
                      fontFamily: "Poppins",
                      fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Wrap(
                spacing: 10, // Espacement horizontal entre les boutons
                runSpacing:
                    10, // Espacement vertical entre les lignes de boutons
                children: [
                  buildTextButton(context, first, "First"),
                  buildTextButton(context, second, "Second"),
                  buildTextButton(context, third, "Third"),
                  buildTextButton(context, fourth, "Fourth"),
                  buildTextButton(context, fifth, "Fifth"),
                  buildTextButton(context, sixth, "Sixth"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: affiche
                        ? null
                        : () async {
                            String code_taped =
                                first + second + third + fourth + fifth + sixth;

                            if (code_taped.isEmpty) {
                              ShowErrorMessage(
                                  context,
                                  "Vous devez saisir le code qui vous a été envoyé par sms",
                                  "Vérification OTP");
                            } else if (code_taped.length != 6) {
                              ShowErrorMessage(
                                  context,
                                  "Le code saisi est invalid",
                                  "Vérification OTP");
                            } else {
                              provider.change_affiche(true);
                              final statut_code = await service
                                  .validateResetCode(code_taped, user);

                              if (statut_code == "502") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    "Une erreur s'est produite",
                                    Colors.redAccent);
                              } else if (statut_code == "404") {
                                provider.change_affiche(false);
                                showCustomSnackBar(context,
                                    "Compte non retrouvé", Colors.redAccent);
                              } else if (statut_code == "422") {
                                provider.change_affiche(false);
                                showCustomSnackBar(context,
                                    "Erreur de validation", Colors.redAccent);
                              } else if (statut_code == "500") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    "Vérifiez votre connection internet et réessayez",
                                    Colors.redAccent);
                              } else if (statut_code == "101") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    "Code déja expiré. Cliquez pour recevoir un nouveau code",
                                    Colors.redAccent);
                              } else if (statut_code == "201") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    "Le code saisi est invalid",
                                    Colors.redAccent);
                              } else if (statut_code == "200") {
                                provider.change_affiche(false);
                                provider.reset();
                                showCustomSnackBar(
                                    context,
                                    "Vérification OTP réussie. Procédez au changement du mot de passe",
                                    Colors.green);

                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return ResetPassword();
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
                          "Validez",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildTextButton(BuildContext context, String text, String action) {
  return TextButton(
    onPressed: () {
      DisplayFirst(context, action);
    },
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: MyColors.secondary),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(
        MediaQuery.of(context).size.width *
            0.12, // Ajustez la largeur selon vos besoins
        60,
      )),
    ),
    child: Text(
      text.isNotEmpty ? text : "-",
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Future<dynamic> DisplayFirst(BuildContext context, String element) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialog) {
      final provider = Provider.of<ProvResetPassword>(dialog);
      return AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 15,
            children: List.generate(10, (index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                onPressed: () {
                  if (element == "First") {
                    provider.change_first(index.toString());
                  } else if (element == "Second") {
                    provider.change_second(index.toString());
                  } else if (element == "Third") {
                    provider.change_third(index.toString());
                  } else if (element == "Fourth") {
                    provider.change_fourth(index.toString());
                  } else if (element == "Fifth") {
                    provider.change_fifth(index.toString());
                  } else {
                    provider.change_sixth(index.toString());
                  }

                  Navigator.of(dialog).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    index.toString(),
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    },
  );
}

Future<dynamic> ShowErrorMessage(
    BuildContext context, String message, String title) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: TextStyle(
              color: function.convertHexToColor("#79747E"),
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.secondary),
                onPressed: () {
                  Navigator.of(dialocontext).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Fermez".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                )),
          )
        ],
      );
    },
  );
}

Future<dynamic> ShowErrorCircular(BuildContext context, bool value) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      if (!value) {
        Navigator.of(dialocontext).pop();
      }
      return AlertDialog(
          title: Text(
            "Traitement de l'opération",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: ListBody(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: MyColors.secondary,
                  ))
            ],
          ));
    },
  );
}
