// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/auth/prov_reset_password.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  TextEditingController Number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final users = Provider.of<List<Users>>(context);
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvResetPassword>(context);
    String phone_number = provider.phone_number;
    bool affiche = provider.affiche;

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
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
                  "Réinitialisation de mot de passe",
                  style: TextStyle(
                      color: function.convertHexToColor("#222523"),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Entrez le numéro de téléphone que vous avez utilisé pour créer le compte. Un code de réinitialisation vous sera envoyé",
                  style: TextStyle(
                    color: function.convertHexToColor("#79747E"),
                    fontFamily: "Poppins",
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: SizedBox(
                height: 60,
                child: IntlPhoneField(
                  initialCountryCode: 'BJ',
                  controller: Number,
                  onChanged: (value) =>
                      provider.change_phone_number(value.completeNumber),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: "Numéro de téléphone",
                      hintText: "Votre numéro de téléphone",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                      hintStyle:
                          TextStyle(fontSize: 14, fontFamily: "Poppins")),
                ),
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
                  onPressed: () async {
                    provider.change_affiche(true);
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
                        "Réinitialisation",
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
