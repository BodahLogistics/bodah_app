// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:bodah/modals/annonce_transporteurs.dart';
import 'package:bodah/modals/info_localisation.dart';
import 'package:bodah/modals/marchandise_transporteur.dart';
import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/modals/type_chargements.dart';
import 'package:bodah/modals/villes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../../../../modals/camions.dart';
import '../../../../modals/type_camions.dart';
import '../../../../providers/users/transporteur/trajets/camions/add.dart';
import '../../../../services/data_base_service.dart';
import '../../../auth/sign_in.dart';
import '../trajets/list.dart';

class MesTrajets extends StatelessWidget {
  const MesTrajets({super.key});

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final function = Provider.of<Functions>(context);
    Users? user = api_provider.user;
    List<AnnonceTransporteurs> trajets = api_provider.trajets;
    List<MarchandiseTransporteur> marchandies =
        api_provider.marchandise_transporteurs;
    List<InfoLocalisations> localisations = api_provider.info_localisations;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    Transporteurs user_transporteur =
        function.user_transporteur(user, transporteurs);
    List<Camions> camions = api_provider.camions;
    List<Users> users = api_provider.users;
    List<TypeChargements> type_chargements = api_provider.type_chargements;
    List<Pays> pays = api_provider.pays;
    List<Villes> villes = api_provider.all_villes;

    Future<void> refresh() async {
      await api_provider.InitTrajet();
    }

    return trajets.isEmpty
        ? RefreshIndicator(
            color: MyColors.secondary,
            onRefresh: refresh,
            child: SingleChildScrollView(
              physics:
                  AlwaysScrollableScrollPhysics(), // Permet toujours le défilement
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.7, // Prend toute la hauteur de l'écran
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16.0), // Ajoute un peu de padding
                    child: Text(
                      "Aucune donnée disponible",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: user!.dark_mode == 1
                            ? MyColors.light
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ))
        : RefreshIndicator(
            color: MyColors.secondary,
            onRefresh: refresh,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    AnnonceTransporteurs trajet = trajets[index];
                    MarchandiseTransporteur marchandise =
                        function.trajet_marchandise(marchandies, trajet);
                    InfoLocalisations localisation =
                        function.trajet_localisation(localisations, trajet);
                    Transporteurs transporteur = function.transporteur(
                        transporteurs, trajet.transporteur_id);
                    Users chauffeur_user =
                        function.user(users, transporteur.user_id);
                    TypeChargements type_chargemet = function.type_chargement(
                        type_chargements, trajet.type_chargement_id);

                    Pays pay_depart =
                        function.pay(pays, localisation.pays_dep_id);
                    Pays pay_dest =
                        function.pay(pays, localisation.pays_dest_id);
                    Villes ville_dep =
                        function.ville(villes, localisation.ville_dep_id);
                    Villes ville_dest =
                        function.ville(villes, localisation.ville_dest_id);
                    Camions camion =
                        function.camion(camions, trajet.vehicule_id);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: TextButton(
                        onPressed: () {
                          showAllFromTrajet(
                              context,
                              trajet,
                              type_chargemet,
                              pay_depart,
                              pay_dest,
                              ville_dep,
                              ville_dest,
                              marchandise.nombre_tonnes);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: index % 1 != 0
                                  ? Colors.grey.withOpacity(.2)
                                  : null,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: user!.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  width: 0.1,
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Référence : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        trajet.numero_annonce,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Type de chargement : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        type_chargemet.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Poids maximal : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        marchandise.nombre_tonnes,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
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
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 10,
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
                                              height: 15,
                                              width: 20,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                color: MyColors.secondary,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(),
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
                                            fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
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
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 10,
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
                                              height: 15,
                                              width: 20,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                color: MyColors.secondary,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(),
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
                                            fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                user_transporteur.id != transporteur.id
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Chauffeur : ",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: user.dark_mode == 1
                                                        ? MyColors.light
                                                        : MyColors.black,
                                                    fontFamily: "Poppins",
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  chauffeur_user.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors.textColor,
                                                      fontFamily: "Poppins",
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  chauffeur_user.telephone,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors.textColor,
                                                      fontFamily: "Poppins",
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                        ],
                                      )
                                    : Container(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Immatriculation : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 10,
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
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Publié le : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        function.date(trajet.created_at),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: trajets.length),
            ),
          );
  }
}

Future<dynamic> AddCamion(BuildContext context) {
  TextEditingController Immatriculation = TextEditingController();

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final api_provider = Provider.of<ApiProvider>(dialocontext);
      final provider = Provider.of<ProvAddCamion>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);
      bool affiche = provider.affiche;
      String immatriculation = provider.imm;
      List<File> files = provider.files_selected;
      List<File> file2 = provider.file2;
      List<File> file3 = provider.file3;
      TypeCamions type_camion = provider.type_camion;
      List<TypeCamions> type_camions = api_provider.type_camions;
      Users? user = api_provider.user;

      return AlertDialog(
        title: Text(
          "Camion du transporteur",
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
            user!.dark_mode == 1
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
                        labelText: user.dark_mode == 1 ? "" : "Type de camion",
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
                        AddFiles(dialocontext);
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
              height: 10,
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
                        AddFile2(dialocontext);
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
              height: 10,
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
                        AddFile3(dialocontext);
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
            )
          ],
        )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80,
                height: 30,
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
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 100,
                height: 30,
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
                          String statut_code = await service.AddCamion(
                              immatriculation,
                              type_camion,
                              files,
                              file2,
                              file3,
                              api_provider);

                          if (statut_code == "401") {
                            provider.change_affiche(false);
                            showCustomSnackBar(
                                dialocontext,
                                "Ce camion existe déjà dans la liste de vos camions",
                                Colors.redAccent);
                          } else if (statut_code == "202") {
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
                          } else if (statut_code == "200") {
                            await api_provider.InitCamions();
                            provider.reset();
                            showCustomSnackBar(
                                dialocontext,
                                "Le camion a été enregistré avec succès",
                                Colors.green);
                            Navigator.of(dialocontext).pop();
                          }
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
                          "Ajoutez",
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

Future<dynamic> AddFiles(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      final apiProvider = Provider.of<ApiProvider>(dialogContext);
      final provider = Provider.of<ProvAddCamion>(dialogContext);

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
      final provider = Provider.of<ProvAddCamion>(dialogContext);

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
      final provider = Provider.of<ProvAddCamion>(dialogContext);

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
