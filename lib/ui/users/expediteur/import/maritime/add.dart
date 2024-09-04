// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/chargement_effectues.dart';
import 'package:bodah/modals/livraison_cargaison.dart';
import 'package:bodah/providers/users/expediteur/import/maritime/add.dart';
import 'package:bodah/providers/users/expediteur/import/transp/add.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:bodah/ui/users/expediteur/import/details/index.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/cargaison.dart';
import '../../../../../modals/pays.dart';
import '../../../../../modals/villes.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../../providers/users/expediteur/import/liv/add.dart';
import '../../../../../providers/users/expediteur/import/march/add.dart';
import '../../../../../services/data_base_service.dart';
import '../../drawer/index.dart';
import '../../marchandises/nav_bottom/index.dart';
import '../route/add.dart';

class NewImportMaritime extends StatefulWidget {
  NewImportMaritime({super.key});

  @override
  State<NewImportMaritime> createState() => _NewImportMaritimeState();
}

class _NewImportMaritimeState extends State<NewImportMaritime> {
  TextEditingController Tarif = TextEditingController();

  TextEditingController Accompte = TextEditingController();

  TextEditingController Solde = TextEditingController();

  TextEditingController Quantite = TextEditingController();

  TextEditingController ClientName = TextEditingController();

  TextEditingController Marchandise = TextEditingController();

  TextEditingController DateDebut = TextEditingController();

  TextEditingController DateFin = TextEditingController();

  TextEditingController Bl = TextEditingController();

  TextEditingController Conteneur = TextEditingController();

  TextEditingController ClientTelephone = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvAddImportMaritime>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
      Provider.of<ApiProvider>(context, listen: false).InitImportData();
      Provider.of<ProvAddMarch>(context, listen: false).reset();
      Provider.of<ProvAddTransp>(context, listen: false).reset();
      Provider.of<ProvAddLiv>(context, listen: false).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvAddImportMaritime>(context);

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
    String bl = provider.bl;
    String conteneur = provider.conteneur;
    Villes ville_exp = provider.ville_exp;
    Villes ville_liv = provider.ville_liv;
    Pays pay_exp = provider.pay_exp;
    Pays pay_liv = provider.pay_liv;
    bool affiche = provider.affiche;

    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes_expedition = provider.villes_expeditions;
    List<Villes> villes_livraison = provider.villes_livraison;
    final service = Provider.of<DBServices>(context);

    if (solde > 0) {
      Solde.text = solde.toString();
    }

    int import_key = api_provider.import_maritime_key;
    List<Cargaison> cargaisons = api_provider.cargaisons;
    cargaisons = function.import_cargaisons(cargaisons, import_key);
    List<ChargementEffectue> chargement_effectues =
        api_provider.chargement_effectues;
    chargement_effectues =
        function.import_chargemnt_effectues(chargement_effectues, import_key);
    List<LivraisonCargaison> livraisons = api_provider.livraisons;
    livraisons = function.import_livraisons(livraisons, import_key);

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
      body: SingleChildScrollView(
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
                      onChanged: (value) => provider.change_client_name(value),
                      decoration: InputDecoration(
                          suffixIcon: ClientName.text.isNotEmpty &&
                                  (client_name.length < 3)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
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
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Nom du client" : "",
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
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText:
                              user.dark_mode == 0 ? "Contact du client" : "",
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
                      maxLength: 25,
                      controller: Marchandise,
                      onChanged: (value) => provider.change_marchandise(value),
                      decoration: InputDecoration(
                          suffixIcon: Marchandise.text.isNotEmpty &&
                                  (marchandise.length < 3)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Marchandise.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (marchandise.length > 3)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Marchandise" : "",
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
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Champ invalid",
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
                      onChanged: (value) => provider.change_quantite(value),
                      decoration: InputDecoration(
                          suffixIcon: Quantite.text.isNotEmpty && (quantite < 1)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Quantite.text.isEmpty
                                ? function.convertHexToColor("#79747E")
                                : (quantite > 0)
                                    ? MyColors.secondary
                                    : Colors.red,
                          )),
                          filled: user.dark_mode == 1 ? true : false,
                          fillColor:
                              user.dark_mode == 1 ? MyColors.filedDark : null,
                          labelText: user.dark_mode == 0 ? "Quantité" : "",
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

                                  items: pays.map((type) => type.name).toList(),
                                  filterFn: (user, filter) => user
                                      .toLowerCase()
                                      .contains(filter.toLowerCase()),

                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: user.dark_mode == 1
                                            ? ""
                                            : "Pays de départ",
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
                                        orElse: () => Pays(id: 24, name: ""),
                                      );
                                      provider.change_pays_exp(pay_selected);
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
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: user.dark_mode == 1
                                            ? ""
                                            : "Ville de départ",
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
                                            id: 9626, name: "", country_id: 0),
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

