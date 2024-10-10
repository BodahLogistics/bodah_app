// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables

import 'package:bodah/modals/annonce_transporteurs.dart';
import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/type_chargements.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/users/transporteur/trajets/add.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../drawer/index.dart';

class UpdateTrajet extends StatefulWidget {
  UpdateTrajet({
    Key? key,
    required this.trajet,
  }) : super(key: key);
  final AnnonceTransporteurs trajet;

  @override
  State<UpdateTrajet> createState() => _UpdateTrajetState();
}

class _UpdateTrajetState extends State<UpdateTrajet> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvAddTrajet>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvAddTrajet>(context);
    String charge = provider.charge;
    TypeChargements type_chargement = provider.type_chargement;
    Villes ville_exp = provider.ville_exp;
    Villes ville_liv = provider.ville_liv;
    Pays pay_exp = provider.pay_exp;
    Pays pay_liv = provider.pay_liv;
    bool affiche = provider.affiche;

    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes_expedition = provider.villes_expeditions;
    List<Villes> villes_livraison = provider.villes_livraison;
    List<TypeChargements> type_chargements = api_provider.type_chargements;
    List<String> charges = function.charges;
    final service = Provider.of<DBServices>(context);

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      drawer: DrawerTransporteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Mon trajet",
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
                  top: 10, right: 10, left: 15, bottom: 50),
              child: Column(
                children: [
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
                                      "Type de chargement",
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
                                height: user.dark_mode == 1 ? 50 : 50,
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.dialog(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    disabledItemFn: (String s) =>
                                        s.startsWith('I'),
                                  ),

                                  items: type_chargements
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
                                            : "Type de chargement",
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
                                      final selected =
                                          type_chargements.firstWhere(
                                        (element) =>
                                            element.name == selectedType,
                                        orElse: () =>
                                            TypeChargements(id: 0, name: ""),
                                      );
                                      provider.change_type_chargement(selected);
                                    }
                                  },
                                  selectedItem: type_chargement
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
                                      "Poids maximal",
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
                                height: user.dark_mode == 1 ? 50 : 50,
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.dialog(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    disabledItemFn: (String s) =>
                                        s.startsWith('I'),
                                  ),

                                  items: charges.map((type) => type).toList(),
                                  filterFn: (user, filter) => user
                                      .toLowerCase()
                                      .contains(filter.toLowerCase()),

                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: user.dark_mode == 1
                                            ? ""
                                            : "Poids maximal",
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
                                      final charge_selected =
                                          charges.firstWhere(
                                        (element) => element == selectedType,
                                        orElse: () => "",
                                      );
                                      provider.change_charge(charge_selected);
                                    }
                                  },
                                  selectedItem:
                                      charge, // Remplacez 'null' par le type de compte par défaut si nécessaire
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
                                        orElse: () => Pays(id: 0, name: ""),
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
                                          villes_expedition.firstWhere(
                                        (element) =>
                                            element.name == selectedType,
                                        orElse: () => Villes(
                                            id: 0, name: "", country_id: 0),
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
                                      "Pays de destinataion",
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
                                        orElse: () => Pays(id: 0, name: ""),
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
                                            id: 0, name: "", country_id: 0),
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

                                String statut_code = await service.UpdateTrajet(
                                    charge,
                                    type_chargement,
                                    pay_exp,
                                    pay_liv,
                                    ville_exp,
                                    ville_liv,
                                    api_provider,
                                    widget.trajet);
                                if (statut_code == "404") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Vous ne pouvez pas modifier ce trajet",
                                      Colors.redAccent);
                                } else if (statut_code == "202") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Une erreur inattendue s'est produite",
                                      Colors.redAccent);
                                } else if (statut_code == "422") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(context,
                                      "Erreur de validation", Colors.redAccent);
                                } else if (statut_code == "500") {
                                  provider.change_affiche(false);
                                  showCustomSnackBar(
                                      context,
                                      "Une erreur s'est produite. Vérifiez votre connection internet et réessayer",
                                      Colors.redAccent);
                                } else if (statut_code == "200") {
                                  provider.change_affiche(false);
                                  provider.reset();
                                  Navigator.of(context).pop();
                                  showCustomSnackBar(
                                      context,
                                      "Votre trajet a été modifié avec succès",
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
                              "Modifiez votre trajet",
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
