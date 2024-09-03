// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/camions.dart';
import 'package:bodah/modals/chargement_effectues.dart';
import 'package:bodah/modals/conducteur.dart';
import 'package:bodah/modals/livraison_cargaison.dart';
import 'package:bodah/modals/pieces.dart';
import 'package:bodah/modals/tarifs.dart';
import 'package:bodah/providers/users/expediteur/import/transp/add.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../modals/cargaison.dart';
import '../../../../modals/cargaison_client.dart';
import '../../../../modals/chargement.dart';
import '../../../../modals/pays.dart';
import '../../../../modals/positions.dart';
import '../../../../modals/users.dart';
import '../../../../modals/villes.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../providers/users/expediteur/import/add.dart';
import '../../../../services/data_base_service.dart';
import '../drawer/index.dart';
import '../marchandises/nav_bottom/index.dart';

class NewImportRoute extends StatefulWidget {
  NewImportRoute({super.key});

  @override
  State<NewImportRoute> createState() => _NewImportRouteState();
}

class _NewImportRouteState extends State<NewImportRoute> {
  TextEditingController Tarif = TextEditingController();
  TextEditingController Accompte = TextEditingController();
  TextEditingController Solde = TextEditingController();
  TextEditingController Quantite = TextEditingController();
  TextEditingController ClientName = TextEditingController();
  TextEditingController Marchandise = TextEditingController();
  TextEditingController DateDebut = TextEditingController();
  TextEditingController DateFin = TextEditingController();
  TextEditingController ConducteurName = TextEditingController();
  TextEditingController Permis = TextEditingController();
  TextEditingController Immatriculation = TextEditingController();
  TextEditingController ClientTelephone = TextEditingController();
  TextEditingController ConducteurTelephone = TextEditingController();
  TextEditingController Observation = TextEditingController();
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvAddImport>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
      Provider.of<ApiProvider>(context, listen: false).InitImportData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvAddImport>(context);

    String date_deut = provider.date_debut;
    String date_fin = provider.date_fin;
    if (DateDebut.text.isEmpty) {
      DateDebut.text = date_deut;
    }

    String marchandise = provider.marchandise;
    double tarif = provider.tarif;
    double accompte = provider.accompte;
    double solde = provider.solde;
    int quantite = provider.quantite;
    String client_name = provider.client_name;
    String client_telephone = provider.client_telephone;
    String conducteur_name = provider.conducteur_name;
    String conducteur_telephone = provider.cond_telephone;
    String permis = provider.permis;
    String immatriculation = provider.immatriculation;
    Villes ville_exp = provider.ville_exp;
    Villes ville_liv = provider.ville_liv;
    Pays pay_exp = provider.pay_exp;
    Pays pay_liv = provider.pay_liv;
    String observation = provider.observation;
    bool affiche = provider.affiche;

    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    bool loading = provider.loading;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes_expedition = provider.villes_expeditions;
    List<Villes> villes_livraison = provider.villes_livraison;
    final service = Provider.of<DBServices>(context);

    if (solde > 0) {
      Solde.text = solde.toString();
    }

    int import_key = api_provider.import_route_key;
    List<Cargaison> cargaisons = api_provider.cargaisons;
    cargaisons = function.import_cargaisons(cargaisons, import_key);
    List<ChargementEffectue> chargement_effectues =
        api_provider.chargement_effectues;
    chargement_effectues =
        function.import_chargemnt_effectues(chargement_effectues, import_key);
    List<LivraisonCargaison> livraisons = api_provider.livraisons;
    livraisons = function.import_livraisons(livraisons, import_key);
    List<CargaisonClient> cargaison_client = api_provider.cargaison_clients;
    List<Chargement> chargements = api_provider.chargements;

