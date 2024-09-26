// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:bodah/services/data_base_service.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../modals/rules.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../providers/auth/prov_val_account.dart';
import '../../../auth/verification_opt.dart';
import '../../expediteur/drawer/index.dart';
import '../../transporteur/drawer/index.dart';

class VValidatePhoneNumber extends StatefulWidget {
  const VValidatePhoneNumber({
    super.key,
  });

  @override
  State<VValidatePhoneNumber> createState() => _VValidatePhoneNumberState();
}

class _VValidatePhoneNumberState extends State<VValidatePhoneNumber> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvValiAccount>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
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
    final service = Provider.of<DBServices>(context);
    String telephone = provider.telephone;

    final api_provider = Provider.of<ApiProvider>(context);
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
          "Validation",
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
                      user.telephone.substring(0, 5) +
                      "****" +
                      user.telephone.substring(
                          user.telephone.length - 4, telephone.length),
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
                                  "Validation du compte");
                            } else if (code_taped.length != 6) {
                              ShowErrorMessage(
                                  context,
                                  "Le code saisi est invalid",
                                  "Validation du compte");
                            } else {
                              provider.change_affiche(true);
                              String statut_code =
                                  await service.ValidateChangePhoneNumber(
                                      telephone, code_taped, api_provider);

                              if (statut_code == "401") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    "Nouveau numéro de téléphone déjà utilisé",
                                    Colors.redAccent);
                              } else if (statut_code == "500") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    "Une erreur s'est produite. Vérifier votre connection internet et réessayer",
                                    Colors.redAccent);
                              } else if (statut_code == "01") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    "Le code saisi est incorrect ou est expiré",
                                    Colors.redAccent);
                              } else if (statut_code == "201") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    "Le code saisi est invalid",
                                    Colors.redAccent);
                              } else if (statut_code == "422") {
                                provider.change_affiche(false);
                                showCustomSnackBar(context,
                                    "Erreur de validation", Colors.redAccent);
                              } else {
                                provider.change_affiche(false);
                                provider.reset();
                                showCustomSnackBar(
                                    context,
                                    "Votre numéro de téléphone à été changé avec succès",
                                    Colors.green);

                                Navigator.of(context).pop();
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
