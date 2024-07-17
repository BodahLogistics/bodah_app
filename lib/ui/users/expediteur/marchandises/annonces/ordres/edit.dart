// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/providers/users/expediteur/marchandises/annoces/odres/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../../services/data_base_service.dart';
import '../../../drawer/index.dart';

class UpOrdreTransport extends StatelessWidget {
  final int id;
  UpOrdreTransport({super.key, required this.id});
  TextEditingController DelaiChargement = TextEditingController();
  TextEditingController AmendeDelaiChargement = TextEditingController();
  TextEditingController AmendeDechargement = TextEditingController();
  TextEditingController Nom = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Telephone = TextEditingController();
  TextEditingController Entreprise = TextEditingController();
  TextEditingController Ifu = TextEditingController();
  TextEditingController NomEntite = TextEditingController();
  TextEditingController TelephoneEntite = TextEditingController();
  TextEditingController EntrepriseEntite = TextEditingController();
  TextEditingController IfuEntite = TextEditingController();
  TextEditingController Adress = TextEditingController();
  TextEditingController EntiteAdress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvAddOrdre>(context);
    bool affiche = provider.affiche;
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    int delai_chargement = provider.delai_chargement;
    double amende_delai_chargement = provider.amende_delai_chargement;
    double amende_dechargement = provider.amende_dechargement;
    String nom = provider.name;
    String email = provider.email;
    String phone_number = provider.phone_number;
    String entreprise = provider.entreprise;
    String ifu = provider.ifu;
    String entite_nom = provider.entite_name;
    String entite_phone_number = provider.entite_phone_number;
    String entite_entreprise = provider.entite_entreprise;
    String entite_ifu = provider.entite_ifu;
    String address = provider.address;
    String entite_adress = provider.entite_address;
    final service = Provider.of<DBServices>(context);
    List<BonCommandes> ordres = api_provider.ordres;
    BonCommandes ordre = function.ordre(ordres, id);

    if (DelaiChargement.text.isEmpty && delai_chargement > 0) {
      DelaiChargement.text = delai_chargement.toString();
    }

    if (AmendeDelaiChargement.text.isEmpty && amende_delai_chargement > 0) {
      AmendeDelaiChargement.text = amende_delai_chargement.toStringAsFixed(0);
    }

    if (AmendeDechargement.text.isEmpty && amende_dechargement > 0) {
      AmendeDechargement.text = amende_dechargement.toStringAsFixed(0);
    }

    if (Nom.text.isEmpty) {
      Nom.text = nom;
    }

    if (Adress.text.isEmpty) {
      Adress.text = address;
    }

    if (Telephone.text.isEmpty && phone_number.isNotEmpty) {
      Telephone.text = phone_number.substring(4, phone_number.length);
    }

    if (Email.text.isEmpty && email.isNotEmpty) {
      Email.text = email;
    }

    if (Ifu.text.isEmpty) {
      Ifu.text = ifu;
    }

    if (Entreprise.text.isEmpty) {
      Entreprise.text = entreprise;
    }

    if (NomEntite.text.isEmpty) {
      NomEntite.text = entite_nom;
    }

    if (EntiteAdress.text.isEmpty) {
      EntiteAdress.text = entite_adress;
    }

    if (TelephoneEntite.text.isEmpty && entite_phone_number.isNotEmpty) {
      TelephoneEntite.text =
          entite_phone_number.substring(4, entite_phone_number.length);
    }

    if (IfuEntite.text.isEmpty) {
      IfuEntite.text = entite_ifu;
    }

    if (EntrepriseEntite.text.isEmpty) {
      EntrepriseEntite.text = entite_entreprise;
    }

