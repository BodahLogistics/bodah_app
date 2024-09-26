// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:bodah/functions/function.dart';
import 'package:bodah/providers/auth/prov_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../modals/rules.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../../expediteur/drawer/index.dart';
import '../../transporteur/drawer/index.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvSignUp>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
    });
  }

  TextEditingController LastPassword = TextEditingController();

  TextEditingController Password = TextEditingController();

  TextEditingController ConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvSignUp>(context);
    Users? user = api_provider.user;
    Rules? rule = api_provider.rule;

    String last_password = provider.last_password;
    String new_password = provider.password;
    String confirm_password = provider.confirm_password;

    final service = Provider.of<DBServices>(context);
    bool affiche = provider.affiche;

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
          "Nouveau mot de passe",
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
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ancien mot de passe",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 60,
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  controller: LastPassword,
                  onChanged: (value) => provider.change_last_password(value),
                  decoration: InputDecoration(
                      suffixIcon: LastPassword.text.isNotEmpty &&
                              (last_password.length < 8)
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(Icons.error, color: Colors.red),
                            )
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: LastPassword.text.isEmpty
                            ? function.convertHexToColor("#79747E")
                            : (last_password.length > 3)
                                ? MyColors.secondary
                                : Colors.red,
                      )),
                      filled: user.dark_mode == 1 ? true : false,
                      fillColor:
                          user.dark_mode == 1 ? MyColors.filedDark : null,
                      labelText:
                          user.dark_mode == 0 ? "Ancien mot de passe" : "",
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
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nouveau mot de passe",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 60,
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  controller: Password,
                  onChanged: (value) => provider.change_password(value),
                  decoration: InputDecoration(
                      suffixIcon:
                          Password.text.isNotEmpty && (new_password.length < 8)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Password.text.isEmpty
                            ? function.convertHexToColor("#79747E")
                            : (new_password.length > 3)
                                ? MyColors.secondary
                                : Colors.red,
                      )),
                      filled: user.dark_mode == 1 ? true : false,
                      fillColor:
                          user.dark_mode == 1 ? MyColors.filedDark : null,
                      labelText:
                          user.dark_mode == 0 ? "Nouveau mot de passe" : "",
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
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirmation du mot de passe",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 60,
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  controller: ConfirmPassword,
                  onChanged: (value) => provider.change_confirm_password(value),
                  decoration: InputDecoration(
                      suffixIcon: ConfirmPassword.text.isNotEmpty &&
                              (confirm_password.length < 3)
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(Icons.error, color: Colors.red),
                            )
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: ConfirmPassword.text.isEmpty
                            ? function.convertHexToColor("#79747E")
                            : (confirm_password.length > 3)
                                ? MyColors.secondary
                                : Colors.red,
                      )),
                      filled: user.dark_mode == 1 ? true : false,
                      fillColor:
                          user.dark_mode == 1 ? MyColors.filedDark : null,
                      labelText: user.dark_mode == 0
                          ? "Confirmer le mot de passe"
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

                            String statut_code = await service.ChangePassword(
                                last_password,
                                new_password,
                                confirm_password,
                                api_provider);

                            if (statut_code == "403") {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  context,
                                  "Le mot de passe saisi est incorrect",
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
                              provider.change_affiche(false);
                              provider.reset();
                              Navigator.of(context).pop();
                              showCustomSnackBar(
                                  context,
                                  "Votre mot de passe a été modifié avec succès",
                                  Colors.green);
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
