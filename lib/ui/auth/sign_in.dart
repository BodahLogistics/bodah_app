// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:bodah/wrappers/wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/api/api_data.dart';
import '../../providers/auth/prov_sign_in.dart';
import '../../services/data_base_service.dart';
import 'forgot_password.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController Number = TextEditingController();

  TextEditingController Password = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvSignIn>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvSignIn>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    String phone_number = provider.phone_number;
    String password = provider.password;
    bool affiche = provider.affiche;
    bool hide_password = provider.hide_password;

    final service = Provider.of<DBServices>(context);

    return Scaffold(
      body: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      height: 85,
                      child: IntlPhoneField(
                        initialCountryCode: 'BJ',
                        controller: Number,
                        onChanged: (value) =>
                            provider.change_phone_number(value.completeNumber),
                        decoration: InputDecoration(
                            labelText: "Téléphone",
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
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
                      height: 55,
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
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                            labelText: "Mot de passe",
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
                        onPressed: affiche
                            ? null
                            : () async {
                                provider.change_affiche(true);
                                String device = await function.getDeviceModel();
                                Position? position =
                                    await function.getLocation();

                                String statut_code = await service.login(
                                    phone_number,
                                    password,
                                    api_provider,
                                    device,
                                    position?.longitude ?? 0.0,
                                    position?.latitude ?? 0.0,
                                    "",
                                    "");

                                if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(context,
                                      "Erreur de validation", Colors.redAccent);
                                } else if (statut_code == "500") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Une erreur s'est produite. Vérifiez votre connection internet et réessayez !",
                                      Colors.redAccent);
                                } else if (statut_code == "101") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Aucun n'est associé à ce numéro de téléphone",
                                      Colors.redAccent);
                                } else if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Mot de passe incorrect",
                                      Colors.redAccent);
                                } else if (statut_code == "204") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Une erreir s'est produite",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        return Wrappers();
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

                                  provider.change_affiche(false);
                                  provider.reset();

                                  showCustomSnackBar(
                                      context,
                                      "Vous avez été connecté avec suucès. Patientez pour la redirection",
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
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
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
          ),
        ),
      ),
    );
  }
}

void showCustomSnackBar(
    BuildContext context, String message, Color backgroundColor) {
  final snackBar = SnackBar(
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: 80.0, vertical: 50.0),
    content: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