    return Scaffold(
      backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
      drawer: DrawerExpediteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Ordre de transport",
          style: TextStyle(
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.bold,
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
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, right: 10, left: 15, bottom: 50),
              child: Column(
                children: [
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Franchise (Facultatif)",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: DelaiChargement,
                      onChanged: (value) =>
                          provider.change_delai_chargement(value),
                      decoration: InputDecoration(
                          suffixIcon: DelaiChargement.text.isNotEmpty &&
                                  (delai_chargement <= 48)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: DelaiChargement.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (delai_chargement > 0)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0
                              ? "Franchise (Facultatif)"
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
                  DelaiChargement.text.isEmpty
                      ? Container()
                      : delai_chargement <= 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Franchise invalide",
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
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Frais de stationnement au chargement ",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: AmendeDelaiChargement,
                      onChanged: (value) =>
                          provider.change_amende_delai_chargement(value),
                      decoration: InputDecoration(
                          suffixIcon: AmendeDelaiChargement.text.isNotEmpty &&
                                  (amende_delai_chargement <= 0)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: AmendeDelaiChargement.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (amende_delai_chargement > 0)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0
                              ? "Frais de stationnement"
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
                    height: 15,
                  ),
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Frais de stationnement au déchargement ",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: AmendeDechargement,
                      onChanged: (value) =>
                          provider.change_amende_dechargement(value),
                      decoration: InputDecoration(
                          suffixIcon: AmendeDechargement.text.isNotEmpty &&
                                  (amende_dechargement <= 0)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: AmendeDechargement.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (amende_dechargement > 0)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0
                              ? "Frais de déchargement"
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
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Informations du donneiur d'ordre",
                      style: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Nom",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: Nom,
                      onChanged: (value) => provider.change_name(value),
                      decoration: InputDecoration(
                          suffixIcon: Nom.text.isNotEmpty && (nom.length < 3)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Nom.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (nom.length > 3)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Nom" : "",
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
                  Nom.text.isEmpty
                      ? Container()
                      : nom.length < 3
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nom du donneur d'otrdre invalid",
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
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Téléphone",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 65,
                    child: IntlPhoneField(
                      initialCountryCode: 'BJ',
                      controller: Telephone,
                      onChanged: (value) =>
                          provider.change_phone_number(value.completeNumber),
                      decoration: InputDecoration(
                          suffixIcon: Telephone.text.isNotEmpty &&
                                  phone_number.length < 8
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Téléphone" : "",
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
                    height: 8,
                  ),
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email (Facultatif)",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: Email,
                      onChanged: (value) => provider.change_email(value),
                      decoration: InputDecoration(
                          suffixIcon: Email.text.isNotEmpty &&
                                  (!email.contains("@"))
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Email.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (email.contains("@"))
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText:
                              user.dark_mode == 0 ? "Email (Facultatif)" : "",
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
                  Email.text.isEmpty
                      ? Container()
                      : !email.contains("@")
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Email invalid",
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
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Adresse de résidence",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: Adress,
                      onChanged: (value) => provider.change_adress(value),
                      decoration: InputDecoration(
                          suffixIcon: Adress.text.isNotEmpty &&
                                  (address.length < 3)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Adress.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (address.length > 3)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Adresse" : "",
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
                  Adress.text.isEmpty
                      ? Container()
                      : address.length < 3
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Adresse de résidence invalide",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          children: [
                            user.dark_mode == 1
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Entreprise (Facultatif)",
                                        style: TextStyle(
                                          color: MyColors.light,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: Entreprise,
                                onChanged: (value) =>
                                    provider.change_entreprise(value),
                                decoration: InputDecoration(
                                    suffixIcon: Entreprise.text.isNotEmpty &&
                                            (entreprise.length < 3)
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Icon(Icons.error,
                                                color: Colors.red),
                                          )
                                        : null,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Entreprise.text.isEmpty
                                          ? function
                                              .convertHexToColor("#79747E")
                                          : (entreprise.length > 3)
                                              ? MyColors.secondary
                                              : Colors.red,
                                    )),
                                    filled: user.dark_mode == 1 ? true : false,
                                    fillColor: user.dark_mode == 1
                                        ? MyColors.filedDark
                                        : null,
                                    labelText: user.dark_mode == 0
                                        ? "Entreprise (Facultatif)"
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
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          children: [
                            user.dark_mode == 1
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "IFU/Numéro Fiscal (Facultatif) ",
                                        style: TextStyle(
                                          color: MyColors.light,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: Ifu,
                                onChanged: (value) =>
                                    provider.change_ifu(value),
                                decoration: InputDecoration(
                                    suffixIcon:
                                        Ifu.text.isNotEmpty && (ifu.length < 3)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Icon(Icons.error,
                                                    color: Colors.red),
                                              )
                                            : null,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Ifu.text.isEmpty
                                          ? function
                                              .convertHexToColor("#79747E")
                                          : (ifu.length > 3)
                                              ? MyColors.secondary
                                              : Colors.red,
                                    )),
                                    filled: user.dark_mode == 1 ? true : false,
                                    fillColor: user.dark_mode == 1
                                        ? MyColors.filedDark
                                        : null,
                                    labelText: user.dark_mode == 0
                                        ? "IFU/Numéro Fiscal (Facultatif)"
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Informations de l'entité à facturer ",
                      style: TextStyle(
                        color: user.dark_mode == 1
                            ? MyColors.light
                            : MyColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Nom",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: NomEntite,
                      onChanged: (value) => provider.change_entite_name(value),
                      decoration: InputDecoration(
                          suffixIcon: NomEntite.text.isNotEmpty &&
                                  (entite_nom.length < 3)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: NomEntite.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (entite_nom.length > 3)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Nom" : "",
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
                  NomEntite.text.isEmpty
                      ? Container()
                      : entite_nom.length < 3
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nom du l'entité à facturer invalid",
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
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Téléphone",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 65,
                    child: IntlPhoneField(
                      initialCountryCode: 'BJ',
                      controller: TelephoneEntite,
                      onChanged: (value) => provider
                          .change_entite_phone_number(value.completeNumber),
                      decoration: InputDecoration(
                          suffixIcon: TelephoneEntite.text.isNotEmpty &&
                                  entite_phone_number.length < 8
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Téléphone" : "",
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
                    height: 15,
                  ),
                  user.dark_mode == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Adresse de résidence",
                              style: TextStyle(
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: EntiteAdress,
                      onChanged: (value) =>
                          provider.change_entite_adress(value),
                      decoration: InputDecoration(
                          suffixIcon: EntiteAdress.text.isNotEmpty &&
                                  (entite_adress.length < 3)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: EntiteAdress.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (entite_adress.length > 3)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Adresse" : "",
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
                  EntiteAdress.text.isEmpty
                      ? Container()
                      : entite_adress.length < 3
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Adresse de résidence invalide",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          children: [
                            user.dark_mode == 1
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Entreprise (Facultatif)",
                                        style: TextStyle(
                                          color: MyColors.light,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: EntrepriseEntite,
                                onChanged: (value) =>
                                    provider.change_entite_entreprise(value),
                                decoration: InputDecoration(
                                    suffixIcon:
                                        EntrepriseEntite.text.isNotEmpty &&
                                                (entite_entreprise.length < 3)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Icon(Icons.error,
                                                    color: Colors.red),
                                              )
                                            : null,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: EntrepriseEntite.text.isEmpty
                                          ? function
                                              .convertHexToColor("#79747E")
                                          : (entite_entreprise.length > 3)
                                              ? MyColors.secondary
                                              : Colors.red,
                                    )),
                                    filled: user.dark_mode == 1 ? true : false,
                                    fillColor: user.dark_mode == 1
                                        ? MyColors.filedDark
                                        : null,
                                    labelText: user.dark_mode == 0
                                        ? "Entreprise (Facultatif)"
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
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          children: [
                            user.dark_mode == 1
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "IFU/Numéro Fiscal (Facultatif) ",
                                        style: TextStyle(
                                          color: MyColors.light,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: IfuEntite,
                                onChanged: (value) =>
                                    provider.change_entite_ifu(value),
                                decoration: InputDecoration(
                                    suffixIcon: IfuEntite.text.isNotEmpty &&
                                            (entite_ifu.length < 3)
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Icon(Icons.error,
                                                color: Colors.red),
                                          )
                                        : null,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: IfuEntite.text.isEmpty
                                          ? function
                                              .convertHexToColor("#79747E")
                                          : (entite_ifu.length > 3)
                                              ? MyColors.secondary
                                              : Colors.red,
                                    )),
                                    filled: user.dark_mode == 1 ? true : false,
                                    fillColor: user.dark_mode == 1
                                        ? MyColors.filedDark
                                        : null,
                                    labelText: user.dark_mode == 0
                                        ? "IFU/Numéro Fiscal (Facultatif)"
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
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

                          String statut_code = await service.updateOrdre(
                              delai_chargement,
                              amende_delai_chargement,
                              amende_dechargement,
                              email,
                              nom,
                              phone_number,
                              address,
                              entreprise,
                              entite_nom,
                              entite_phone_number,
                              entite_adress,
                              entite_entreprise,
                              ifu,
                              entite_ifu,
                              ordre);
                          if (statut_code == "401") {
                            provider.change_affiche(false);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                "Ordre de transport supprimé",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (statut_code == "100") {
                            provider.change_affiche(false);
                            final snackBar = SnackBar(
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (statut_code == "202") {
                            provider.change_affiche(false);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                "Une erreur inattendue s'est produite",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            final snackBar = SnackBar(
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (statut_code == "500") {
                            provider.change_affiche(false);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                "Une erreur est survenue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (statut_code == "404") {
                            provider.change_affiche(false);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                "L'annonce a égé supprimée",
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
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                "Une erreur inattendu est survenue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (statut_code == "200") {
                            await api_provider.InitForSomeAnnonce();
                            provider.change_affiche(false);
                            provider.reset();
                            Navigator.of(context).pop();
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "L'ordre de transport a été modifié avec succès",
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
                              "Ajoutez l'ordre de transport",
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
          ],
        ),
      ),
    );
  }
}
