// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:bodah/services/data_base_service.dart';
import 'package:bodah/ui/auth/account_created.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/api/api_data.dart';
import '../../providers/auth/prov_val_account.dart';

class ValidateAccount extends StatefulWidget {
  const ValidateAccount({
    super.key,
    required this.telephone,
  });

  final String telephone;

  @override
  State<ValidateAccount> createState() => _ValidateAccountState();
}

class _ValidateAccountState extends State<ValidateAccount> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false).getUser();
    });
  }

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
    final api_provider = Provider.of<ApiProvider>(context);
    final service = Provider.of<DBServices>(context);
    final user = api_provider.user;
    final bool loading = api_provider.loading;
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.secondary,
              ),
            )
          : Padding(
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
                            widget.telephone.substring(0, 5) +
                            "****" +
                            widget.telephone.substring(
                                widget.telephone.length - 4,
                                widget.telephone.length),
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
                              ShowErrorMessage(
                                  context,
                                  "Le code saisi est invalid",
                                  "Validation du compte");
                            } else {
                              provider.change_affiche(true);
                              String statut_code = await service
                                  .validateAccount(code_taped, user);

                              if (statut_code == "404") {
                                provider.change_affiche(false);
                                final snackBar = SnackBar(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      left: MediaQuery.of(context).size.width *
                                          0.5,
                                      right: 20),
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (statut_code == "500") {
                                provider.change_affiche(false);
                                final snackBar = SnackBar(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      left: MediaQuery.of(context).size.width *
                                          0.5,
                                      right: 20),
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (statut_code == "101") {
                                provider.change_affiche(false);
                                final snackBar = SnackBar(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      left: MediaQuery.of(context).size.width *
                                          0.5,
                                      right: 20),
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                    "Le code saisi est incorrect ou est expiré",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins"),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (statut_code == "201") {
                                provider.change_affiche(false);
                                final snackBar = SnackBar(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      left: MediaQuery.of(context).size.width *
                                          0.5,
                                      right: 20),
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                    "Le code saisi est invalid",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins"),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                provider.change_affiche(false);
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return AccountCreated();
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
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      left: MediaQuery.of(context).size.width *
                                          0.5,
                                      right: 20),
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    "Votre compte a été validé",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins"),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
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
