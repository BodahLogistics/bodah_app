// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:bodah/ui/auth/verification_opt.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../modals/users.dart';
import '../../providers/api/api_data.dart';
import '../../providers/auth/prov_reset_password.dart';
import '../../services/data_base_service.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  TextEditingController Number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvResetPassword>(context);
    String phone_number = provider.phone_number;
    bool affiche = provider.affiche;
    final api_provider = Provider.of<ApiProvider>(context);
    List<Users> users = api_provider.users;
    final service = Provider.of<DBServices>(context);
    bool existing_number = function.existing_phone_number(users, phone_number);

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      suffixIcon: Number.text.isNotEmpty && !existing_number
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(Icons.error, color: Colors.red),
                            )
                          : null,
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: "Numéro de téléphone",
                      hintText: "Numéro de téléphone",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                      hintStyle:
                          TextStyle(fontSize: 14, fontFamily: "Poppins")),
                ),
              ),
            ),
            !existing_number && Number.text.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Aucun compte ne correspond à ce numéro",
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
                    String statut_code =
                        await service.resetPassword(phone_number, provider);

                    if (phone_number.length < 8) {
                      provider.change_affiche(false);
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(),
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Données invalides",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (statut_code == "502") {
                      provider.change_affiche(false);
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(),
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Une erreur s'est produite",
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
                        margin: EdgeInsets.only(),
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Aucun compte n'est associé à ce numéro de téléphone",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (statut_code == "422") {
                      provider.change_affiche(false);
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(),
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
                        margin: EdgeInsets.only(),
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Vérifiez votre cpnnection internet et réessayer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (statut_code == "200") {
                      provider.change_affiche(false);
                      provider.reset();
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(),
                        backgroundColor: Colors.green,
                        content: Text(
                          "Un code de validation vous a été envoyé. Procédez à la validation",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return VerificationOTP(
                              telephone: phone_number,
                            );
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