    return Scaffold(
      backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
      bottomNavigationBar: NavigBot(),
      drawer: DrawerExpediteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Importation",
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
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.secondary,
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40, right: 10, left: 15, bottom: 50),
                    child: Column(
                      children: [
                        user.dark_mode == 1
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nom du client",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: MyColors.light,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: ClientName,
                            onChanged: (value) =>
                                provider.change_client_name(value),
                            decoration: InputDecoration(
                                suffixIcon: ClientName.text.isNotEmpty &&
                                        (client_name.length < 3)
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Icon(Icons.error,
                                            color: Colors.red),
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: ClientName.text.isEmpty
                                      ? function.convertHexToColor("#79747E")
                                      : (client_name.length > 3)
                                          ? MyColors.secondary
                                          : Colors.red,
                                )),
                                filled: user.dark_mode == 1 ? true : false,
                                fillColor: user.dark_mode == 1
                                    ? MyColors.filedDark
                                    : null,
                                labelText:
                                    user.dark_mode == 0 ? "Nom du client" : "",
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
                        ClientName.text.isEmpty
                            ? Container()
                            : client_name.length < 3
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
                        SizedBox(
                          height: 15,
                        ),
                        user.dark_mode == 1
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Contact du client",
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
                            controller: ClientTelephone,
                            onChanged: (value) => provider
                                .change_client_telephone(value.completeNumber),
                            decoration: InputDecoration(
                                suffixIcon: ClientTelephone.text.isNotEmpty &&
                                        client_telephone.length < 8
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Icon(Icons.error,
                                            color: Colors.red),
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide()),
                                filled: user.dark_mode == 1 ? true : false,
                                fillColor: user.dark_mode == 1
                                    ? MyColors.filedDark
                                    : null,
                                labelText: user.dark_mode == 0
                                    ? "Contact du client"
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
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Column(
                                  children: [
                                    user.dark_mode == 1
                                        ? Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Marchandise",
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
                                        maxLength: 15,
                                        controller: Marchandise,
                                        onChanged: (value) =>
                                            provider.change_marchandise(value),
                                        decoration: InputDecoration(
                                            suffixIcon: Marchandise
                                                        .text.isNotEmpty &&
                                                    (marchandise.length < 3)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  )
                                                : null,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Marchandise.text.isEmpty
                                                  ? function.convertHexToColor(
                                                      "#79747E")
                                                  : (marchandise.length > 3)
                                                      ? MyColors.secondary
                                                      : Colors.red,
                                            )),
                                            filled: user.dark_mode == 1
                                                ? true
                                                : false,
                                            fillColor: user.dark_mode == 1
                                                ? MyColors.filedDark
                                                : null,
                                            labelText: user.dark_mode == 0
                                                ? "Marchandise"
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
                                    Marchandise.text.isEmpty
                                        ? Container()
                                        : marchandise.length < 3
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Champ invalid",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Column(
                                children: [
                                  user.dark_mode == 1
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Quantité",
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
                                    height: 60,
                                    child: TextField(
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      controller: Quantite,
                                      onChanged: (value) =>
                                          provider.change_quantite(value),
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Quantite.text.isNotEmpty &&
                                                      (quantite < 1)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Icon(Icons.error,
                                                          color: Colors.red),
                                                    )
                                                  : null,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Quantite.text.isEmpty
                                                ? function.convertHexToColor(
                                                    "#79747E")
                                                : (quantite > 0)
                                                    ? MyColors.secondary
                                                    : Colors.red,
                                          )),
                                          filled: user.dark_mode == 1
                                              ? true
                                              : false,
                                          fillColor: user.dark_mode == 1
                                              ? MyColors.filedDark
                                              : null,
                                          labelText: user.dark_mode == 0
                                              ? "Quantité"
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                                            "Pays de départ",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
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
                                                      : "Pays de départ",
                                                  labelStyle:
                                                      TextStyle(
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Poppins"),
                                                  hintStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "Poppins",
                                                      color: MyColors.black)),
                                        ),
                                        dropdownBuilder:
                                            (context, selectedItem) {
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

                                        onChanged:
                                            (String? selectedType) async {
                                          if (selectedType != null) {
                                            final pay_selected =
                                                pays.firstWhere(
                                              (element) =>
                                                  element.name == selectedType,
                                              orElse: () =>
                                                  Pays(id: 0, name: ""),
                                            );
                                            provider
                                                .change_pays_exp(pay_selected);
                                            await provider
                                                .getAllVillesExpedition(
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
                                            "Ville de départ",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
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
                                                      : "Ville de départ",
                                                  labelStyle:
                                                      TextStyle(
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Poppins"),
                                                  hintStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "Poppins",
                                                      color: MyColors.black)),
                                        ),
                                        dropdownBuilder:
                                            (context, selectedItem) {
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
                                                  id: 0,
                                                  name: "",
                                                  country_id: 0),
                                            );
                                            provider.change_ville_exp(
                                                ville_selected);
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
                                            "Pays de destination",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
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
                                                      : "Pays de destination",
                                                  labelStyle:
                                                      TextStyle(
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Poppins"),
                                                  hintStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "Poppins",
                                                      color: MyColors.black)),
                                        ),
                                        dropdownBuilder:
                                            (context, selectedItem) {
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

                                        onChanged:
                                            (String? selectedType) async {
                                          if (selectedType != null) {
                                            final pay_selected =
                                                pays.firstWhere(
                                              (element) =>
                                                  element.name == selectedType,
                                              orElse: () =>
                                                  Pays(id: 0, name: ""),
                                            );
                                            provider
                                                .change_pays_liv(pay_selected);
                                            await provider
                                                .getAllVillesLivraison(
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
                                            "Ville de destination",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
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
                                                      : "Ville de destination",
                                                  labelStyle:
                                                      TextStyle(
                                                          color:
                                                              user.dark_mode ==
                                                                      1
                                                                  ? MyColors
                                                                      .light
                                                                  : MyColors
                                                                      .black,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Poppins"),
                                                  hintStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "Poppins",
                                                      color: MyColors.black)),
                                        ),
                                        dropdownBuilder:
                                            (context, selectedItem) {
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
                                                  id: 0,
                                                  name: "",
                                                  country_id: 0),
                                            );
                                            provider.change_ville_liv(
                                                ville_selected);
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
                                            "Début",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
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
                                        controller: DateDebut,
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
                                            DateDebut.text = format;
                                            provider.change_date_debut(format);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: DateDebut.text.isEmpty
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
                                                ? "Date de début"
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
                                            "Fin",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
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
                                        controller: DateFin,
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
                                            DateFin.text = format;
                                            provider.change_date_fin(format);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: DateFin.text.isEmpty
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
                                                ? "Date de fin"
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
                        user.dark_mode == 1
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nom du chauffeur",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: MyColors.light,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: ConducteurName,
                            onChanged: (value) =>
                                provider.change_conducteur_name(value),
                            decoration: InputDecoration(
                                suffixIcon: ConducteurName.text.isNotEmpty &&
                                        (conducteur_name.length < 3)
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Icon(Icons.error,
                                            color: Colors.red),
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: ConducteurName.text.isEmpty
                                      ? function.convertHexToColor("#79747E")
                                      : (conducteur_name.length > 3)
                                          ? MyColors.secondary
                                          : Colors.red,
                                )),
                                filled: user.dark_mode == 1 ? true : false,
                                fillColor: user.dark_mode == 1
                                    ? MyColors.filedDark
                                    : null,
                                labelText: user.dark_mode == 0
                                    ? "Nom du chauffeur"
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
                        ConducteurName.text.isEmpty
                            ? Container()
                            : conducteur_name.length < 3
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
                        SizedBox(
                          height: 15,
                        ),
                        user.dark_mode == 1
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Contact du chauffeur",
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
                            controller: ConducteurTelephone,
                            onChanged: (value) =>
                                provider.change_conducteur_telephone(
                                    value.completeNumber),
                            decoration: InputDecoration(
                                suffixIcon: ConducteurTelephone
                                            .text.isNotEmpty &&
                                        conducteur_telephone.length < 8
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Icon(Icons.error,
                                            color: Colors.red),
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide()),
                                filled: user.dark_mode == 1 ? true : false,
                                fillColor: user.dark_mode == 1
                                    ? MyColors.filedDark
                                    : null,
                                labelText: user.dark_mode == 0
                                    ? "Contact du chauffeur"
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
                                              "N° Permis",
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
                                        maxLength: 13,
                                        controller: Permis,
                                        onChanged: (value) =>
                                            provider.change_permis(value),
                                        decoration: InputDecoration(
                                            suffixIcon: Permis
                                                        .text.isNotEmpty &&
                                                    (permis.length < 3)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  )
                                                : null,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Permis.text.isEmpty
                                                  ? function.convertHexToColor(
                                                      "#79747E")
                                                  : (permis.length > 3)
                                                      ? MyColors.secondary
                                                      : Colors.red,
                                            )),
                                            filled: user.dark_mode == 1
                                                ? true
                                                : false,
                                            fillColor: user.dark_mode == 1
                                                ? MyColors.filedDark
                                                : null,
                                            labelText: user.dark_mode == 0
                                                ? "N° Permis"
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
                                    Permis.text.isEmpty
                                        ? Container()
                                        : permis.length < 3
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Numéro invalid",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Column(
                                  children: [
                                    user.dark_mode == 1
                                        ? Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Immatriculation",
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
                                        maxLength: 15,
                                        controller: Immatriculation,
                                        onChanged: (value) => provider
                                            .change_immatriculation(value),
                                        decoration: InputDecoration(
                                            suffixIcon: Immatriculation
                                                        .text.isNotEmpty &&
                                                    (immatriculation.length < 3)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  )
                                                : null,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Immatriculation
                                                      .text.isEmpty
                                                  ? function.convertHexToColor(
                                                      "#79747E")
                                                  : (immatriculation.length > 3)
                                                      ? MyColors.secondary
                                                      : Colors.red,
                                            )),
                                            filled: user.dark_mode == 1
                                                ? true
                                                : false,
                                            fillColor: user.dark_mode == 1
                                                ? MyColors.filedDark
                                                : null,
                                            labelText: user.dark_mode == 0
                                                ? "Immatriculation"
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
                                    Immatriculation.text.isEmpty
                                        ? Container()
                                        : immatriculation.length < 3
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "N° Camion invalid",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5,
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
                                              "Tarif",
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
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        controller: Tarif,
                                        onChanged: (value) =>
                                            provider.change_tarif(value),
                                        decoration: InputDecoration(
                                            suffixIcon: Tarif.text.isNotEmpty &&
                                                    (tarif < 0 ||
                                                        tarif < accompte)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  )
                                                : null,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Tarif.text.isEmpty
                                                  ? function.convertHexToColor(
                                                      "#79747E")
                                                  : (tarif > 0 &&
                                                          tarif >= accompte)
                                                      ? MyColors.secondary
                                                      : Colors.red,
                                            )),
                                            filled: user.dark_mode == 1
                                                ? true
                                                : false,
                                            fillColor: user.dark_mode == 1
                                                ? MyColors.filedDark
                                                : null,
                                            labelText: user.dark_mode == 0
                                                ? "Tarif"
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
                                    Tarif.text.isEmpty
                                        ? Container()
                                        : tarif < 1 || tarif < accompte
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tarif invalid",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Column(
                                  children: [
                                    user.dark_mode == 1
                                        ? Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Accompte",
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
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        controller: Accompte,
                                        onChanged: (value) =>
                                            provider.change_accompte(value),
                                        decoration: InputDecoration(
                                            suffixIcon: Accompte
                                                        .text.isNotEmpty &&
                                                    (accompte < 0 ||
                                                        tarif < accompte)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  )
                                                : null,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Accompte.text.isEmpty
                                                  ? function.convertHexToColor(
                                                      "#79747E")
                                                  : (accompte > 0 &&
                                                          tarif >= accompte)
                                                      ? MyColors.secondary
                                                      : Colors.red,
                                            )),
                                            filled: user.dark_mode == 1
                                                ? true
                                                : false,
                                            fillColor: user.dark_mode == 1
                                                ? MyColors.filedDark
                                                : null,
                                            labelText: user.dark_mode == 0
                                                ? "Accompte"
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
                                    Accompte.text.isEmpty
                                        ? Container()
                                        : accompte < 1 || tarif < accompte
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Accompte invalid",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Column(children: [
                                  user.dark_mode == 1
                                      ? Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Solde",
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
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      enabled: false,
                                      controller: Solde,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Tarif.text.isEmpty
                                                ? function.convertHexToColor(
                                                    "#79747E")
                                                : (tarif > 0 &&
                                                        tarif >= accompte)
                                                    ? MyColors.secondary
                                                    : Colors.red,
                                          )),
                                          filled: user.dark_mode == 1
                                              ? true
                                              : false,
                                          fillColor: user.dark_mode == 1
                                              ? MyColors.filedDark
                                              : null,
                                          labelText: user.dark_mode == 0
                                              ? "Solde"
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
                                ])),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Column(
                                  children: [
                                    user.dark_mode == 1
                                        ? Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Observation",
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
                                        maxLength: 15,
                                        controller: Observation,
                                        onChanged: (value) =>
                                            provider.change_observation(value),
                                        decoration: InputDecoration(
                                            suffixIcon: Observation
                                                        .text.isNotEmpty &&
                                                    (observation.length < 3)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  )
                                                : null,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Observation.text.isEmpty
                                                  ? function.convertHexToColor(
                                                      "#79747E")
                                                  : (observation.length > 3)
                                                      ? MyColors.secondary
                                                      : Colors.red,
                                            )),
                                            filled: user.dark_mode == 1
                                                ? true
                                                : false,
                                            fillColor: user.dark_mode == 1
                                                ? MyColors.filedDark
                                                : null,
                                            labelText: user.dark_mode == 0
                                                ? "Observation"
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
                                    Observation.text.isEmpty
                                        ? Container()
                                        : observation.length < 3
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Observation invalide",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 35,
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: MyColors.secondary,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    onPressed: () {
                                      if (chargement_effectues.isEmpty) {
                                        NewTransp(context, import_key);
                                      } else {
                                        showTransp(context, import_key);
                                      }
                                    },
                                    child: chargement_effectues.isNotEmpty
                                        ? Text(
                                            "Transporteurs",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: MyColors.secondary,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500),
                                          )
                                        : Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 2),
                                                child: Icon(
                                                  Icons.add,
                                                  color: MyColors.secondary,
                                                ),
                                              ),
                                              Text(
                                                "Transporteur",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: MyColors.secondary,
                                                    fontFamily: "Poppins",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          )),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: MyColors.secondary,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: MyColors.secondary,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "Marchandise",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: MyColors.secondary,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: MyColors.secondary,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: MyColors.secondary,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "Livraison",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: MyColors.secondary,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
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
                                    "Enregistrez",
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

