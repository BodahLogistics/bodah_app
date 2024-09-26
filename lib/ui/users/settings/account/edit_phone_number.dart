// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:bodah/providers/auth/prov_sign_up.dart';
import 'package:bodah/providers/auth/prov_val_account.dart';
import 'package:bodah/ui/users/settings/account/validate_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../modals/rules.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../../expediteur/drawer/index.dart';
import '../../transporteur/drawer/index.dart';

class UpdatePhoneNumber extends StatefulWidget {
  const UpdatePhoneNumber({super.key});

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvSignUp>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
    });
  }

  TextEditingController LastPhoneNumber = TextEditingController();

  TextEditingController Telephone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final validate_provider = Provider.of<ProvValiAccount>(context);
    final provider = Provider.of<ProvSignUp>(context);
    Users? user = api_provider.user;
    Rules? rule = api_provider.rule;

    String telephone = provider.telephone;

    final service = Provider.of<DBServices>(context);
    bool affiche = provider.affiche;

    if (LastPhoneNumber.text.isEmpty && user!.telephone.isNotEmpty) {
      LastPhoneNumber.text = user.telephone.substring(4, user.telephone.length);
    }

    if (Telephone.text.isEmpty && telephone.isNotEmpty) {
      Telephone.text = telephone.substring(4, telephone.length);
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
          "Numéro de téléphone",
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
      body: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            children: [
              user.dark_mode == 1
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ancien numéro de téléphone",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: MyColors.light,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 70,
                child: IntlPhoneField(
                  enabled: false,
                  initialCountryCode: 'BJ',
                  controller: LastPhoneNumber,
                  onChanged: (value) =>
                      provider.change_telephone(value.completeNumber),
                  decoration: InputDecoration(
                      suffixIcon:
                          Telephone.text.isNotEmpty && telephone.length < 8
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      filled: user.dark_mode == 1 ? true : false,
                      fillColor:
                          user.dark_mode == 1 ? MyColors.filedDark : null,
                      labelText: user.dark_mode == 0
                          ? "Ancien numéro de téléphone"
                          : "",
                      labelStyle: TextStyle(
                          color: user.dark_mode == 1
                              ? MyColors.light
                              : MyColors.black,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: MyColors.black)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              user.dark_mode == 1
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nouveau numéro de téléphone",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: MyColors.light,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 70,
                child: IntlPhoneField(
                  initialCountryCode: 'BJ',
                  controller: Telephone,
                  onChanged: (value) =>
                      provider.change_telephone(value.completeNumber),
                  decoration: InputDecoration(
                      suffixIcon:
                          Telephone.text.isNotEmpty && telephone.length < 8
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      filled: user.dark_mode == 1 ? true : false,
                      fillColor:
                          user.dark_mode == 1 ? MyColors.filedDark : null,
                      labelText: user.dark_mode == 0
                          ? "Nouveau numéro de téléphone"
                          : "",
                      labelStyle: TextStyle(
                          color: user.dark_mode == 1
                              ? MyColors.light
                              : MyColors.black,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: MyColors.black)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: MyColors.secondary),
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);

                            String statut_code =
                                await service.ChangePhoneNumber(
                                    telephone, api_provider);

                            if (statut_code == "401") {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  context,
                                  "Le nouveau numéro de téléphone saisi est déjà utilisé",
                                  Colors.redAccent);
                            } else if (statut_code == "202") {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  context,
                                  "Une erreur inattendue s'est produite",
                                  Colors.redAccent);
                            } else if (statut_code == "422") {
                              provider.change_affiche(false);
                              showCustomSnackBar(context,
                                  "Erreur de validation", Colors.redAccent);
                            } else if (statut_code == "500") {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  context,
                                  "Une erreur s'est produite. Vérifiez votre connection internet et réessayer",
                                  Colors.redAccent);
                            } else if (statut_code == "200") {
                              validate_provider.change_telephone(telephone);
                              provider.change_affiche(false);
                              provider.reset();

                              showCustomSnackBar(
                                  context,
                                  "Un code de validation vous a été envoyé afin de valider la modification",
                                  Colors.green);

                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return VValidatePhoneNumber();
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
                          "Modifiez",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
