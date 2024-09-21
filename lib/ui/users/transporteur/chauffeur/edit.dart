// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/providers/users/transporteur/chauffeurs/add.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../modals/pays.dart';
import '../../../../modals/users.dart';
import '../../../../modals/villes.dart';
import '../../../../providers/api/api_data.dart';
import '../../../../services/data_base_service.dart';
import '../drawer/index.dart';

class UpdateChauffeur extends StatefulWidget {
  const UpdateChauffeur({super.key, required this.transporteur});
  final Transporteurs transporteur;

  @override
  State<UpdateChauffeur> createState() => _UpdateChauffeurState();
}

class _UpdateChauffeurState extends State<UpdateChauffeur> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProvAddChauffeur>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_affiche(false);
    });
  }

  TextEditingController Name = TextEditingController();
  TextEditingController Telephone = TextEditingController();
  TextEditingController Adresse = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Permis = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvAddChauffeur>(context);
    String name = provider.name;
    String telephone = provider.telephone;
    String email = provider.email;
    String adresse = provider.adresse;
    String permis = provider.permis;
    Villes ville = provider.ville;
    Pays pay = provider.pay;

    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes = provider.villes;
    final service = Provider.of<DBServices>(context);
    bool affiche = provider.affiche;

    if (Name.text.isEmpty) {
      Name.text = name;
    }

    if (Adresse.text.isEmpty) {
      Adresse.text = adresse;
    }

    if (Telephone.text.isEmpty && telephone.isNotEmpty) {
      Telephone.text = telephone.substring(4, telephone.length);
    }

    if (Email.text.isEmpty && email.isNotEmpty) {
      Email.text = email;
    }

    if (Permis.text.isEmpty) {
      Permis.text = permis;
    }

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
          "Mon chauffeur",
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
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            children: [
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nom",
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
                  maxLength: 20,
                  controller: Name,
                  onChanged: (value) => provider.change_name(value),
                  decoration: InputDecoration(
                      suffixIcon: Name.text.isNotEmpty && (name.length < 3)
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(Icons.error, color: Colors.red),
                            )
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Name.text.isEmpty
                            ? function.convertHexToColor("#79747E")
                            : (name.length > 3)
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
              SizedBox(
                height: 10,
              ),
              user.dark_mode == 1
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Téléphone",
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
                  controller: Telephone,
                  onChanged: (value) =>
                      provider.change_telephone(value.completeNumber),
                  decoration: InputDecoration(
                      suffixIcon:
                          Telephone.text.isNotEmpty && telephone.length < 8
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
                height: 10,
              ),
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email (Faculatatif)",
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
                  maxLength: 20,
                  controller: Email,
                  onChanged: (value) => provider.change_email(value),
                  decoration: InputDecoration(
                      suffixIcon: Email.text.isNotEmpty && (email.length < 3)
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(Icons.error, color: Colors.red),
                            )
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Email.text.isEmpty
                            ? function.convertHexToColor("#79747E")
                            : (email.length > 3)
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
              SizedBox(
                height: 10,
              ),
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Adresse (-Facultatif)",
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
                  maxLength: 20,
                  controller: Adresse,
                  onChanged: (value) => provider.change_adresse(value),
                  decoration: InputDecoration(
                      suffixIcon:
                          Adresse.text.isNotEmpty && (adresse.length < 3)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Adresse.text.isEmpty
                            ? function.convertHexToColor("#79747E")
                            : (adresse.length > 3)
                                ? MyColors.secondary
                                : Colors.red,
                      )),
                      filled: user.dark_mode == 1 ? true : false,
                      fillColor:
                          user.dark_mode == 1 ? MyColors.filedDark : null,
                      labelText:
                          user.dark_mode == 0 ? "Adresse (Facultatif)" : "",
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
                                  "Pays",
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
                                        user.dark_mode == 1 ? "" : "Pays",
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
                                    orElse: () => Pays(id: 0, name: ""),
                                  );
                                  provider.change_pays(pay_selected);
                                  await provider.getAllVilles(pay_selected.id);
                                }
                              },
                              selectedItem: pay
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
                                  "Ville",
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

                              items: villes.map((type) => type.name).toList(),
                              filterFn: (user, filter) => user
                                  .toLowerCase()
                                  .contains(filter.toLowerCase()),

                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    labelText:
                                        user.dark_mode == 1 ? "" : "Ville",
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
                                  final ville_selected = villes.firstWhere(
                                    (element) => element.name == selectedType,
                                    orElse: () =>
                                        Villes(id: 0, name: "", country_id: 0),
                                  );
                                  provider.change_ville(ville_selected);
                                }
                              },
                              selectedItem: ville
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
                  maxLength: 20,
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
                      fillColor:
                          user.dark_mode == 1 ? MyColors.filedDark : null,
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

                            String statut_code = await service.UpdateChauffeur(
                                widget.transporteur,
                                name,
                                telephone,
                                permis,
                                pay,
                                ville,
                                email,
                                adresse,
                                api_provider);

                            if (statut_code == "404") {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  context,
                                  "Vous ne pouvez pas modifier les onformations de ce chauffeur",
                                  Colors.redAccent);
                            } else if (statut_code == "104") {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  context,
                                  "Numro de permis déjà utilisé",
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
                              await api_provider.InitChauffeurs();
                              provider.change_affiche(false);
                              provider.reset();
                              Navigator.of(context).pop();
                              showCustomSnackBar(
                                  context,
                                  "Les infroamtiosn du chauffeur ont été modifiées avec succès",
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
                          "Validez",
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
      ),
    );
  }
}
