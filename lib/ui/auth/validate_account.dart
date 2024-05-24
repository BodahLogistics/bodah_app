// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/auth/prov_val_account.dart';

class ValidateAccount extends StatelessWidget {
  const ValidateAccount(
      {super.key,
      required this.nom,
      required this.adresse,
      required this.telephone,
      required this.password,
      required this.verificationId,
      required this.verificationToken});
  final String nom;
  final String adresse;
  final String telephone;
  final String password;
  final String verificationId;
  final int? verificationToken;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvValiAccount>(context);
    String first = provider.first;
    String second = provider.second;
    String third = provider.third;
    String fourth = provider.fourth;
    String fifth = provider.fifth;
    String sixth = provider.sixth;

    bool affiche = provider.affiche;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bodah",
                style: TextStyle(
                    color: MyColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 17),
              ),
            ),
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
                      fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Entrez le code de vérification envoyé par sms au numéro " +
                      telephone.substring(0, 5) +
                      "****" +
                      telephone.substring(
                          telephone.length - 4, telephone.length),
                  style: TextStyle(
                      color: function.convertHexToColor("#79747E"),
                      fontFamily: "Poppins",
                      fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      DisplayFirst(context, "First");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.11,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: first.isEmpty
                          ? Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Center(
                              child: Text(
                                first,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DisplayFirst(context, "Second");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.11,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: second.isEmpty
                          ? Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Center(
                              child: Text(
                                second,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DisplayFirst(context, "Third");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.11,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: third.isEmpty
                          ? Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Center(
                              child: Text(
                                third,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DisplayFirst(context, "Fourth");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.11,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: fourth.isEmpty
                          ? Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Center(
                              child: Text(
                                fourth,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DisplayFirst(context, "Fifth");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.11,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: fourth.isEmpty
                          ? Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Center(
                              child: Text(
                                fifth,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DisplayFirst(context, "Sixth");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.11,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: MyColors.secondary,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: fourth.isEmpty
                          ? Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Center(
                              child: Text(
                                sixth,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
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
                    onPressed: () async {
                      String code_taped =
                          first + second + third + fourth + fifth + sixth;

                      if (code_taped.isEmpty) {
                        ShowErrorMessage(
                            context,
                            "Vous devez saisir le code qui vous a été envoyé par sms",
                            "Validation du compte");
                      } else if (code_taped.length != 6) {
                        ShowErrorMessage(context, "Le code saisi est invalid",
                            "Validation du compte");
                      } else {
                        provider.change_affiche(true);
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

Future<dynamic> DisplayFirst(BuildContext context, String element) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialog) {
      final provider = Provider.of<ProvValiAccount>(dialog);
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
