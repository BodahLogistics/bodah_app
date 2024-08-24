// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_declarations, deprecated_member_use, prefer_const_constructors_in_immutables

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/rules.dart';
import 'package:bodah/modals/statuts.dart';
import 'package:bodah/modals/users.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/api/api_data.dart';
import 'package:bodah/providers/auth/prov_val_account.dart';
import 'package:bodah/services/data_base_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/auth/prov_sign_up.dart';
import 'sign_in.dart';
import 'validate_account.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController Password = TextEditingController();

  TextEditingController Adresse = TextEditingController();

  TextEditingController Name = TextEditingController();

  TextEditingController Number = TextEditingController();

  TextEditingController ConfirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvSignUp>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvSignUp>(context);
    final prov_val_ac = Provider.of<ProvValiAccount>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    String password = provider.password;
    String nom = provider.nom;
    String number = provider.telephone;
    String confirm_password = provider.confirm_password;
    bool affiche = provider.affiche;
    bool hide_password = provider.hide_password;
    bool accepte = provider.accepte;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes = api_provider.villes;
    List<Rules> rules = api_provider.rules;
    List<Statuts> statuts = api_provider.statuts;
    final pay = provider.pay;
    final ville = provider.ville;
    final rule = provider.rule;
    final statut = provider.statut;
    List<Users> users = api_provider.users;

    bool existing_number = function.existing_phone_number(users, number);

    final service = Provider.of<DBServices>(context);

    bool loading = api_provider.loading;

    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: MyColors.secondary,
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
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
                padding: const EdgeInsets.only(top: 17),
                child: SizedBox(
                  height: 70,
                  child: IntlPhoneField(
                    initialCountryCode: 'BJ',
                    controller: Number,
                    onChanged: (value) =>
                        provider.change_telephone(value.completeNumber),
                    decoration: InputDecoration(
                        suffixIcon: Number.text.isNotEmpty && existing_number
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(Icons.error, color: Colors.red),
                              )
                            : null,
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        labelText: "Téléphone",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                        hintStyle:
                            TextStyle(fontSize: 14, fontFamily: "Poppins")),
                  ),
                ),
              ),
              existing_number
                  ? Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Numéro de téléphone déjà utilisé",
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
                height: 54,
                child: DropdownSearch<String>(
                  popupProps: PopupProps.dialog(
                    showSearchBox: true,
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),

                  items: pays.map((type) => type.name).toList(),
                  filterFn: (user, filter) =>
                      user.toLowerCase().contains(filter.toLowerCase()),

                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: "Pays",
                        labelStyle: TextStyle(
                            color: MyColors.black,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: MyColors.black)),
                  ),

                  onChanged: (String? selectedType) async {
                    if (selectedType != null) {
                      final pay_selected = pays.firstWhere(
                          (element) => element.name == selectedType);
                      provider.change_pays(pay_selected);
                      await api_provider.getAllVilles(24);
                    }
                  },
                  selectedItem: pay
                      .name, // Remplacez 'null' par le type de compte par défaut si nécessaire
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 54,
                child: DropdownSearch<String>(
                  popupProps: PopupProps.dialog(
                    showSearchBox: true,
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),

                  items: villes.map((type) => type.name).toList(),
                  filterFn: (user, filter) =>
                      user.toLowerCase().contains(filter.toLowerCase()),

                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: "Ville",
                        labelStyle: TextStyle(
                            color: MyColors.black,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: MyColors.black)),
                  ),

                  onChanged: (String? selectedType) {
                    if (selectedType != null) {
                      final ville_selected = villes.firstWhere(
                          (element) => element.name == selectedType);
                      provider.change_ville(ville_selected);
                    }
                  },
                  selectedItem: ville
                      .name, // Remplacez 'null' par le type de compte par défaut si nécessaire
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 54,
                child: DropdownSearch<String>(
                  popupProps: PopupProps.dialog(
                    showSearchBox: true,
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),

                  items: rules.map((type) => type.nom).toList(),
                  filterFn: (user, filter) =>
                      user.toLowerCase().contains(filter.toLowerCase()),

                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: "Rôle",
                        labelStyle: TextStyle(
                            color: MyColors.black,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: MyColors.black)),
                  ),

                  onChanged: (String? selectedType) {
                    if (selectedType != null) {
                      final rule_selected = rules
                          .firstWhere((element) => element.nom == selectedType);
                      provider.change_rule(rule_selected);
                    }
                  },
                  selectedItem: rule
                      .nom, // Remplacez 'null' par le type de compte par défaut si nécessaire
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 54,
                child: DropdownSearch<String>(
                  popupProps: PopupProps.dialog(
                    showSearchBox: true,
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),

                  items: statuts.map((type) => type.name).toList(),
                  filterFn: (user, filter) =>
                      user.toLowerCase().contains(filter.toLowerCase()),

                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: "Statut",
                        labelStyle: TextStyle(
                            color: MyColors.black,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: MyColors.black)),
                  ),

                  onChanged: (String? selectedType) {
                    if (selectedType != null) {
                      final statut_selected = statuts.firstWhere(
                          (element) => element.name == selectedType);
                      provider.change_statut(statut_selected);
                    }
                  },
                  selectedItem: statut
                      .name, // Remplacez 'null' par le type de compte par défaut si nécessaire
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
                              width: MediaQuery.of(context).size.width * 0.4,
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
              Container(
                alignment: Alignment.centerLeft,
                child: RadioListTile(
                  title: Text(
                    "J'accepte les termes d'utilisation de l'application",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 14),
                  ),
                  value: true,
                  groupValue: accepte,
                  onChanged: (value) {
                    provider.change_accepte(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () async {
                        final url = 'https://bodah.bj/conditions-generales';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          showCustomSnackBar(
                              context,
                              "Vous devez vous connecter à internet. Une erreur s'est produite",
                              Colors.redAccent);
                        }
                      },
                      child: Text(
                        "Consulter les termes d'utilisation",
                        style: TextStyle(
                            color: MyColors.secondary,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            decoration: TextDecoration.underline),
                      )),
                ),
              ),
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
                        backgroundColor: accepte
                            ? MyColors.secondary
                            : MyColors.secondary.withOpacity(.4)),
                    onPressed: affiche
                        ? null
                        : () async {
                            if (!accepte) {
                              ShowErrorMessage(
                                context,
                                "Vous devez avant tout accepter les termes et conditions d'utilisation de notre application",
                                "Termes d'utilisation",
                              );
                            } else {
                              provider.change_affiche(true);

                              if (nom.length < 3 ||
                                  number.length < 8 ||
                                  pay.id < 1 ||
                                  ville.id < 1 ||
                                  rule.id < 1 ||
                                  statut.id < 1 ||
                                  password.length < 8 ||
                                  confirm_password.length < 8) {
                                provider.change_affiche(false);
                                showCustomSnackBar(context, 'Données invalides',
                                    Colors.redAccent);
                              } else if (password != confirm_password) {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    'Mot de passe mal confirmé',
                                    Colors.redAccent);
                              } else if (existing_number) {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    context,
                                    'Numéro de téléphone déjà utilisé',
                                    Colors.redAccent);
                              } else {
                                String statut_code = await service.register(
                                    nom,
                                    number,
                                    statut,
                                    rule,
                                    password,
                                    confirm_password,
                                    ville,
                                    pay,
                                    prov_val_ac);

                                if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(context,
                                      "Erreur de validation", Colors.redAccent);
                                } else if (statut_code == "500") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Une erreur s'est produite. Vérifier votre connection internet et réessayer",
                                      Colors.redAccent);
                                } else if (statut_code == "502") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Une erreur s'est produite",
                                      Colors.redAccent);
                                } else if (statut_code == '200') {
                                  provider.change_affiche(false);
                                  provider.reset();
                                  showCustomSnackBar(
                                      context,
                                      "Un code de validation vous a été envoyé. Procédez à l validation de votre compte",
                                      Colors.green);
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        return ValidateAccount(
                                            telephone: number);
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
