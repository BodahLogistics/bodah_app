// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/users/expediteur/marchandises/annoces/add.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../../providers/calculator/index.dart';
import '../../../../../providers/users/expediteur/marchandises/prov_dash_march.dart';
import '../../../../../services/data_base_service.dart';

class PublishAnnonceExp extends StatelessWidget {
  PublishAnnonceExp({super.key});
  TextEditingController Tarif = TextEditingController();
  TextEditingController Quantite = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController Poids = TextEditingController();
  TextEditingController AdresseExp = TextEditingController();
  TextEditingController AdresseLiv = TextEditingController();
  TextEditingController DateChargement = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvPublishAnnonce>(context);
    final calculatrice = Provider.of<ProvCalculator>(context);
    String date_chargement = provider.date_chargement;
    if (DateChargement.text.isEmpty) {
      DateChargement.text = date_chargement;
    }

    String nom = provider.nom;
    int tarif = calculatrice.montant;
    int quantite = provider.quantite;
    int poids = provider.poids;
    String adress_exp = provider.adress_exp;
    String adress_liv = provider.adress_liv;
    Villes ville_exp = provider.ville_exp;
    Villes ville_liv = provider.ville_liv;
    Pays pay_exp = provider.pay_exp;
    Pays pay_liv = provider.pay_liv;
    File? file = provider.file_selected;
    bool upload = provider.upload;
    bool affiche = provider.affiche;
    if (tarif > 0) {
      Tarif.text = tarif.toString();
    }

    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    bool loading = provider.loading;
    List<Pays> pays = api_provider.pays;
    List<Unites> unites = api_provider.unites;
    List<Villes> villes_expedition = provider.villes_expeditions;
    List<Villes> villes_livraison = provider.villes_livraison;
    Unites unite = provider.unite;
    final service = Provider.of<DBServices>(context);
    final changeProvider = Provider.of<ProvChangeDashMarch>(context);
    PageController _pageController =
        PageController(viewportFraction: 0.25, initialPage: 0);

