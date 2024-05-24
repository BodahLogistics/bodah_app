// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/auth/prov_sign_up.dart';
import 'sign_in.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController Password = TextEditingController();
  TextEditingController Adresse = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController Number = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final users = Provider.of<List<Users>>(context);
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvSignUp>(context);
    String adresse = provider.adresse;
    String password = provider.password;
    String nom = provider.nom;
    String number = provider.telephone;
    String confirm_password = provider.confirm_password;
    bool affiche = provider.affiche;
    bool hide_password = provider.hide_password;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
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
                    "Créez un compte pour commencer",
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
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: Name,
                    onChanged: (value) => provider.change_nom(value),
                    decoration: InputDecoration(
                        suffixIcon: Name.text.isNotEmpty && nom.length < 3
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(Icons.error, color: Colors.red),
                              )
                            : null,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Name.text.isEmpty
                              ? function.convertHexToColor("#79747E")
                              : nom.length > 3
                                  ? MyColors.secondary
                                  : Colors.red,
                        )),
                        labelText: "Nom",
                        hintText: "Votre nom",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                        hintStyle:
                            TextStyle(fontSize: 14, fontFamily: "Poppins")),
                  ),
                ),
              ),
              Name.text.isEmpty
                  ? Container()
                  : nom.length < 3
                      ? Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Nom invalid",
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
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: Adresse,
                    onChanged: (value) => provider.change_adresse(value),
                    decoration: InputDecoration(
                        suffixIcon:
                            Adresse.text.isNotEmpty && adresse.length < 3
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Icon(Icons.error, color: Colors.red),
                                  )
                                : null,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Adresse.text.isEmpty
                              ? function.convertHexToColor("#79747E")
                              : adresse.length < 3
                                  ? MyColors.secondary
                                  : Colors.red,
                        )),
                        labelText: "Adresse de résidence (Facultatif)",
                        hintText: "Adrese de résidence (Facultatif)",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                        hintStyle:
                            TextStyle(fontSize: 14, fontFamily: "Poppins")),
                  ),
                ),
              ),
              Adresse.text.isEmpty
                  ? Container()
                  : adresse.length < 3
                      ? Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Adresse électronique invalide",
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
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: SizedBox(
                  height: 60,
                  child: IntlPhoneField(
                    initialCountryCode: 'BJ',
                    controller: Number,
                    onChanged: (value) =>
                        provider.change_telephone(value.completeNumber),
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
                        suffixIcon:
                            Password.text.isNotEmpty && password.length < 8
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Icon(Icons.error, color: Colors.red),
                                  )
                                : null,
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
              Password.text.isEmpty
                  ? Container()
                  : password.length < 8
                      ? Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Mot de passe moins sécurisé",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.28,
                              child: Container(
                                color: MyColors.secondary,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Mot de passe fort",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 13),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: ConfirmPassword,
                    obscureText: hide_password,
                    onChanged: (value) =>
                        provider.change_confirm_password(value),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              provider.change_hide_password();
                            },
                            icon: hide_password
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        labelText: "Confirmation",
                        hintText: "Confirmez le mot de passe",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                        hintStyle:
                            TextStyle(fontSize: 14, fontFamily: "Poppins")),
                  ),
                ),
              ),
              ConfirmPassword.text.isEmpty
                  ? Container()
                  : confirm_password != password
                      ? Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Mot de passe mal confirmé",
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
                height: 15,
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
                          "Créer mon compte",
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
                          text: "Vous avez déjà un compte ? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        TextSpan(
                          text: "Connectez-vous !",
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
                                      Animation<double> secondaryAnimation) {
                                    return SignIn();
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
    );
  }
}