Future<dynamic> NewTransp(BuildContext context, int import_id) {
  TextEditingController Tarif = TextEditingController();
  TextEditingController Accompte = TextEditingController();
  TextEditingController Solde = TextEditingController();
  TextEditingController ConducteurName = TextEditingController();
  TextEditingController Permis = TextEditingController();
  TextEditingController Immatriculation = TextEditingController();
  TextEditingController ConducteurTelephone = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final api_provider = Provider.of<ApiProvider>(dialocontext);
      final provider = Provider.of<ProvAddTransp>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool affiche = provider.affiche;
      double tarif = provider.tarif;
      double accompte = provider.accompte;
      double solde = provider.solde;
      String conducteur_name = provider.conducteur_name;
      String conducteur_telephone = provider.cond_telephone;
      String permis = provider.permis;
      String immatriculation = provider.immatriculation;
      Villes ville_exp = provider.ville_exp;
      Villes ville_liv = provider.ville_liv;
      Pays pay_exp = provider.pay_exp;
      Pays pay_liv = provider.pay_liv;

      List<Pays> pays = api_provider.pays;
      List<Villes> villes_expedition = provider.villes_expeditions;
      List<Villes> villes_livraison = provider.villes_livraison;
      final user = api_provider.user;

      if (solde > 0) {
        Solde.text = solde.toStringAsFixed(0);
      }

      return AlertDialog(
        title: Text(
          "Nouveau transporteur",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Pays départ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
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
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),

                            items: pays.map((type) => type.name).toList(),
                            filterFn: (user, filter) => user
                                .toLowerCase()
                                .contains(filter.toLowerCase()),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText:
                                      user.dark_mode == 1 ? "" : "Pays départ",
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
                                  (element) => element.name == selectedType,
                                  orElse: () => Pays(id: 24, name: ""),
                                );
                                provider.change_pays_exp(pay_selected);
                                await provider
                                    .getAllVillesExpedition(pay_selected.id);
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
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ville départ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
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
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),

                            items: villes_expedition
                                .map((type) => type.name)
                                .toList(),
                            filterFn: (user, filter) => user
                                .toLowerCase()
                                .contains(filter.toLowerCase()),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText:
                                      user.dark_mode == 1 ? "" : "Ville départ",
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
                                  (element) => element.name == selectedType,
                                  orElse: () =>
                                      Villes(id: 9626, name: "", country_id: 0),
                                );
                                provider.change_ville_exp(ville_selected);
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Pays destination",
                                style: TextStyle(
                                  fontFamily: "Poppins",
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
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),

                            items: pays.map((type) => type.name).toList(),
                            filterFn: (user, filter) => user
                                .toLowerCase()
                                .contains(filter.toLowerCase()),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: user.dark_mode == 1
                                      ? ""
                                      : "Pays destination",
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
                                  (element) => element.name == selectedType,
                                  orElse: () => Pays(id: 24, name: ""),
                                );
                                provider.change_pays_liv(pay_selected);
                                await provider
                                    .getAllVillesLivraison(pay_selected.id);
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
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ville de destination",
                                style: TextStyle(
                                  fontFamily: "Poppins",
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
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),

                            items: villes_livraison
                                .map((type) => type.name)
                                .toList(),
                            filterFn: (user, filter) => user
                                .toLowerCase()
                                .contains(filter.toLowerCase()),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: user.dark_mode == 1
                                      ? ""
                                      : "Ville destination",
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
                                  (element) => element.name == selectedType,
                                  orElse: () =>
                                      Villes(id: 9626, name: "", country_id: 0),
                                );
                                provider.change_ville_liv(ville_selected);
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
              height: 15,
            ),
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nom du chauffeur",
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
                maxLength: 25,
                controller: ConducteurName,
                onChanged: (value) => provider.change_conducteur_name(value),
                decoration: InputDecoration(
                    suffixIcon: ConducteurName.text.isNotEmpty &&
                            (conducteur_name.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: ConducteurName.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (conducteur_name.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Nom du chauffeur" : "",
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
            ConducteurName.text.isEmpty
                ? Container()
                : conducteur_name.length < 3
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
            user.dark_mode == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Contact du chauffeur",
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
                controller: ConducteurTelephone,
                onChanged: (value) =>
                    provider.change_conducteur_telephone(value.completeNumber),
                decoration: InputDecoration(
                    suffixIcon: ConducteurTelephone.text.isNotEmpty &&
                            conducteur_telephone.length < 8
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText:
                        user.dark_mode == 0 ? "Contact du chauffeur" : "",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "N° Permis",
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
                maxLength: 15,
                controller: Permis,
                onChanged: (value) => provider.change_permis(value),
                decoration: InputDecoration(
                    suffixIcon: Permis.text.isNotEmpty && (permis.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Permis.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (permis.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "N° Permis" : "",
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
            Permis.text.isEmpty
                ? Container()
                : permis.length < 3
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Numéro invalid",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Immatriculation",
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
                maxLength: 15,
                controller: Immatriculation,
                onChanged: (value) => provider.change_immatriculation(value),
                decoration: InputDecoration(
                    suffixIcon: Immatriculation.text.isNotEmpty &&
                            (immatriculation.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Immatriculation.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (immatriculation.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Immatriculation" : "",
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
            Immatriculation.text.isEmpty
                ? Container()
                : immatriculation.length < 3
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "N° Camion invalid",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tarif",
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
                maxLength: 15,
                keyboardType: TextInputType.number,
                controller: Tarif,
                onChanged: (value) => provider.change_tarif(value),
                decoration: InputDecoration(
                    suffixIcon:
                        Tarif.text.isNotEmpty && (tarif < 0 || tarif < accompte)
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(Icons.error, color: Colors.red),
                              )
                            : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Tarif.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (tarif > 0 && tarif >= accompte)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Tarif" : "",
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
            Tarif.text.isEmpty
                ? Container()
                : tarif < 1 || tarif < accompte
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tarif invalid",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Accompte",
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
                maxLength: 15,
                keyboardType: TextInputType.number,
                controller: Accompte,
                onChanged: (value) => provider.change_accompte(value),
                decoration: InputDecoration(
                    suffixIcon: Accompte.text.isNotEmpty &&
                            (accompte < 0 || tarif < accompte)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Accompte.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (accompte > 0 && tarif >= accompte)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Accompte" : "",
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
            Accompte.text.isEmpty
                ? Container()
                : accompte < 1 || tarif < accompte
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Accompte invalid",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Solde",
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
                maxLength: 10,
                keyboardType: TextInputType.number,
                enabled: false,
                controller: Solde,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Tarif.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (tarif > 0 && tarif >= accompte)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Solde" : "",
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
              height: 5,
            ),
          ],
        )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      Navigator.of(dialocontext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);
                          String statut_code = await service.addTransp(
                              conducteur_name,
                              permis,
                              conducteur_telephone,
                              immatriculation,
                              pay_exp,
                              ville_exp,
                              pay_liv,
                              ville_liv,
                              tarif,
                              accompte);

                          if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialocontext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialocontext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "500") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialocontext,
                                "Une erreur est survenue. Vérifie si tous les champs sont bien renseignés",
                                Colors.redAccent);
                          } else {
                            await api_provider.InitChargementEffectue();
                            provider.reset();
                            showCustomSnackBar(
                                dialocontext,
                                "Le transporteur a été ajouté avec succès",
                                Colors.green);
                            Navigator.of(dialocontext).pop();
                          }
                        },
                  child: affiche
                      ? Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: MyColors.light,
                            ),
                          ),
                        )
                      : Text(
                          "Ajoutez",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyColors.light,
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> UpdateTransp(
    BuildContext context, ChargementEffectue chargement_effectue) {
  TextEditingController Tarif = TextEditingController();
  TextEditingController Accompte = TextEditingController();
  TextEditingController Solde = TextEditingController();
  TextEditingController ConducteurName = TextEditingController();
  TextEditingController Permis = TextEditingController();
  TextEditingController Immatriculation = TextEditingController();
  TextEditingController ConducteurTelephone = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final api_provider = Provider.of<ApiProvider>(dialocontext);
      final provider = Provider.of<ProvAddTransp>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool affiche = provider.affiche;
      double tarif = provider.tarif;
      double accompte = provider.accompte;
      double solde = provider.solde;
      String conducteur_name = provider.conducteur_name;
      String conducteur_telephone = provider.cond_telephone;
      String permis = provider.permis;
      String immatriculation = provider.immatriculation;
      Villes ville_exp = provider.ville_exp;
      Villes ville_liv = provider.ville_liv;
      Pays pay_exp = provider.pay_exp;
      Pays pay_liv = provider.pay_liv;

      List<Pays> pays = api_provider.pays;
      List<Villes> villes_expedition = provider.villes_expeditions;
      List<Villes> villes_livraison = provider.villes_livraison;
      final user = api_provider.user;

      if (solde > 0) {
        Solde.text = solde.toStringAsFixed(0);
      }

      if (tarif > 0 && Tarif.text.isEmpty) {
        Tarif.text = tarif.toStringAsFixed(0);
      }

      if (accompte > 0 && Accompte.text.isEmpty) {
        Accompte.text = accompte.toStringAsFixed(0);
      }

      if (conducteur_name.isNotEmpty && ConducteurName.text.isEmpty) {
        ConducteurName.text = conducteur_name;
      }

      if (conducteur_telephone.isNotEmpty && ConducteurTelephone.text.isEmpty) {
        ConducteurTelephone.text =
            conducteur_telephone.substring(4, conducteur_telephone.length);
      }

      if (permis.isNotEmpty && Permis.text.isEmpty) {
        Permis.text = permis;
      }

      if (immatriculation.isNotEmpty && Immatriculation.text.isEmpty) {
        Immatriculation.text = immatriculation;
      }

      return AlertDialog(
        title: Text(
          "Transporteur",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Pays départ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
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
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),

                            items: pays.map((type) => type.name).toList(),
                            filterFn: (user, filter) => user
                                .toLowerCase()
                                .contains(filter.toLowerCase()),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText:
                                      user.dark_mode == 1 ? "" : "Pays départ",
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
                                  (element) => element.name == selectedType,
                                  orElse: () => Pays(id: 24, name: ""),
                                );
                                provider.change_pays_exp(pay_selected);
                                await provider
                                    .getAllVillesExpedition(pay_selected.id);
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
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ville départ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
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
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),

                            items: villes_expedition
                                .map((type) => type.name)
                                .toList(),
                            filterFn: (user, filter) => user
                                .toLowerCase()
                                .contains(filter.toLowerCase()),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText:
                                      user.dark_mode == 1 ? "" : "Ville départ",
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
                                  (element) => element.name == selectedType,
                                  orElse: () =>
                                      Villes(id: 9626, name: "", country_id: 0),
                                );
                                provider.change_ville_exp(ville_selected);
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Pays destination",
                                style: TextStyle(
                                  fontFamily: "Poppins",
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
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),

                            items: pays.map((type) => type.name).toList(),
                            filterFn: (user, filter) => user
                                .toLowerCase()
                                .contains(filter.toLowerCase()),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: user.dark_mode == 1
                                      ? ""
                                      : "Pays destination",
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
                                  (element) => element.name == selectedType,
                                  orElse: () => Pays(id: 24, name: ""),
                                );
                                provider.change_pays_liv(pay_selected);
                                await provider
                                    .getAllVillesLivraison(pay_selected.id);
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
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      user.dark_mode == 1
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ville de destination",
                                style: TextStyle(
                                  fontFamily: "Poppins",
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
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),

                            items: villes_livraison
                                .map((type) => type.name)
                                .toList(),
                            filterFn: (user, filter) => user
                                .toLowerCase()
                                .contains(filter.toLowerCase()),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: user.dark_mode == 1
                                      ? ""
                                      : "Ville destination",
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
                                  (element) => element.name == selectedType,
                                  orElse: () =>
                                      Villes(id: 9626, name: "", country_id: 0),
                                );
                                provider.change_ville_liv(ville_selected);
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
              height: 15,
            ),
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nom du chauffeur",
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
                maxLength: 25,
                controller: ConducteurName,
                onChanged: (value) => provider.change_conducteur_name(value),
                decoration: InputDecoration(
                    suffixIcon: ConducteurName.text.isNotEmpty &&
                            (conducteur_name.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: ConducteurName.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (conducteur_name.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Nom du chauffeur" : "",
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
            ConducteurName.text.isEmpty
                ? Container()
                : conducteur_name.length < 3
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
            user.dark_mode == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Contact du chauffeur",
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
                controller: ConducteurTelephone,
                onChanged: (value) =>
                    provider.change_conducteur_telephone(value.completeNumber),
                decoration: InputDecoration(
                    suffixIcon: ConducteurTelephone.text.isNotEmpty &&
                            conducteur_telephone.length < 8
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText:
                        user.dark_mode == 0 ? "Contact du chauffeur" : "",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "N° Permis",
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
                maxLength: 15,
                controller: Permis,
                onChanged: (value) => provider.change_permis(value),
                decoration: InputDecoration(
                    suffixIcon: Permis.text.isNotEmpty && (permis.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Permis.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (permis.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "N° Permis" : "",
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
            Permis.text.isEmpty
                ? Container()
                : permis.length < 3
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Numéro invalid",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Immatriculation",
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
                maxLength: 15,
                controller: Immatriculation,
                onChanged: (value) => provider.change_immatriculation(value),
                decoration: InputDecoration(
                    suffixIcon: Immatriculation.text.isNotEmpty &&
                            (immatriculation.length < 3)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Immatriculation.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (immatriculation.length > 3)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Immatriculation" : "",
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
            Immatriculation.text.isEmpty
                ? Container()
                : immatriculation.length < 3
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "N° Camion invalid",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tarif",
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
                maxLength: 15,
                keyboardType: TextInputType.number,
                controller: Tarif,
                onChanged: (value) => provider.change_tarif(value),
                decoration: InputDecoration(
                    suffixIcon:
                        Tarif.text.isNotEmpty && (tarif < 0 || tarif < accompte)
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(Icons.error, color: Colors.red),
                              )
                            : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Tarif.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (tarif > 0 && tarif >= accompte)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Tarif" : "",
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
            Tarif.text.isEmpty
                ? Container()
                : tarif < 1 || tarif < accompte
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tarif invalid",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Accompte",
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
                maxLength: 15,
                keyboardType: TextInputType.number,
                controller: Accompte,
                onChanged: (value) => provider.change_accompte(value),
                decoration: InputDecoration(
                    suffixIcon: Accompte.text.isNotEmpty &&
                            (accompte < 0 || tarif < accompte)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Accompte.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (accompte > 0 && tarif >= accompte)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Accompte" : "",
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
            Accompte.text.isEmpty
                ? Container()
                : accompte < 1 || tarif < accompte
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Accompte invalid",
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
            user.dark_mode == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Solde",
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
                maxLength: 10,
                keyboardType: TextInputType.number,
                enabled: false,
                controller: Solde,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Tarif.text.isEmpty
                          ? function.convertHexToColor("#79747E")
                          : (tarif > 0 && tarif >= accompte)
                              ? MyColors.secondary
                              : Colors.red,
                    )),
                    filled: user.dark_mode == 1 ? true : false,
                    fillColor: user.dark_mode == 1 ? MyColors.filedDark : null,
                    labelText: user.dark_mode == 0 ? "Solde" : "",
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
              height: 5,
            ),
          ],
        )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_affiche(false);
                      Navigator.of(dialocontext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: affiche
                      ? null
                      : () async {
                          provider.change_affiche(true);
                          String statut_code = await service.UpdateTransp(
                              conducteur_name,
                              permis,
                              conducteur_telephone,
                              immatriculation,
                              pay_exp,
                              ville_exp,
                              pay_liv,
                              ville_liv,
                              tarif,
                              accompte,
                              chargement_effectue);

                          if (statut_code == "202") {
                            provider.change_affiche(false);
                            showCustomSnackBar(dialocontext,
                                "Une erreur est survenue", Colors.redAccent);
                          } else if (statut_code == "422") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialocontext,
                                "Certains champs sont mal renseignés",
                                Colors.redAccent);
                          } else if (statut_code == "500") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialocontext,
                                "Une erreur est survenue. Vérifie si tous les champs sont bien renseignés",
                                Colors.redAccent);
                          } else {
                            await api_provider.InitChargementEffectue();
                            provider.reset();
                            showCustomSnackBar(
                                dialocontext,
                                "Le transporteur a été modifié avec succès",
                                Colors.green);
                            Navigator.of(dialocontext).pop();
                          }
                        },
                  child: affiche
                      ? Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: MyColors.light,
                            ),
                          ),
                        )
                      : Text(
                          "Modifiez",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyColors.light,
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> showTransp(BuildContext context, int import_id) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final api_provider = Provider.of<ApiProvider>(dialocontext);
      final provider = Provider.of<ProvAddTransp>(dialocontext);
      List<ChargementEffectue> chargement_effectues =
          api_provider.chargement_effectues;
      chargement_effectues =
          function.import_chargemnt_effectues(chargement_effectues, import_id);
      List<Camions> camions = api_provider.camions;
      List<Pieces> pieces = api_provider.pieces;
      List<Conducteur> conducteurs = api_provider.conducteurs;
      List<Position> positions = api_provider.positions;
      List<Tarif> tarifs = api_provider.tarifs;
      List<Pays> pays = api_provider.pays;
      List<Villes> all_villes = api_provider.all_villes;
      Users user = api_provider.user;

      return AlertDialog(
        title: Text(
          "Transporteurs",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: chargement_effectues.isEmpty
            ? Center(
                child: Text(
                "Vous n'avez encore pas ajouté de transporteurs",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: user.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ))
            : Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5), //
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      ChargementEffectue chargement_effectue =
                          chargement_effectues[index];
                      Position position = function.chargement_effectue_position(
                          positions, chargement_effectue);
                      Pays pay_depart = function.pay(pays, position.pay_dep_id);
                      Pays pay_dest = function.pay(pays, position.pay_liv_id);
                      Villes ville_dep =
                          function.ville(all_villes, position.city_dep_id);
                      Villes ville_dest =
                          function.ville(all_villes, position.city_liv_id);
                      Conducteur conducteur = function.chargement_chauffeur(
                          conducteurs, chargement_effectue);
                      Pieces piece =
                          function.conducteur_piece(pieces, conducteur);
                      Camions camion = function.chargement_camion(
                          camions, chargement_effectue);
                      Tarif tarif = function.chargement_effectue_tarif(
                          tarifs, chargement_effectue);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  width: 0.1,
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nom : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        conducteur.nom,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Contact : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        conducteur.telephone,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "N° Permis : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        piece.num_piece,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "N° Camion : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        camion.num_immatriculation,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Départ : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    pay_depart.id == 0
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://test.bodah.bj/countries/${pay_depart.flag}",
                                              fit: BoxFit.cover,
                                              height: 12,
                                              width: 17,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                color: MyColors.secondary,
                                              ),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                    Expanded(
                                      child: Text(
                                        ville_dep.name +
                                            " , " +
                                            pay_depart.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Destination : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    pay_dest.id == 0
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://test.bodah.bj/countries/${pay_dest.flag}",
                                              fit: BoxFit.cover,
                                              height: 12,
                                              width: 17,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                color: MyColors.secondary,
                                              ),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                    Expanded(
                                      child: Text(
                                        ville_dest.name + " , " + pay_dest.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tarif : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        function.formatAmount(tarif.montant),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Acompte : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        function.formatAmount(tarif.accompte),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Solde : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        function.formatAmount(
                                            tarif.montant - tarif.accompte),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 9),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Actions : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    IconButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero),
                                        onPressed: () {
                                          provider.change_transporteur(
                                              conducteur,
                                              camion,
                                              piece,
                                              tarif,
                                              pay_depart,
                                              pay_dest,
                                              ville_dep,
                                              ville_dest);
                                          UpdateTransp(dialocontext,
                                              chargement_effectue);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: MyColors.primary,
                                        )),
                                    IconButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero),
                                        onPressed: () {
                                          DeleteTransp(dialocontext,
                                              chargement_effectue, conducteur);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.redAccent,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: chargement_effectues.length),
              ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      Navigator.of(dialocontext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    NewTransp(context, import_id);
                  },
                  child: Text(
                    "Ajoutez",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> DeleteTransp(BuildContext context,
    ChargementEffectue chargement_effectue, Conducteur conducteur) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final provider = Provider.of<ApiProvider>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool delete = provider.delete;
      return AlertDialog(
        title: Text(
          "Transporteur",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer le transporteur " +
              conducteur.nom +
              " ?",
          style: TextStyle(
              color: function.convertHexToColor("#79747E"),
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      provider.change_delete(false);
                      Navigator.of(dialocontext).pop();
                    },
                    child: Text(
                      "Annulez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: MyColors.secondary),
                  onPressed: delete
                      ? null
                      : () async {
                          provider.change_delete(true);
                          final String statut = await service
                              .deleteChargementEffectue(chargement_effectue);
                          if (statut == "202") {
                            showCustomSnackBar(dialocontext,
                                "Une erreur s'est produite", Colors.redAccent);
                            provider.change_delete(false);
                          } else {
                            await provider.InitChargementEffectue();
                            showCustomSnackBar(
                                dialocontext,
                                "Le transporteur a été supprimé avec succès",
                                Colors.green);
                            provider.change_delete(false);
                            Navigator.of(dialocontext).pop();
                          }
                        },
                  child: delete
                      ? Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: MyColors.light,
                            ),
                          ),
                        )
                      : Text(
                          "Supprimez",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyColors.light,
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}