    return loading
        ? Center(
            child: CircularProgressIndicator(
              color: MyColors.secondary,
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, right: 10, left: 15, bottom: 50),
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Que voulez-vous expédier ?",
                                style: TextStyle(
                                  color: MyColors.light,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: user.dark_mode == 1 ? 40 : 35,
                        child: TextField(
                          controller: Name,
                          onChanged: (value) => provider.change_nom(value),
                          decoration: InputDecoration(
                              suffixIcon: Name.text.isNotEmpty &&
                                      (nom.length < 3)
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child:
                                          Icon(Icons.error, color: Colors.red),
                                    )
                                  : null,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Name.text.isEmpty
                                    ? function.convertHexToColor("#79747E")
                                    : (nom.length > 3)
                                        ? MyColors.secondary
                                        : Colors.red,
                              )),
                              filled: user.dark_mode == 1 ? true : false,
                              fillColor: user.dark_mode == 1
                                  ? MyColors.filedDark
                                  : null,
                              labelText: user.dark_mode == 0
                                  ? "Marchandise: Riz, Haricot"
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
                      Name.text.isEmpty
                          ? Container()
                          : nom.length < 3
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Nom de la marchandise invalid",
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
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Tarif d'expédition (Facultatif)",
                                style: TextStyle(
                                  color: MyColors.light,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: user.dark_mode == 1 ? 40 : 35,
                        child: TextField(
                          controller: Tarif,
                          onTap: () {
                            Calculator(context);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Tarif.text.isEmpty
                                    ? function.convertHexToColor("#79747E")
                                    : MyColors.secondary,
                              )),
                              labelText: user.dark_mode == 0
                                  ? "Tarif d'expédition"
                                  : "",
                              filled: user.dark_mode == 1 ? true : false,
                              fillColor: user.dark_mode == 1
                                  ? MyColors.filedDark
                                  : null,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              children: [
                                user.dark_mode == 1
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Pays d'expédition",
                                          style: TextStyle(
                                            color: MyColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: user.dark_mode == 1 ? 48 : 50,
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.dialog(
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        disabledItemFn: (String s) =>
                                            s.startsWith('I'),
                                      ),

                                      items: pays
                                          .map((type) => type.name)
                                          .toList(),
                                      filterFn: (user, filter) => user
                                          .toLowerCase()
                                          .contains(filter.toLowerCase()),

                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: user.dark_mode == 1
                                                    ? ""
                                                    : "Pays d'expédition",
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
                                      dropdownBuilder: (context, selectedItem) {
                                        return Text(
                                          selectedItem ?? '',
                                          style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                          ),
                                        );
                                      },

                                      onChanged: (String? selectedType) async {
                                        if (selectedType != null) {
                                          final pay_selected = pays.firstWhere(
                                            (element) =>
                                                element.name == selectedType,
                                            orElse: () => Pays(id: 0, name: ""),
                                          );
                                          provider
                                              .change_pays_exp(pay_selected);
                                          await provider.getAllVillesExpedition(
                                              pay_selected.id);
                                        }
                                      },
                                      selectedItem: pay_exp
                                          .name, // Remplacez 'null' par le type de compte par défaut si nécessaire
                                    ),
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
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Ville d'expédition",
                                          style: TextStyle(
                                            color: MyColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: user.dark_mode == 1 ? 48 : 50,
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.dialog(
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        disabledItemFn: (String s) =>
                                            s.startsWith('I'),
                                      ),

                                      items: villes_expedition
                                          .map((type) => type.name)
                                          .toList(),
                                      filterFn: (user, filter) => user
                                          .toLowerCase()
                                          .contains(filter.toLowerCase()),

                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: user.dark_mode == 1
                                                    ? ""
                                                    : "Ville d'expédition",
                                                hintText: "Ville d'expédition",
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
                                      dropdownBuilder: (context, selectedItem) {
                                        return Text(
                                          selectedItem ?? '',
                                          style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                          ),
                                        );
                                      },

                                      onChanged: (String? selectedType) {
                                        if (selectedType != null) {
                                          final ville_selected =
                                              villes_livraison.firstWhere(
                                            (element) =>
                                                element.name == selectedType,
                                            orElse: () => Villes(
                                                id: 0, name: "", country_id: 0),
                                          );
                                          provider
                                              .change_ville_exp(ville_selected);
                                        }
                                      },
                                      selectedItem: ville_exp
                                          .name, // Remplacez 'null' par le type de compte par défaut si nécessaire
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              children: [
                                user.dark_mode == 1
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Pays de livraison",
                                          style: TextStyle(
                                            color: MyColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: user.dark_mode == 1 ? 48 : 50,
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.dialog(
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        disabledItemFn: (String s) =>
                                            s.startsWith('I'),
                                      ),

                                      items: pays
                                          .map((type) => type.name)
                                          .toList(),
                                      filterFn: (user, filter) => user
                                          .toLowerCase()
                                          .contains(filter.toLowerCase()),

                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: user.dark_mode == 1
                                                    ? ""
                                                    : "Pays de livraison",
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
                                      dropdownBuilder: (context, selectedItem) {
                                        return Text(
                                          selectedItem ?? '',
                                          style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                          ),
                                        );
                                      },

                                      onChanged: (String? selectedType) async {
                                        if (selectedType != null) {
                                          final pay_selected = pays.firstWhere(
                                            (element) =>
                                                element.name == selectedType,
                                            orElse: () => Pays(id: 0, name: ""),
                                          );
                                          provider
                                              .change_pays_liv(pay_selected);
                                          await provider.getAllVillesLivraison(
                                              pay_selected.id);
                                        }
                                      },
                                      selectedItem: pay_liv
                                          .name, // Remplacez 'null' par le type de compte par défaut si nécessaire
                                    ),
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
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Ville de livraison",
                                          style: TextStyle(
                                            color: MyColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: user.dark_mode == 1 ? 48 : 50,
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.dialog(
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        disabledItemFn: (String s) =>
                                            s.startsWith('I'),
                                      ),

                                      items: villes_livraison
                                          .map((type) => type.name)
                                          .toList(),
                                      filterFn: (user, filter) => user
                                          .toLowerCase()
                                          .contains(filter.toLowerCase()),

                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: user.dark_mode == 1
                                                    ? ""
                                                    : "Ville de livraison",
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
                                      dropdownBuilder: (context, selectedItem) {
                                        return Text(
                                          selectedItem ?? '',
                                          style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                          ),
                                        );
                                      },

                                      onChanged: (String? selectedType) {
                                        if (selectedType != null) {
                                          final ville_selected =
                                              villes_livraison.firstWhere(
                                            (element) =>
                                                element.name == selectedType,
                                            orElse: () => Villes(
                                                id: 0, name: "", country_id: 0),
                                          );
                                          provider
                                              .change_ville_liv(ville_selected);
                                        }
                                      },
                                      selectedItem: ville_liv
                                          .name, // Remplacez 'null' par le type de compte par défaut si nécessaire
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Adresse d'expédition  (Facultatif)",
                                style: TextStyle(
                                  color: MyColors.light,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            controller: AdresseExp,
                            onChanged: (value) {
                              provider.change_adress_exp(value);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: AdresseExp.text.isEmpty
                                      ? function.convertHexToColor("#79747E")
                                      : MyColors.secondary,
                                )),
                                filled: user.dark_mode == 1 ? true : false,
                                fillColor: user.dark_mode == 1
                                    ? MyColors.filedDark
                                    : null,
                                labelText: user.dark_mode == 0
                                    ? "Adresse d'expédition (Facultatif)"
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
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Adresse de livraison (Facultatif)",
                                style: TextStyle(
                                  color: MyColors.light,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            controller: AdresseLiv,
                            onChanged: (value) {
                              provider.change_adress_liv(value);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: AdresseLiv.text.isEmpty
                                      ? function.convertHexToColor("#79747E")
                                      : MyColors.secondary,
                                )),
                                filled: user.dark_mode == 1 ? true : false,
                                fillColor: user.dark_mode == 1
                                    ? MyColors.filedDark
                                    : null,
                                labelText: user.dark_mode == 0
                                    ? "Adresse de livraison (Facultatif)"
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
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              children: [
                                user.dark_mode == 1
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Poids (Facultatif)",
                                          style: TextStyle(
                                            color: MyColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: SizedBox(
                                    height: 40,
                                    child: TextField(
                                      onChanged: (value) {
                                        provider.change_poids(value);
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: Poids,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Poids.text.isEmpty
                                                ? function.convertHexToColor(
                                                    "#79747E")
                                                : MyColors.secondary,
                                          )),
                                          filled: user.dark_mode == 1
                                              ? true
                                              : false,
                                          fillColor: user.dark_mode == 1
                                              ? MyColors.filedDark
                                              : null,
                                          labelText: user.dark_mode == 0
                                              ? "Poids (Facultatif)"
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
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              children: [
                                user.dark_mode == 1
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Unité",
                                          style: TextStyle(
                                            color: MyColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: user.dark_mode == 1 ? 40 : 50,
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.dialog(
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        disabledItemFn: (String s) =>
                                            s.startsWith('I'),
                                      ),

                                      items: unites
                                          .map((type) => type.name)
                                          .toList(),
                                      filterFn: (user, filter) => user
                                          .toLowerCase()
                                          .contains(filter.toLowerCase()),

                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: user.dark_mode == 1
                                                    ? ""
                                                    : "Unité",
                                                hintText: "Unité",
                                                labelStyle: TextStyle(
                                                    color: user.dark_mode == 1
                                                        ? MyColors.light
                                                        : MyColors.black,
                                                    fontSize: 14,
                                                    fontFamily: "Poppins"),
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black,
                                                )),
                                      ),
                                      dropdownBuilder: (context, selectedItem) {
                                        return Text(
                                          selectedItem ?? '',
                                          style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                            fontFamily: "Poppins",
                                          ),
                                        );
                                      },

                                      onChanged: (String? selectedType) {
                                        if (selectedType != null) {
                                          final unite_selected =
                                              unites.firstWhere((element) =>
                                                  element.name == selectedType);
                                          provider.change_unite(unite_selected);
                                        }
                                      },
                                      selectedItem: unite
                                          .name, // Remplacez 'null' par le type de compte par défaut si nécessaire
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              children: [
                                user.dark_mode == 1
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Quantité (Facultatif)",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: MyColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 40,
                                  child: TextField(
                                    onChanged: (value) {
                                      provider.change_quantite(value);
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    controller: Quantite,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Quantite.text.isEmpty
                                              ? function
                                                  .convertHexToColor("#79747E")
                                              : MyColors.secondary,
                                        )),
                                        filled:
                                            user.dark_mode == 1 ? true : false,
                                        fillColor: user.dark_mode == 1
                                            ? MyColors.filedDark
                                            : null,
                                        labelText: user.dark_mode == 0
                                            ? "Quantité (Facultatif)"
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
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Date",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: MyColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: 40,
                                    child: TextField(
                                      controller: DateChargement,
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                          context: context,
                                          locale: const Locale('fr', 'FR'),
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2101),
                                        );
                                        if (picked != null) {
                                          String format =
                                              DateFormat("yyyy-MM-dd")
                                                  .format(picked);
                                          DateChargement.text = format;
                                          provider
                                              .change_date_chargement(format);
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: DateChargement.text.isEmpty
                                                ? function.convertHexToColor(
                                                    "#79747E")
                                                : MyColors.secondary,
                                          )),
                                          filled: user.dark_mode == 1
                                              ? true
                                              : false,
                                          fillColor: user.dark_mode == 1
                                              ? MyColors.filedDark
                                              : null,
                                          labelText: user.dark_mode == 0
                                              ? "Date de chargement"
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
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        onPressed: () async {},
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            color: MyColors.secondary.withOpacity(.2),
                            child: DottedBorder(
                              color: Colors.black45,
                              strokeWidth: 2,
                              dashPattern: [
                                6,
                                3
                              ], // Ajustez le motif des tirets ici
                              borderType: BorderType.RRect,
                              radius: Radius.circular(
                                  4), // Si vous voulez des coins arrondis
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.file_open,
                                        color: MyColors.secondary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Joindre l'image de la marchandise",
                                      style: TextStyle(
                                        color: MyColors.secondary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    upload
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              CircularProgressIndicator(
                                                color: MyColors.light,
                                              )
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Seulement que des fichiers png, jpg, pdf",
                                      style: TextStyle(
                                        color: MyColors.textColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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

                              String statut_code = await service.publishAnnonce(
                                  date_chargement,
                                  nom,
                                  unite,
                                  poids,
                                  quantite,
                                  tarif,
                                  pay_exp,
                                  pay_liv,
                                  adress_exp,
                                  adress_liv,
                                  ville_exp,
                                  ville_liv,
                                  file);

                              if (statut_code == "100") {
                                provider.change_affiche(false);
                                final snackBar = SnackBar(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      left: MediaQuery.of(context).size.width *
                                          0.3,
                                      right: 5),
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
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      left: MediaQuery.of(context).size.width *
                                          0.3,
                                      right: 5),
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
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      left: MediaQuery.of(context).size.width *
                                          0.3,
                                      right: 5),
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
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      left: MediaQuery.of(context).size.width *
                                          0.3,
                                      right: 5),
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                    "Une erreur s'est produite. Vérifier votre connection internet et réessayer",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins"),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                provider.change_affiche(false);
                                provider.reset();
                                changeProvider.change_index(0);
                                double screen =
                                    MediaQuery.of(context).size.height;
                                int data = screen.toInt();
                                _pageController.animateToPage(
                                  0 * data,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );

                                final snackBar = SnackBar(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      left: MediaQuery.of(context).size.width *
                                          0.3,
                                      right: 5),
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    "Votre annonce a été publiée avec succès",
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
                                        padding:
                                            const EdgeInsets.only(right: 15),
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
                                  "Publiez l'annonce",
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
          );
  }
}

Future<dynamic> Calculator(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvCalculator>(dialogcontext);
        String display = provider.display;
        return AlertDialog(
          title: Text(
            display,
            style: TextStyle(
                color: MyColors.black,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '7'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '8'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '9'),
                  ),
                  buildButton(dialogcontext, '/'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '4'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '5'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '6'),
                  ),
                  buildButton(dialogcontext, '*'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '1'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '2'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '3'),
                  ),
                  buildButton(dialogcontext, '-'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, 'C'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '0'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: buildButton(dialogcontext, '='),
                  ),
                  buildButton(dialogcontext, '+'),
                ],
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 30,
                  child: TextButton(
                      onPressed: () {
                        provider.delete();
                      },
                      child: Text(
                        "Supprimer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontFamily: "Poppins",
                        ),
                      )),
                ),
                SizedBox(
                  height: 30,
                  child: TextButton(
                      onPressed: () {
                        provider.clearAll();
                        Navigator.of(dialogcontext).pop();
                      },
                      child: Text(
                        "Annulez",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.secondDark,
                          fontFamily: "Poppins",
                        ),
                      )),
                ),
                SizedBox(
                  height: 30,
                  child: TextButton(
                      onPressed: () {
                        provider.change_montant(display);
                        provider.clearAll();
                        Navigator.of(dialogcontext).pop();
                      },
                      child: Text(
                        "Insérez",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.secondary,
                          fontFamily: "Poppins",
                        ),
                      )),
                ),
              ],
            ),
          ],
        );
      });
}

Widget buildButton(BuildContext context, String text) {
  final provider = Provider.of<ProvCalculator>(context);
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
    onPressed: () {
      if (text == 'C') {
        provider.clearAll();
      } else if (text == "=") {
        provider.evaluate();
      } else {
        provider.addDigit(text);
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    ),
  );
}
