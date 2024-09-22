// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:bodah/modals/type_camions.dart';
import 'package:bodah/providers/users/transporteur/chauffeurs/add.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:dotted_border/dotted_border.dart';
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

class AddChauffeur extends StatefulWidget {
  const AddChauffeur({super.key});

  @override
  State<AddChauffeur> createState() => _AddChauffeurState();
}

class _AddChauffeurState extends State<AddChauffeur> {
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
  TextEditingController Immatriculation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvAddChauffeur>(context);
    String name = provider.name;
    String telephone = provider.telephone;
    String imm = provider.imm;
    String email = provider.email;
    String adresse = provider.adresse;
    String permis = provider.permis;
    TypeCamions type_camion = provider.type_camion;
    Villes ville = provider.ville;
    Pays pay = provider.pay;

    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes = provider.villes;
    List<TypeCamions> type_camions = api_provider.type_camions;
    final service = Provider.of<DBServices>(context);
    List<File> files = provider.files_selected;
    List<File> file2 = provider.file2;
    List<File> file3 = provider.file3;
    List<File> profil = provider.profil;
    bool affiche = provider.affiche;

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
              Container(
                height: 35,
                decoration: BoxDecoration(),
                child: DottedBorder(
                  color: MyColors.secondary,
                  strokeWidth: 2,
                  dashPattern: [6, 3], // Ajustez le motif des tirets ici
                  borderType: BorderType.RRect,
                  radius: Radius.circular(4), //
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: TextButton(
                        onPressed: () {
                          AddProfil(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.upload),
                            profil.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  ),
                            Text(
                              "Photo de chauffeur",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
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
              user.dark_mode == 1
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Type de camion",
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
                      disabledItemFn: (String s) => s.startsWith('I'),
                    ),

                    items: type_camions.map((type) => type.nom).toList(),
                    filterFn: (user, filter) =>
                        user.toLowerCase().contains(filter.toLowerCase()),

                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText:
                              user.dark_mode == 1 ? "" : "Type de camion",
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
                        final selected = type_camions.firstWhere(
                          (element) => element.nom == selectedType,
                          orElse: () => TypeCamions(id: 0, nom: ""),
                        );
                        provider.change_type_camion(selected);
                      }
                    },
                    selectedItem: type_camion
                        .nom, // Remplacez 'null' par le type de compte par défaut si nécessaire
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
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
                  onChanged: (value) => provider.change_imm(value),
                  decoration: InputDecoration(
                      suffixIcon:
                          Immatriculation.text.isNotEmpty && (imm.length < 3)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.error, color: Colors.red),
                                )
                              : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Immatriculation.text.isEmpty
                            ? function.convertHexToColor("#79747E")
                            : (imm.length > 3)
                                ? MyColors.secondary
                                : Colors.red,
                      )),
                      filled: user.dark_mode == 1 ? true : false,
                      fillColor:
                          user.dark_mode == 1 ? MyColors.filedDark : null,
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
              SizedBox(
                height: 5,
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(),
                child: DottedBorder(
                  color: MyColors.secondary,
                  strokeWidth: 2,
                  dashPattern: [6, 3], // Ajustez le motif des tirets ici
                  borderType: BorderType.RRect,
                  radius: Radius.circular(4), //
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: TextButton(
                        onPressed: () {
                          AddFiles(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.upload),
                            files.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  ),
                            Text(
                              "Photo de remorque",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(),
                child: DottedBorder(
                  color: Colors.grey,
                  strokeWidth: 2,
                  dashPattern: [6, 3], // Ajustez le motif des tirets ici
                  borderType: BorderType.RRect,
                  radius: Radius.circular(4), //
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: TextButton(
                        onPressed: () {
                          AddFile2(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.upload),
                            file2.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  ),
                            Text(
                              "Photo d'arrière",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(),
                child: DottedBorder(
                  color: MyColors.primary,
                  strokeWidth: 2,
                  dashPattern: [6, 3], // Ajustez le motif des tirets ici
                  borderType: BorderType.RRect,
                  radius: Radius.circular(4), //
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: TextButton(
                        onPressed: () {
                          AddFile3(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.upload),
                            file3.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  ),
                            Text(
                              "Photo de profil",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: MyColors.light,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                  ),
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

                            String statut_code = await service.AddChauffeur(
                                imm,
                                type_camion,
                                files,
                                file2,
                                file3,
                                profil,
                                name,
                                telephone,
                                permis,
                                pay,
                                ville,
                                email,
                                adresse,
                                api_provider);

                            if (statut_code == "202") {
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
                                  "Le chauffeur a été enregistré avec succès",
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
                          "Enregistrez votre chauffeur",
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

Future<dynamic> AddFiles(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddChauffeur>(dialogContext);

      Users? user = apiProvider.user;
      bool affiche = provider.upload;
      List<File> files = provider.files_selected;

      return AlertDialog(
        backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Remorque du camion",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              files.isEmpty
                  ? Container()
                  : Image.file(
                      files.first,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      scale: 2.5,
                    )
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeImageWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectImageFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 73,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset_files();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Supprimez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                Navigator.of(dialogContext).pop();
                              },
                        child: affiche
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: SizedBox(
                                  height: 20,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: MyColors.light,
                                  ),
                                ),
                              )
                            : Text(
                                "Fermez",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
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

Future<dynamic> AddFile2(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddChauffeur>(dialogContext);

      Users? user = apiProvider.user;
      bool affiche = provider.upload;
      List<File> files = provider.file2;

      return AlertDialog(
        backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Arrière du camion",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              files.isEmpty
                  ? Container()
                  : Image.file(
                      files.first,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      scale: 2.5,
                    )
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeFile2WithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectFile2FromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 73,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset_file2();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Supprimez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                Navigator.of(dialogContext).pop();
                              },
                        child: affiche
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: SizedBox(
                                  height: 20,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: MyColors.light,
                                  ),
                                ),
                              )
                            : Text(
                                "Fermez",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
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

Future<dynamic> AddFile3(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddChauffeur>(dialogContext);

      Users? user = apiProvider.user;
      bool affiche = provider.upload;
      List<File> files = provider.file3;

      return AlertDialog(
        backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Profil du camion",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              files.isEmpty
                  ? Container()
                  : Image.file(
                      files.first,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      scale: 2.5,
                    )
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeFile3WithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectFile3FromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 73,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset_file3();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Supprimez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                Navigator.of(dialogContext).pop();
                              },
                        child: affiche
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: SizedBox(
                                  height: 20,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: MyColors.light,
                                  ),
                                ),
                              )
                            : Text(
                                "Fermez",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
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

Future<dynamic> AddProfil(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddChauffeur>(dialogContext);

      Users? user = apiProvider.user;
      bool affiche = provider.upload;
      List<File> files = provider.profil;

      return AlertDialog(
        backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
        title: Text(
          "Photo du chauffeur",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          child: ListBody(
            children: [
              files.isEmpty
                  ? Container()
                  : Image.file(
                      files.first,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      scale: 2.5,
                    )
            ],
          ),
        ),
        actions: [
          files.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.primary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .takeProfilWithCamera(dialogContext);
                                  },
                            icon: Icon(
                              Icons.camera_alt,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Caméra",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.only(left: 3, right: 3),
                                backgroundColor: MyColors.secondary),
                            onPressed: affiche
                                ? null
                                : () async {
                                    await provider
                                        .selectProfilFromGallery(dialogContext);
                                  },
                            icon: Icon(
                              Icons.photo_library,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            "Galérie",
                            style: TextStyle(
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 73,
                      height: 30,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(left: 7, right: 7),
                              backgroundColor: Colors.redAccent),
                          onPressed: () {
                            provider.change_affiche(false);
                            provider.reset_profil();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Supprimez",
                            style: TextStyle(
                                color: MyColors.light,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 1),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 7, right: 7),
                            backgroundColor: Colors.green),
                        onPressed: affiche
                            ? null
                            : () async {
                                Navigator.of(dialogContext).pop();
                              },
                        child: affiche
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: SizedBox(
                                  height: 20,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: MyColors.light,
                                  ),
                                ),
                              )
                            : Text(
                                "Fermez",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColors.light,
                                    fontFamily: "Poppins",
                                    fontSize: 8,
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
