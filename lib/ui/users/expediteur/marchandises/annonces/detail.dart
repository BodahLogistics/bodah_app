// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/modals/camions.dart';
import 'package:bodah/modals/destinataires.dart';
import 'package:bodah/modals/devises.dart';
import 'package:bodah/modals/expediteurs.dart';
import 'package:bodah/modals/statuts.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/modals/type_chargements.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/services/data_base_service.dart';
import 'package:bodah/ui/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/add.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/annonces.dart';
import '../../../../../../modals/expeditions.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../modals/donneur_ordres.dart';
import '../../../../../modals/entite_factures.dart';
import '../../../../../modals/entreprises.dart';
import '../../../../../providers/users/expediteur/marchandises/annoces/odres/add.dart';
import '../expeditions/detail.dart';
import 'list.dart';
import 'marchandises/add.dart';
import 'ordres/detail.dart';
import 'ordres/edit.dart';

class DetailAnnonce extends StatefulWidget {
  const DetailAnnonce({super.key, required this.id});
  final int id;

  @override
  State<DetailAnnonce> createState() => _DetailAnnonceState();
}

class _DetailAnnonceState extends State<DetailAnnonce> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitForSomeAnnonce();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<Expeditions> expeditions = api_provider.expeditions;
    final user = api_provider.user;
    List<Users> users = api_provider.users;
    List<Tarifications> tarifications = api_provider.tarifications;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<Annonces> annonces = api_provider.annonces;
    Annonces annonce = function.annonce(annonces, widget.id);
    List<Marchandises> marchandises = api_provider.marchandises;
    marchandises = function.annonce_marchandises(marchandises, annonce.id);
    List<Destinataires> destinataires = api_provider.destinataires;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    List<Camions> camions = api_provider.camions;
    List<AnnoncePhotos> photos = api_provider.photos;
    List<AnnoncePhotos> pictues =
        function.annonce_pictures(annonce, marchandises, photos);
    final CarouselController _controller = CarouselController();
    List<DonneurOrdres> donneur_ordres = api_provider.donneur_ordres;
    List<EntiteFactures> entite_factures = api_provider.entite_factures;
    List<Expediteurs> expediteurs = api_provider.expediteurs;
    Expediteurs expediteur =
        function.expediteur(expediteurs, annonce.expediteur_id);
    List<BonCommandes> ordres = api_provider.ordres;
    BonCommandes ordre = function.annonce_bon_commande(ordres, annonce);
    EntiteFactures entite_facture =
        function.entite_facture(entite_factures, ordre.entite_facture_id);
    DonneurOrdres donneur_ordre =
        function.donneur_ordres(donneur_ordres, ordre.donneur_ordre_id);
    List<Entreprises> entreprises = api_provider.entreprises;
    Entreprises entite_facture_entreprise =
        function.entite_entreprise(entreprises, entite_facture.id);
    Entreprises donneur_ordre_entreprise =
        function.donneur_entreprise(entreprises, donneur_ordre.id);
    Entreprises expediteur_entreprise =
        function.expediteur_entreprise(entreprises, expediteur.id);
    Users expediteur_user = function.user(users, expediteur.user_id);
    List<Devises> devises = api_provider.devises;
    List<TypeChargements> type_chargements = api_provider.type_chargements;
    List<Unites> unites = api_provider.unites;
    List<Statuts> statuts = api_provider.statuts;
    bool loading = api_provider.loading;
    List<Expeditions> annonce_expeditions =
        function.annonce_expeditions(expeditions, marchandises, annonce);
    bool cant_delete = function.cant_delete_annonce(annonce_expeditions, ordre);
    Users donneur_user = function.user(users, donneur_ordre.user_id);
    Users entite_user = function.user(users, entite_facture.user_id);

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
          "Annonce publiée",
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
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.secondary,
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: MyColors.secondary,
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: MyColors.light,
                            )),
                        Text(
                          annonce.numero_annonce,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: MyColors.light,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                            onPressed: () {
                              showAllFromAnnonce(
                                  context,
                                  annonce,
                                  cant_delete,
                                  ordre,
                                  ordre.id > 0 &&
                                      user.id == donneur_user.id &&
                                      ordre.is_validated == 0,
                                  ordre.id > 0 &&
                                      user.id == donneur_user.id &&
                                      ordre.is_validated == 0,
                                  entite_facture,
                                  donneur_ordre,
                                  entite_facture_entreprise,
                                  donneur_ordre_entreprise,
                                  entite_user,
                                  donneur_user);
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: MyColors.light,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40, left: 15, right: 15, bottom: 80),
                    child: Column(
                      children: [
                        pictues.isEmpty
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 70),
                                    child: IconButton(
                                        onPressed: () {
                                          _controller.previousPage();
                                        },
                                        icon: Icon(
                                          Icons.arrow_left,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.secondary,
                                          size: 40,
                                        )),
                                  ),
                                  Expanded(
                                    child: CarouselSlider(
                                      items: pictues.map((photo) {
                                        Marchandises marchandise =
                                            function.marchandise(marchandises,
                                                photo.marchandise_id);
                                        return Builder(builder: (context) {
                                          return Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: photo.image_path,
                                                  fit: BoxFit.cover,
                                                  height: 150,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress,
                                                    color: MyColors.secondary,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  marchandise.nom,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors.black,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                      }).toList(),
                                      carouselController: _controller,
                                      options: CarouselOptions(
                                        pauseAutoPlayOnManualNavigate: false,
                                        height: 200,
                                        aspectRatio: 16 / 9,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 8),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        pauseAutoPlayOnTouch: false,
                                        viewportFraction: 1,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 70),
                                    child: IconButton(
                                        onPressed: () {
                                          _controller.nextPage();
                                        },
                                        icon: Icon(
                                          Icons.arrow_right,
                                          color: user.dark_mode == 1
                                              ? MyColors.light
                                              : MyColors.secondary,
                                          size: 40,
                                        )),
                                  ),
                                ],
                              ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Référence de l'annonce",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            annonce.numero_annonce,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w300,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Date de publication de l'annonce",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            function.date(annonce.created_at),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w300,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Statut de l'annonce",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: user.dark_mode == 1
                                    ? MyColors.light
                                    : MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        annonce.is_active == 1
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Annonce publiée",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.green),
                                ),
                              )
                            : Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Annonce non publiée",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w300,
                                      color: Colors.red),
                                ),
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Numéro du BL",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                annonce.numero_bl ?? " Non défini",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300,
                                    color: user.dark_mode == 1
                                        ? MyColors.light
                                        : MyColors.black),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.textColor,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: MyColors.secondary,
                                      ),
                                      height: 40,
                                      width: double.infinity,
                                      child: Text(
                                        "Expéditeur / Commissionnaire en douane / Transitaire",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: MyColors.light,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Identifiant",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur.numero_expediteur,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Nom",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur_user.name,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Contact",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur_user.telephone,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Adresse électronique",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur_user.email ??
                                                  "Non définie",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Adresse de résidence",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              expediteur_user.adresse ??
                                                  "Non définie",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w300,
                                                  color: user.dark_mode == 1
                                                      ? MyColors.light
                                                      : MyColors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          expediteur_entreprise.id > 0
                                              ? Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Nom de l'entreprise",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        expediteur_entreprise
                                                            .name,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "IFU/Numéro Fiscal",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        expediteur_entreprise
                                                                .ifu ??
                                                            "Non définie",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ordre.id > 0
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.textColor,
                                              width: 1,
                                              style: BorderStyle.solid)),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: MyColors.secondary,
                                            ),
                                            height: 40,
                                            width: double.infinity,
                                            child: Text(
                                              "Informations de l'ordre de transport",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: MyColors.light,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Identifiant",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    ordre.numero_bon_commande,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Délai de chargement",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    ordre.delai_chargement
                                                            .toString() +
                                                        " Heures",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Frais de stationnement sur retard de chargement",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    function.formatAmount(ordre
                                                            .amende_delai_chargement) +
                                                        " XOF /Camion/Jour",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Frais de stationnement sur retard de déchargement",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    function.formatAmount(ordre
                                                            .amende_dechargement) +
                                                        " XOF/Camion/Jour",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Statut de l'ordre de transport",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: user.dark_mode ==
                                                                1
                                                            ? MyColors.light
                                                            : MyColors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                ordre.is_validated == 1
                                                    ? Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Ordre de transport validé",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      )
                                                    : Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Ordre de transport non validé",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                ordre.is_validated == 1
                                                    ? Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Date de validation",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  color: user.dark_mode ==
                                                                          1
                                                                      ? MyColors
                                                                          .light
                                                                      : MyColors
                                                                          .black),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              function.date(ordre
                                                                  .updated_at),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: user.dark_mode ==
                                                                          1
                                                                      ? MyColors
                                                                          .light
                                                                      : MyColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: user.dark_mode ==
                                                                    1
                                                                ? MyColors.light
                                                                : MyColors
                                                                    .textColor,
                                                            style: BorderStyle
                                                                .solid)),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: MyColors
                                                                .secondary,
                                                          ),
                                                          height: 40,
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            "Donneur d'ordre",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .light,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Référence",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  donneur_ordre
                                                                      .reference,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Nom",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  donneur_user
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Contact",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  donneur_user
                                                                      .telephone,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Adresse électronique",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  donneur_user
                                                                          .email ??
                                                                      "Non définie",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Adresse de résidence",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  donneur_user
                                                                          .adresse ??
                                                                      "Non définie",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              donneur_ordre_entreprise
                                                                          .id >
                                                                      0
                                                                  ? Column(
                                                                      children: [
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            "Nom de l'entreprise",
                                                                            style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                                color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            donneur_ordre_entreprise.name,
                                                                            style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontWeight: FontWeight.w300,
                                                                                color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            "IFU/Numéro Fiscal",
                                                                            style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                                color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            donneur_ordre_entreprise.ifu ??
                                                                                "Non définie",
                                                                            style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontWeight: FontWeight.w300,
                                                                                color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: user.dark_mode ==
                                                                    1
                                                                ? MyColors.light
                                                                : MyColors
                                                                    .textColor,
                                                            style: BorderStyle
                                                                .solid)),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: MyColors
                                                                .secondary,
                                                          ),
                                                          height: 40,
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            "Entité à facturer",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .light,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Référence",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  entite_facture
                                                                      .reference,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Nom",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  entite_user
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Contact",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  entite_user
                                                                      .telephone,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Adresse électronique",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  entite_user
                                                                          .email ??
                                                                      "Non définie",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Adresse de résidence",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  entite_user
                                                                          .adresse ??
                                                                      "Non définie",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: user.dark_mode == 1
                                                                          ? MyColors
                                                                              .light
                                                                          : MyColors
                                                                              .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              entite_facture_entreprise
                                                                          .id >
                                                                      0
                                                                  ? Column(
                                                                      children: [
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            "Nom de l'entreprise",
                                                                            style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                                color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            entite_facture_entreprise.name,
                                                                            style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontWeight: FontWeight.w300,
                                                                                color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            "IFU/Numéro Fiscal",
                                                                            style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                                color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            entite_facture_entreprise.ifu ??
                                                                                "Non définie",
                                                                            style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontWeight: FontWeight.w300,
                                                                                color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            Column(
                              children: [
                                marchandises.length > 1
                                    ? Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: MyColors.secondary,
                                        ),
                                        height: 40,
                                        width: double.infinity,
                                        child: Text(
                                          "Marchandises transportées",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.light,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: MyColors.secondary,
                                        ),
                                        height: 40,
                                        width: double.infinity,
                                        child: Text(
                                          "Marchandise transportée",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.light,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                Column(
                                  children: (marchandises).map((marchandise) {
                                    TypeChargements type_cahrgement =
                                        function.type_chargement(
                                            type_chargements,
                                            marchandise.type_chargement_id);
                                    Devises devise = function.devise(
                                        devises, marchandise.devise_id);
                                    Expeditions expedition =
                                        function.marchandise_expedition(
                                            expeditions, marchandise);
                                    Statuts statut = function.statut(statuts,
                                        expedition.statu_expedition_id);
                                    Localisations localisation =
                                        function.marchandise_localisation(
                                            localisations, marchandise.id);
                                    Pays pay_depart = function.pay(
                                        pays, localisation.pays_exp_id);
                                    Pays pay_dest = function.pay(
                                        pays, localisation.pays_liv_id);
                                    Villes ville_dep = function.ville(
                                        all_villes, localisation.city_exp_id);
                                    Villes ville_dest = function.ville(
                                        all_villes, localisation.city_liv_id);
                                    Tarifications tarification =
                                        function.marchandise_tarification(
                                            tarifications, marchandise.id);
                                    Destinataires destinataire =
                                        function.marchandise_destinataire(
                                            destinataires, marchandise);
                                    Entreprises destinataire_entreprise =
                                        function.destinataire_entreprise(
                                            entreprises, destinataire.id);

                                    Users destinataire_user = function.user(
                                        users, destinataire.user_id);
                                    Transporteurs transporteur =
                                        function.expedition_transporteur(
                                            transporteurs, expedition);
                                    Users transporteur_user = function.user(
                                        users, transporteur.user_id);
                                    Entreprises transporteur_entreprise =
                                        function.transporteur_entreprise(
                                            entreprises, transporteur.id);
                                    Camions camion = function.expedition_camion(
                                        camions, expedition);
                                    Unites unite = function.unite(
                                        unites, marchandise.unite_id);

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      style: BorderStyle.solid,
                                                      width: 1,
                                                      color: user.dark_mode == 1
                                                          ? MyColors.light
                                                          : MyColors
                                                              .textColor)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            MyColors.textColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    height: 40,
                                                    width: double.infinity,
                                                    child: Text(
                                                      marchandise.nom,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: MyColors.light,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Identifiant",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            marchandise
                                                                .numero_marchandise,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Quantité",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            function.formatAmount(
                                                                marchandise
                                                                    .quantite
                                                                    .toDouble()),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Poids",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            marchandise.poids
                                                                    .toString() +
                                                                " " +
                                                                unite.name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        type_cahrgement.id > 0
                                                            ? Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "Type de chargement",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      type_cahrgement
                                                                          .name,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontWeight: FontWeight
                                                                              .w300,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                ],
                                                              )
                                                            : Container(),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Nombre de camions exigé",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            marchandise
                                                                .nombre_camions
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Tarif d'expédition",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            function.formatAmount(
                                                                    tarification
                                                                        .prix_expedition) +
                                                                " " +
                                                                devise.nom,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Date de chargement prévue",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            function.date(
                                                                marchandise
                                                                    .date_chargement),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Lieu de chargement",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            pay_depart.name +
                                                                " - " +
                                                                ville_dep.name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Lieu de déchargement",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            pay_dest.name +
                                                                " - " +
                                                                ville_dest.name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: user.dark_mode ==
                                                                        1
                                                                    ? MyColors
                                                                        .light
                                                                    : MyColors
                                                                        .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        destinataire.id > 0
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            20),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.textColor,
                                                                          style: BorderStyle.solid)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          color:
                                                                              MyColors.secondary,
                                                                        ),
                                                                        height:
                                                                            40,
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          "Destinataire de la marchandise",
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              color: MyColors.light,
                                                                              fontFamily: "Poppins",
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Référence",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire.numero_destinataire,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Nom",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire_user.name,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Contact",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire_user.telephone,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Adresse électronique",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire_user.email ?? "Non définie",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Adresse de résidence",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                destinataire_user.adresse ?? "Non définie",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            destinataire_entreprise.id > 0
                                                                                ? Column(
                                                                                    children: [
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          "Nom de l'entreprise",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 4,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          destinataire_entreprise.name,
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          "IFU/Numéro Fiscal",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 4,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          destinataire_entreprise.ifu ?? "Non définie",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : Container()
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                        expedition.id > 0
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            20),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      border: Border.all(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          width:
                                                                              1,
                                                                          color: user.dark_mode == 1
                                                                              ? MyColors.light
                                                                              : MyColors.textColor)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          color:
                                                                              MyColors.secondary,
                                                                        ),
                                                                        height:
                                                                            40,
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          "Expédition de la marchandise",
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              color: MyColors.light,
                                                                              fontFamily: "Poppins",
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Référence",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                expedition.numero_expedition,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Lieu de chargement",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                pay_depart.name + " - " + ville_dep.name,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Date de chargement",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                function.date(expedition.date_depart),
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                "Lieu de  déchargement",
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 4,
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                pay_dest.name + " - " + ville_dest.name,
                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            function.date(expedition.date_arrivee).isNotEmpty
                                                                                ? Column(
                                                                                    children: [
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          "Date de déchargement",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 4,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          function.date(expedition.date_arrivee),
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          "Statut de l'expédition",
                                                                                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 4,
                                                                                      ),
                                                                                      statut.name == "TERMINE"
                                                                                          ? Container(
                                                                                              alignment: Alignment.centerLeft,
                                                                                              child: Text(
                                                                                                "Expédition terminée".toUpperCase(),
                                                                                                style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: Colors.green),
                                                                                              ),
                                                                                            )
                                                                                          : statut.name == "EN COURS"
                                                                                              ? Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Expédition en cours".toUpperCase(),
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: MyColors.primary),
                                                                                                  ),
                                                                                                )
                                                                                              : Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Expédition non démarrée".toUpperCase(),
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: MyColors.secondary),
                                                                                                  ),
                                                                                                ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : Container(),
                                                                            transporteur.id > 0
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.only(bottom: 15),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(width: 1, style: BorderStyle.solid, color: user.dark_mode == 1 ? MyColors.light : MyColors.secondary)),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Container(
                                                                                            alignment: Alignment.center,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(15),
                                                                                              color: MyColors.secondary,
                                                                                            ),
                                                                                            height: 40,
                                                                                            width: double.infinity,
                                                                                            child: Text(
                                                                                              "Transporteur de la marchandise",
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              style: TextStyle(color: MyColors.light, fontFamily: "Poppins", fontWeight: FontWeight.w500),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                            child: Column(
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Référence",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur.numero_transporteur,
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Nom",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur_user.name,
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Contact",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur_user.telephone,
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Adresse électronique",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur_user.email ?? "Non définie",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    "Adresse de résidence",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Container(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    transporteur_user.adresse ?? "Non définie",
                                                                                                    style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 15,
                                                                                                ),
                                                                                                transporteur_entreprise.id > 0
                                                                                                    ? Column(
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              "Nom de l'entreprise",
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 4,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              transporteur_entreprise.name,
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 15,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              "IFU/Numéro Fiscal",
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 4,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              transporteur_entreprise.ifu ?? "Non définie",
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 15,
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    : Container(),
                                                                                                camion.id > 0
                                                                                                    ? Column(
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              "Immatriculation du camion",
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 4,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            alignment: Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              function.immatriculation(camion.num_immatriculation),
                                                                                                              style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300, color: user.dark_mode == 1 ? MyColors.light : MyColors.black),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 15,
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    : Container(),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Container()
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

void showAllFromAnnonce(
    BuildContext context,
    Annonces annonce,
    bool cant_delete,
    BonCommandes ordre,
    bool can_delete_ordre,
    bool can_validate,
    EntiteFactures entite_facture,
    DonneurOrdres donneur_ordre,
    Entreprises entite_entreprise,
    Entreprises donneur_entreprise,
    Users entite_user,
    Users donneur_user) {
  if (cant_delete) {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.9,
          message: "Supprimez l'annonce",
          backgroundColor: Colors.red,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();

            DeleteAnnonce(dialogcontext, annonce);
          },
        );
      },
    );
  }

  // Afficher l'alerte "Perte"
  Future.delayed(Duration(milliseconds: 500), () {
    if (ordre.id <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.8,
            message: "Ajoutez l'ordre de transport",
            backgroundColor: MyColors.secondary,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();
              Navigator.of(dialogcontext).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return AddOrdreTransport(
                      annonce: annonce,
                    );
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0)
                          .animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
          );
        },
      );
    }
  });

  Future.delayed(Duration(milliseconds: 800), () {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.7,
          message: "Ajoutez de marchandise",
          backgroundColor: MyColors.primary,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();
            Navigator.of(dialogcontext).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return PublishMarchandise(
                    annonce: annonce,
                  );
                },
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return ScaleTransition(
                    scale:
                        Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                    child: child,
                  );
                },
              ),
            );
          },
        );
      },
    );
  });

  if (can_delete_ordre) {
    showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return buildAlertDialog(
          context: dialogcontext,
          bottom: MediaQuery.of(dialogcontext).size.height * 0.6,
          message: "Supprimez l'ordre",
          backgroundColor: Colors.red,
          textColor: MyColors.light,
          onPressed: () {
            Navigator.of(dialogcontext).pop();

            DeleteOrdre(dialogcontext, ordre);
          },
        );
      },
    );
  }

  // Afficher l'alerte "Perte"
  Future.delayed(Duration(milliseconds: 500), () {
    if (ordre.id > 0 && ordre.is_validated == 0) {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          final provider = Provider.of<ProvAddOrdre>(dialogcontext);
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.5,
            message: "Modifiez l'ordre de transport",
            backgroundColor: MyColors.secondary,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();
              provider.change_ordre(
                  ordre,
                  entite_facture,
                  donneur_ordre,
                  entite_user,
                  donneur_user,
                  donneur_entreprise,
                  entite_entreprise);
              Navigator.of(dialogcontext).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return UpOrdreTransport(id: ordre.id);
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0)
                          .animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
          );
        },
      );
    }
  });

  Future.delayed(Duration(milliseconds: 800), () {
    if (can_validate) {
      showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return buildAlertDialog(
            context: dialogcontext,
            bottom: MediaQuery.of(dialogcontext).size.height * 0.65,
            message: "Validez l'ordre",
            backgroundColor: MyColors.primary,
            textColor: MyColors.light,
            onPressed: () {
              Navigator.of(dialogcontext).pop();
              ValidateOrdre(dialogcontext, ordre);
            },
          );
        },
      );
    }
  });
}

Future<dynamic> DeleteAnnonce(BuildContext context, Annonces annonce) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialocontext) {
      final function = Provider.of<Functions>(dialocontext);
      final service = Provider.of<DBServices>(dialocontext);

      return AlertDialog(
        title: Text(
          "Suppression de l'annonce",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Voulez-vous vraiment supprimer l'annonce " + annonce.numero_annonce,
          style: TextStyle(
              color: function.convertHexToColor("#79747E"),
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.of(dialocontext).pop();
                  },
                  child: Text(
                    "Annulez",
                    style: TextStyle(
                        color: function.convertHexToColor("#DE2402"),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 1),
                  )),
              TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () async {
                    final String statut = await service.deleteAnnonce(annonce);
                    if (statut == "202") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Une erreur s'est produite",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else if (statut == "100") {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Données invalid',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    } else {
                      Navigator.of(dialocontext).pop();
                      Navigator.of(dialocontext).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) => Align(
                            alignment: Alignment.topLeft,
                            child: AnnonceMarchandises(),
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                      final snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "L'annonce a été supprimée avec succès",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(dialocontext).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    "Supprimez",
                    style: TextStyle(
                        color: MyColors.secondary,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 1),
                  )),
            ],
          ),
        ],
      );
    },
  );
}