                                  items: pays.map((type) => type.name).toList(),
                                  filterFn: (user, filter) => user
                                      .toLowerCase()
                                      .contains(filter.toLowerCase()),

                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: user.dark_mode == 1
                                            ? ""
                                            : "Pays de destination",
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
                                        orElse: () => Pays(id: 24, name: ""),
                                      );
                                      provider.change_pays_liv(pay_selected);
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
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: user.dark_mode == 1
                                            ? ""
                                            : "Ville de destination",
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
                                            id: 9626, name: "", country_id: 0),
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
                                      String format = DateFormat("yyyy-MM-dd")
                                          .format(picked);
                                      DateDebut.text = format;
                                      provider.change_date_debut(format);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: DateDebut.text.isEmpty
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
                                      String format = DateFormat("yyyy-MM-dd")
                                          .format(picked);
                                      DateFin.text = format;
                                      provider.change_date_fin(format);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: DateFin.text.isEmpty
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
                                        "N° Bl",
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
                                  controller: Bl,
                                  maxLength: 14,
                                  onChanged: (value) =>
                                      provider.change_bl(value),
                                  decoration: InputDecoration(
                                      suffixIcon: Bl.text.isNotEmpty &&
                                              (bl.length < 3)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Icon(Icons.error,
                                                  color: Colors.red),
                                            )
                                          : null,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Bl.text.isEmpty
                                            ? function
                                                .convertHexToColor("#79747E")
                                            : (bl.length > 3)
                                                ? MyColors.secondary
                                                : Colors.red,
                                      )),
                                      filled:
                                          user.dark_mode == 1 ? true : false,
                                      fillColor: user.dark_mode == 1
                                          ? MyColors.filedDark
                                          : null,
                                      labelText:
                                          user.dark_mode == 0 ? "N° Bl" : "",
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
                              Bl.text.isEmpty
                                  ? Container()
                                  : bl.length < 3
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
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
                                        "N° Conteneur",
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
                                  controller: Conteneur,
                                  maxLength: 15,
                                  onChanged: (value) =>
                                      provider.change_conteneur(value),
                                  decoration: InputDecoration(
                                      suffixIcon: Conteneur.text.isNotEmpty &&
                                              (conteneur.length < 3)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Icon(Icons.error,
                                                  color: Colors.red),
                                            )
                                          : null,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Conteneur.text.isEmpty
                                            ? function
                                                .convertHexToColor("#79747E")
                                            : (conteneur.length > 3)
                                                ? MyColors.secondary
                                                : Colors.red,
                                      )),
                                      filled:
                                          user.dark_mode == 1 ? true : false,
                                      fillColor: user.dark_mode == 1
                                          ? MyColors.filedDark
                                          : null,
                                      labelText: user.dark_mode == 0
                                          ? "N° Conteneur"
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
                              Conteneur.text.isEmpty
                                  ? Container()
                                  : conteneur.length < 3
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
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
                                              (tarif < 0 || tarif < accompte)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Icon(Icons.error,
                                                  color: Colors.red),
                                            )
                                          : null,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Tarif.text.isEmpty
                                            ? function
                                                .convertHexToColor("#79747E")
                                            : (tarif > 0 && tarif >= accompte)
                                                ? MyColors.secondary
                                                : Colors.red,
                                      )),
                                      filled:
                                          user.dark_mode == 1 ? true : false,
                                      fillColor: user.dark_mode == 1
                                          ? MyColors.filedDark
                                          : null,
                                      labelText:
                                          user.dark_mode == 0 ? "Tarif" : "",
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
                                          padding:
                                              const EdgeInsets.only(top: 3),
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
                                      suffixIcon: Accompte.text.isNotEmpty &&
                                              (accompte < 0 || tarif < accompte)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Icon(Icons.error,
                                                  color: Colors.red),
                                            )
                                          : null,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Accompte.text.isEmpty
                                            ? function
                                                .convertHexToColor("#79747E")
                                            : (accompte > 0 &&
                                                    tarif >= accompte)
                                                ? MyColors.secondary
                                                : Colors.red,
                                      )),
                                      filled:
                                          user.dark_mode == 1 ? true : false,
                                      fillColor: user.dark_mode == 1
                                          ? MyColors.filedDark
                                          : null,
                                      labelText:
                                          user.dark_mode == 0 ? "Accompte" : "",
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
                                          padding:
                                              const EdgeInsets.only(top: 3),
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
                                          ? function
                                              .convertHexToColor("#79747E")
                                          : (tarif > 0 && tarif >= accompte)
                                              ? MyColors.secondary
                                              : Colors.red,
                                    )),
                                    filled: user.dark_mode == 1 ? true : false,
                                    fillColor: user.dark_mode == 1
                                        ? MyColors.filedDark
                                        : null,
                                    labelText:
                                        user.dark_mode == 0 ? "Solde" : "",
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
                                          padding:
                                              const EdgeInsets.only(right: 2),
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
                              onPressed: () {
                                if (cargaisons.isEmpty) {
                                  NewMarch(context, import_key);
                                } else {
                                  showMarch(context, import_key);
                                }
                              },
                              child: cargaisons.isNotEmpty
                                  ? Text(
                                      "Marchandises",
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
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Icon(
                                            Icons.add,
                                            color: MyColors.secondary,
                                          ),
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
                              onPressed: () {
                                if (livraisons.isEmpty) {
                                  NewLiv(context, import_key);
                                } else {
                                  showLiv(context, import_key);
                                }
                              },
                              child: livraisons.isNotEmpty
                                  ? Text(
                                      "Livraisons",
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
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Icon(
                                            Icons.add,
                                            color: MyColors.secondary,
                                          ),
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
                                String statut_code =
                                    await service.addImportMaritime(
                                        client_name,
                                        bl,
                                        conteneur,
                                        client_telephone,
                                        pay_exp,
                                        ville_exp,
                                        pay_liv,
                                        ville_liv,
                                        tarif,
                                        accompte,
                                        marchandise,
                                        date_deut,
                                        date_fin,
                                        quantite,
                                        api_provider);

                                if (statut_code == "202") {
                                  showCustomSnackBar(
                                      context,
                                      "Une erreur inattendue est survenu !",
                                      Colors.redAccent);
                                  provider.change_affiche(false);
                                } else if (statut_code == "422") {
                                  showCustomSnackBar(
                                      context,
                                      "Certains champs sont mal renseignés",
                                      Colors.redAccent);
                                  provider.change_affiche(false);
                                } else if (statut_code == "500") {
                                  showCustomSnackBar(
                                      context,
                                      "Vérifiez votre connexion internet et réessayer",
                                      Colors.redAccent);
                                  provider.change_affiche(false);
                                } else if (statut_code == "200") {
                                  await api_provider.InitImportData();
                                  provider.reset();
                                  provider.change_affiche(false);
                                  if (api_provider.data_id > 0) {
                                    Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            Align(
                                          alignment: Alignment.topLeft,
                                          child: DetailImport(
                                              import_id: api_provider.data_id),
                                        ),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context).pop();
                                  }
                                  showCustomSnackBar(
                                      context,
                                      "L'importation a été enregistrée avec succès",
                                      Colors.green);
                                } else {
                                  showCustomSnackBar(
                                      context,
                                      "Echec d'enregistrement de l'importation",
                                      Colors.redAccent);
                                  provider.change_affiche(false);
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
