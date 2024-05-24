// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/auth/prov_sign_in.dart';
import 'forgot_password.dart';
import 'sign_up.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  TextEditingController Number = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final users = Provider.of<List<Users>>(context);
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvSignIn>(context);
    String phone_number = provider.phone_number;
    String password = provider.password;
    bool affiche = provider.affiche;
    bool hide_password = provider.hide_password;

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
                  "Content de vous revoir !",
                  style: TextStyle(
                      color: function.convertHexToColor("#222523"),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: Password,
                  obscureText: hide_password,
                  onChanged: (value) => provider.change_password(value),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            provider.change_hide_password();
                          },
                          icon: hide_password
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: "Mot de passe",
                      hintText: "Votre mot de passe",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                      hintStyle:
                          TextStyle(fontSize: 14, fontFamily: "Poppins")),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return ForgotPassword();
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
                    child: Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: MyColors.secondary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    )),
              ),
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
                        "Me connecter",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Vous n’avez pas encore de compte ? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      TextSpan(
                        text: "Créez un compte !",
                        style: TextStyle(
                          color: MyColors.secondary,
                          fontSize: 14,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return SignUp();
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
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
