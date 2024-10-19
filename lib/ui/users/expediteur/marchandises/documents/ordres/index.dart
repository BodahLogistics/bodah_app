// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_adjacent_string_concatenation, deprecated_member_use

import 'dart:io';

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/bon_commandes.dart';
import 'package:bodah/modals/paiement_solde.dart';
import 'package:bodah/modals/tarifications.dart';
import 'package:bodah/modals/type_paiements.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/destinataires.dart';
import '../../../../../../modals/donneur_ordres.dart';
import '../../../../../../modals/entite_factures.dart';
import '../../../../../../modals/entreprises.dart';
import '../../../../../../modals/expediteurs.dart';
import '../../../../../../modals/localisations.dart';
import '../../../../../../modals/marchandises.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/signature.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../../providers/api/download.dart';
import '../../../../../../services/data_base_service.dart';
import '../../../../../auth/sign_in.dart';
import '../../../drawer/index.dart';
import '../../nav_bottom/index.dart';

class MesOrdres extends StatelessWidget {
  const MesOrdres({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<BonCommandes> datas = api_provider.ordres;
    List<Annonces> annonces = api_provider.annonces;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;

    List<DonneurOrdres> donneur_ordres = api_provider.donneur_ordres;
    List<EntiteFactures> entite_factures = api_provider.entite_factures;
    List<Entreprises> entreprises = api_provider.entreprises;
    List<Users> users = api_provider.users;
    List<Destinataires> destinataires = api_provider.destinataires;
    List<Expediteurs> expediteurs = api_provider.expediteurs;
    List<Signatures> signatures = api_provider.signatures;
    List<TypePaiements> type_paiements = api_provider.type_piaments;
    List<PaiementSolde> paiements = api_provider.paiement_soldes;
    List<Tarifications> tarifications = api_provider.tarifications;

    Future<void> refresh() async {
      await api_provider.InitOrdres();
      await api_provider.InitForSomeOrdre();
    }

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      bottomNavigationBar: NavigBot(),
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
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.w500,
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
      body: datas.isEmpty
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
                      padding: const EdgeInsets.all(
                          16.0), // Ajoute un peu de padding
                      child: Text(
                        "Aucune donnée disponible",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: user.dark_mode == 1
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      BonCommandes data = datas[index];

                      Signatures signature =
                          function.signature(signatures, data.signature_id);
                      TypePaiements type_paiement = function.type_piament(
                          type_paiements, data.type_paiement_id);

                      Annonces annonce =
                          function.annonce(annonces, data.annonce_id);

                      Marchandises marchandise = function
                          .annonce_marchandises(marchandises, annonce.id)
                          .first;

                      List<PaiementSolde> paiem = function.paiement_soldes(
                          paiements, "Marchandise", marchandise.id);
                      Localisations localisation =
                          function.marchandise_localisation(
                              localisations, marchandise.id);
                      Pays pay_depart =
                          function.pay(pays, localisation.pays_exp_id);
                      Pays pay_dest =
                          function.pay(pays, localisation.pays_liv_id);
                      Villes ville_dep =
                          function.ville(all_villes, localisation.city_exp_id);
                      Villes ville_dest =
                          function.ville(all_villes, localisation.city_liv_id);

                      EntiteFactures entite_facture = function.entite_facture(
                          entite_factures, data.entite_facture_id);
                      DonneurOrdres donneur_ordre = function.donneur_ordres(
                          donneur_ordres, data.donneur_ordre_id);

                      Users donneur_user =
                          function.user(users, donneur_ordre.user_id);
                      Users entite_user =
                          function.user(users, entite_facture.user_id);
                      Expediteurs expediteur = function.expediteur(
                          expediteurs, annonce.expediteur_id);
                      Entreprises entreprise = function.expediteur_entreprise(
                          entreprises, expediteur.id);
                      Users expediteur_user =
                          function.user(users, expediteur.user_id);
                      Destinataires destinataire = function
                          .marchandise_destinataire(destinataires, marchandise);
                      Users destinataire_user =
                          function.user(users, destinataire.user_id);
                      Expediteurs destinataire_expediteur = function
                          .user_expediteur(expediteurs, destinataire_user);
                      Entreprises destinataire_entreprise =
                          function.expediteur_entreprise(
                              entreprises, destinataire_expediteur.id);
                      Expediteurs donneur_expediteur =
                          function.user_expediteur(expediteurs, donneur_user);
                      Entreprises donneur_entreprise =
                          function.expediteur_entreprise(
                              entreprises, donneur_expediteur.id);
                      Expediteurs entite_expediteur =
                          function.user_expediteur(expediteurs, entite_user);
                      Entreprises entite_entreprise =
                          function.expediteur_entreprise(
                              entreprises, entite_expediteur.id);
                      Tarifications tarification =
                          function.marchandise_tarification(
                              tarifications, marchandise.id);
                      double montant = tarification.prix_expedition;
                      double accompte = data.montant_paye;
                      double totalPay = function.totalPaiement(paiem);
                      double solde = montant - accompte - totalPay;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return DetailOrdre(
                                    id: data.id,
                                  );
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
                                          data.numero_bon_commande,
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
                                    height: 10,
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
                                      localisation.address_exp?.isEmpty ?? true
                                          ? Expanded(
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
                                          : Expanded(
                                              child: Text(
                                                (localisation.address_exp ??
                                                        "") +
                                                    " , " +
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
                                    height: 10,
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
                                      localisation.address_liv?.isEmpty ?? true
                                          ? Expanded(
                                              child: Text(
                                                ville_dest.name +
                                                    " , " +
                                                    pay_dest.name,
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
                                          : Expanded(
                                              child: Text(
                                                localisation.address_liv ??
                                                    "" +
                                                        " , " +
                                                        ville_dest.name +
                                                        " , " +
                                                        pay_dest.name,
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
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date : ",
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
                                          function.date(
                                              marchandise.date_chargement),
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
                                  data.is_validated == 1 ||
                                          data.signature_id != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: SizedBox(
                                            height: 25,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                onPressed: () {
                                                  downloadOrdre(
                                                      context,
                                                      data,
                                                      donneur_ordre,
                                                      entite_facture,
                                                      donneur_user,
                                                      entite_user,
                                                      donneur_expediteur,
                                                      entite_expediteur,
                                                      entite_entreprise,
                                                      donneur_entreprise,
                                                      expediteur,
                                                      expediteur_user,
                                                      entreprise,
                                                      signature,
                                                      marchandise,
                                                      localisation,
                                                      pay_depart,
                                                      pay_dest,
                                                      ville_dep,
                                                      ville_dest,
                                                      type_paiement,
                                                      montant,
                                                      accompte,
                                                      solde,
                                                      destinataire,
                                                      destinataire_user,
                                                      destinataire_expediteur,
                                                      destinataire_entreprise,
                                                      function);
                                                },
                                                child: Text(
                                                  "Téléchargez",
                                                  style: TextStyle(
                                                      color: MyColors.light,
                                                      fontSize: 10,
                                                      fontFamily: "Poppins"),
                                                )),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: SizedBox(
                                            height: 25,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                onPressed: () {
                                                  signerOrdre(context, data);
                                                },
                                                child: Text(
                                                  "Signez",
                                                  style: TextStyle(
                                                      color: MyColors.light,
                                                      fontSize: 10,
                                                      fontFamily: "Poppins"),
                                                )),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: datas.length,
                  ),
                ),
              ),
            ),
    );
  }
}

void signerOrdre(BuildContext context, BonCommandes data) {
  Future.delayed(Duration(milliseconds: 500), () {
    SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvDown>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        bool affiche = provider.affiche;
        final service = Provider.of<DBServices>(dialogcontext);

        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Votre signature",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColors.secondary),
                child: IconButton(
                  icon: Icon(Icons.close, size: 15, color: MyColors.light),
                  onPressed: () {
                    controller.clear();
                    provider.change_affiche(false);
                    Navigator.of(dialogcontext).pop(); // Ferme le dialogue
                  },
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 200, // La hauteur exacte que vous souhaitez
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Prendre uniquement l'espace nécessaire
              children: [
                Signature(
                  controller: controller,
                  height: 200, // Hauteur définie pour le widget de signature
                  backgroundColor: Colors.grey[200]!,
                ),
              ],
            ),
          ),
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
                        controller.clear();
                        provider.change_affiche(false);
                      },
                      child: Text(
                        "Reprenez",
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
                        backgroundColor: Colors.green),
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);
                            Directory tempDir = await getTemporaryDirectory();
                            String filePath = '${tempDir.path}/signature.png';
                            var signatureImage = await controller.toPngBytes();

                            if (signatureImage != null) {
                              File file = File(filePath);
                              await file.writeAsBytes(signatureImage);

                              String satatutCode = await service.signatureOrdre(
                                  data, file, api_provider);

                              if (satatutCode == "202") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Une erreur inattendue s'est produite",
                                    const Color.fromARGB(255, 233, 186, 186));
                              } else if (satatutCode == "404") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Impossible de signer cet ordre de transport",
                                    Colors.redAccent);
                              } else if (satatutCode == "422") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Vous n'avez pas signer avant dee valider",
                                    Colors.redAccent);
                              } else if (satatutCode == "500") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Vérifiez votre connection internet et réessayer plus tard",
                                    Colors.redAccent);
                              } else if (satatutCode == "200") {
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Votre signature a été enregistrée avec succès",
                                    Colors.green);
                                controller.clear();
                                Navigator.of(dialogcontext).pop();
                              }
                            } else {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Vous devez signer avant de valider",
                                  Colors.redAccent);
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
                            "Validez",
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
  });
}

void downloadOrdre(
    BuildContext context,
    BonCommandes data,
    DonneurOrdres donneur,
    EntiteFactures entite,
    Users donneur_user,
    Users entite_user,
    Expediteurs donneur_expediteur,
    Expediteurs entite_expediteur,
    Entreprises entite_entreprise,
    Entreprises donneur_entreprise,
    Expediteurs expediteur,
    Users expediteur_user,
    Entreprises expediteur_entreprise,
    Signatures signature,
    Marchandises marchandise,
    Localisations localisation,
    Pays pay_depart,
    Pays pay_livraison,
    Villes city_depart,
    Villes city_livraison,
    TypePaiements type_paiement,
    double montant,
    double accompte,
    double solde,
    Destinataires destinataire,
    Users destinataire_user,
    Expediteurs destinataire_expediteur,
    Entreprises destinataire_entreprise,
    Functions function) {
  Future.delayed(Duration(milliseconds: 500), () {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProvDown>(dialogcontext);
        final api_provider = Provider.of<ApiProvider>(dialogcontext);
        Users? user = api_provider.user;
        bool affiche = provider.affiche;

        return AlertDialog(
          backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
          title: Text(
            "Ordre de transport",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: user.dark_mode == 1 ? MyColors.light : MyColors.black,
                fontWeight: FontWeight.bold),
          ),
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
                        Navigator.of(dialogcontext).pop();
                      },
                      child: Text(
                        "Annulez",
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
                        backgroundColor: Colors.green),
                    onPressed: affiche
                        ? null
                        : () async {
                            provider.change_affiche(true);

                            if (data.signature_id != null &&
                                signature.id == 0) {
                              provider.change_affiche(false);
                              showCustomSnackBar(
                                  dialogcontext,
                                  "Veuillez récharger la page et réessayer",
                                  Colors.redAccent);
                            } else {
                              if (signature.id != 0) {
                                await generateOrdre(
                                    data,
                                    donneur,
                                    entite,
                                    donneur_user,
                                    entite_user,
                                    donneur_expediteur,
                                    entite_expediteur,
                                    entite_entreprise,
                                    donneur_entreprise,
                                    expediteur,
                                    expediteur_user,
                                    expediteur_entreprise,
                                    signature,
                                    marchandise,
                                    localisation,
                                    pay_depart,
                                    pay_livraison,
                                    city_depart,
                                    city_livraison,
                                    type_paiement,
                                    montant,
                                    accompte,
                                    solde,
                                    destinataire,
                                    destinataire_user,
                                    destinataire_expediteur,
                                    destinataire_entreprise,
                                    function,
                                    dialogcontext);
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Le document a été généré avec succès",
                                    Colors.green);
                                Navigator.of(dialogcontext).pop();
                              } else {
                                await generateSecondOrdre(
                                    data,
                                    donneur,
                                    entite,
                                    donneur_user,
                                    entite_user,
                                    donneur_expediteur,
                                    entite_expediteur,
                                    entite_entreprise,
                                    donneur_entreprise,
                                    expediteur,
                                    expediteur_user,
                                    expediteur_entreprise,
                                    marchandise,
                                    localisation,
                                    pay_depart,
                                    pay_livraison,
                                    city_depart,
                                    city_livraison,
                                    type_paiement,
                                    montant,
                                    accompte,
                                    solde,
                                    destinataire,
                                    destinataire_user,
                                    destinataire_expediteur,
                                    destinataire_entreprise,
                                    function,
                                    dialogcontext);
                                provider.change_affiche(false);
                                showCustomSnackBar(
                                    dialogcontext,
                                    "Le document a été généré avec succès",
                                    Colors.green);
                                Navigator.of(dialogcontext).pop();
                              }
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
                            "Téléchargez",
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
  });
}

Future<void> generateOrdre(
    BonCommandes data,
    DonneurOrdres donneur,
    EntiteFactures entite,
    Users donneur_user,
    Users entite_user,
    Expediteurs donneur_expediteur,
    Expediteurs entite_expediteur,
    Entreprises entite_entreprise,
    Entreprises donneur_entreprise,
    Expediteurs expediteur,
    Users expediteur_user,
    Entreprises expediteur_entreprise,
    Signatures signature,
    Marchandises marchandise,
    Localisations localisation,
    Pays pay_depart,
    Pays pay_livraison,
    Villes city_depart,
    Villes city_livraison,
    TypePaiements type_paiement,
    double montant,
    double accompte,
    double solde,
    Destinataires destinataire,
    Users destinataire_user,
    Expediteurs destinataire_expediteur,
    Entreprises destinataire_entreprise,
    Functions function,
    BuildContext context) async {
  try {
    final pdf = pw.Document();

    final fontData = await rootBundle.load("fonts/Poppins-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    final signUrl = "https://test.bodah.bj/storage/${signature.path}";

    final response = await http.get(Uri.parse(signUrl));

    if (response.statusCode == 200) {
      final signatureDriver = pw.MemoryImage(response.bodyBytes);

      final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()) +
          " à " +
          DateFormat('HH:mm:ss').format(DateTime.now());
      final ref = DateFormat("yyyy").format(data.created_at) +
          " " +
          DateFormat("MM").format(data.created_at) +
          " " +
          DateFormat("dd").format(data.created_at) +
          " " +
          DateFormat("HH:mm:ss").format(data.created_at);

      pdf.addPage(
        pw.MultiPage(
          maxPages: 100,
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(20),
          header: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(currentDate,
                    style: pw.TextStyle(font: ttf, fontSize: 7)),
              ],
            );
          },
          footer: (pw.Context context) {
            return pw.Center(
              child: pw.Text('CONFIEZ-VOUS AUX PROFESSIONNELS !',
                  style: pw.TextStyle(
                      font: ttf, fontSize: 10, fontWeight: pw.FontWeight.bold)),
            );
          },
          build: (pw.Context context) => [
            pw.Column(
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 10),
                  child: pw.Column(
                    children: [
                      // Section du titre et du QR code
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Ordre de transport sécurisé N° ${data.numero_bon_commande}'
                                .toUpperCase(),
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 9,
                                fontWeight: pw.FontWeight.bold),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Column(
                            children: [
                              pw.BarcodeWidget(
                                barcode: pw.Barcode.qrCode(),
                                data: donneur_entreprise.id != 0
                                    ? "${data.numero_bon_commande} ${donneur_entreprise.name} $ref"
                                    : "${data.numero_bon_commande} ${donneur_user.name} $ref",
                                width: 60,
                                height: 60,
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                  'Scannez ici pour authentifier le document',
                                  style: pw.TextStyle(font: ttf, fontSize: 3)),
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),

                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(5),
                          1: pw.FlexColumnWidth(1.5),
                          2: pw.FlexColumnWidth(2),
                          3: pw.FlexColumnWidth(1.5),
                          4: pw.FlexColumnWidth(2),
                        },
                        children: [
                          pw.TableRow(
                            decoration: pw.BoxDecoration(
                              color: PdfColors.orange, // Couleur d'en-tête
                            ),
                            children: [
                              donneur_user.id != entite_user.id
                                  ? pw.Padding(
                                      padding: pw.EdgeInsets.all(5),
                                      child: pw.Text(
                                        "DONNEUR D'ORDRE",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 10,
                                          color: PdfColors.black,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    )
                                  : pw.Padding(
                                      padding: pw.EdgeInsets.all(5),
                                      child: pw.Text(
                                        "DONNEUR D'ORDRE/Entité à facturer"
                                            .toUpperCase(),
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 10,
                                          color: PdfColors.black,
                                        ),
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    'IDENTIFIANT',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    donneur.reference,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8,
                                      color: PdfColors.white,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    'DATE',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Center(
                                  child: pw.Text(
                                    function.date(marchandise.date_chargement),
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10,
                                      color: PdfColors.white,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      pw.Table.fromTextArray(
                        border: pw.TableBorder.all(),
                        headers: ['Nom', 'IFU', 'Adresse', 'Tél', 'Email'],
                        headerStyle: pw.TextStyle(
                          font: ttf, // Police
                          fontSize: 10, // Taille de police
                          fontWeight: pw.FontWeight.bold, // En gras
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center
                        },
                        data: [
                          [
                            donneur_entreprise.id != 0
                                ? donneur_entreprise.name
                                : donneur_user.name,
                            donneur_entreprise.id != 0
                                ? donneur_entreprise.ifu ?? "---"
                                : "----",
                            donneur_user.adresse ?? "-----",
                            donneur_user.telephone,
                            donneur_user.email ?? "----"
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                      ),

                      donneur_user.id != entite_user.id
                          ? pw.Column(children: [
                              pw.SizedBox(height: 10),
                              pw.Container(
                                decoration: pw.BoxDecoration(
                                  color: PdfColors.orange,
                                ),
                                padding: const pw.EdgeInsets.all(5),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  "Entité à facturer".toUpperCase(),
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              ),
                              pw.Table.fromTextArray(
                                border: pw.TableBorder.all(),
                                headers: [
                                  'Nom',
                                  'IFU',
                                  'Adresse',
                                  'Tél',
                                  'Email'
                                ],
                                headerStyle: pw.TextStyle(
                                  font: ttf, // Police
                                  fontSize: 10, // Taille de police
                                  fontWeight: pw.FontWeight.bold, // En gras
                                  color: PdfColors
                                      .black, // Couleur du texte des en-têtes
                                ),
                                cellAlignments: {
                                  0: pw.Alignment.center,
                                  1: pw.Alignment.center,
                                  2: pw.Alignment.center,
                                  3: pw.Alignment.center,
                                  4: pw.Alignment.center,
                                },
                                data: [
                                  [
                                    entite_entreprise.id != 0
                                        ? entite_entreprise.name
                                        : entite_user.name,
                                    entite_entreprise.id != 0
                                        ? entite_entreprise.ifu ?? "---"
                                        : "----",
                                    entite_user.adresse ?? "-----",
                                    entite_user.telephone,
                                    entite_user.email ?? "----",
                                  ]
                                ],
                                cellStyle: pw.TextStyle(
                                  font: ttf, // Police pour le contenu
                                  fontSize:
                                      8, // Taille de police pour les cellules
                                ),
                              ),
                            ])
                          : pw.Container(),

                      pw.SizedBox(height: 10),

                      pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.orange,
                        ),
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "TRANSPORTEUR",
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),

                      pw.Table.fromTextArray(
                        border: pw.TableBorder.all(),
                        headers: ['Nom', 'IFU', 'Adresse', 'Tél', 'Email'],
                        headerStyle: pw.TextStyle(
                          font: ttf, // Police
                          fontSize: 10, // Taille de police
                          fontWeight: pw.FontWeight.bold, // En gras
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                        },
                        data: [
                          [
                            'BODAH LOGISTICS SARL',
                            '32 02 32 27 30 95 2',
                            'RNIE1, Godomey, Abomey-Calavi, Bénin',
                            '+229 20 22 60 42',
                            'info@bodah.bj'
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                      ),

                      pw.SizedBox(height: 10),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.orange,
                        ),
                        padding: const pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "MARCHANDISE",
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),

                      pw.Table.fromTextArray(
                        border: pw.TableBorder.all(),
                        headers: [
                          "Référence",
                          'Nature',
                          'Quantité',
                          'Poids',
                          'Lieu de chargement',
                          'Date de chargement',
                          'Lieu de livraison',
                          'Date de livraison'
                        ],
                        headerStyle: pw.TextStyle(
                          font: ttf, // Police
                          fontSize: 7, // Taille de police
                          fontWeight: pw.FontWeight.bold, // En gras
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        data: [
                          [
                            marchandise.numero_marchandise,
                            marchandise.nom,
                            marchandise.quantite,
                            marchandise.poids,
                            localisation.address_exp != null
                                ? "${localisation.address_exp} , ${city_depart.name}, ${pay_depart.name}"
                                : "${city_depart.name} , ${pay_depart.name}",
                            function.date(marchandise.date_chargement),
                            localisation.address_liv != null
                                ? "${localisation.address_liv} , ${city_livraison.name}, ${pay_livraison.name}"
                                : "${city_livraison.name} , ${pay_livraison.name}",
                            '---'
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 7, // Taille de police pour les cellules
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                          5: pw.Alignment.center,
                          6: pw.Alignment.center,
                          7: pw.Alignment.center,
                        },
                      ),

                      destinataire.id != 0
                          ? pw.Column(children: [
                              pw.SizedBox(height: 10),
                              pw.Container(
                                decoration: pw.BoxDecoration(
                                  color: PdfColors.orange,
                                ),
                                padding: const pw.EdgeInsets.all(5),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  "DESTINATAIRE",
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              ),
                              pw.Table.fromTextArray(
                                border: pw.TableBorder.all(),
                                headers: [
                                  'Nom',
                                  'IFU',
                                  'Adresse',
                                  'Tél',
                                  'Email',
                                ],
                                headerStyle: pw.TextStyle(
                                  font: ttf, // Police
                                  fontSize: 10, // Taille de police
                                  fontWeight: pw.FontWeight.bold, // En gras
                                  color: PdfColors
                                      .black, // Couleur du texte des en-têtes
                                ),
                                cellAlignments: {
                                  0: pw.Alignment.center,
                                  1: pw.Alignment.center,
                                  2: pw.Alignment.center,
                                  3: pw.Alignment.center,
                                  4: pw.Alignment.center,
                                },
                                data: [
                                  [
                                    destinataire_entreprise.id != 0
                                        ? destinataire_entreprise.name
                                        : destinataire_user.name,
                                    destinataire_entreprise.id != 0
                                        ? destinataire_entreprise.ifu ?? "---"
                                        : "----",
                                    destinataire_user.adresse ?? "-----",
                                    destinataire_user.telephone,
                                    destinataire_user.email ?? "----",
                                  ]
                                ],
                                cellStyle: pw.TextStyle(
                                  font: ttf, // Police pour le contenu
                                  fontSize:
                                      8, // Taille de police pour les cellules
                                ),
                              ),
                            ])
                          : pw.Container(),

                      pw.SizedBox(height: 15),
                      pw.Container(
                        width: double
                            .infinity, // Pour prendre toute la largeur disponible
                        padding: const pw.EdgeInsets.all(7),
                        decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1),
                        ),
                        child: pw.Text(
                          "REGLEMENT",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              fontSize: 8,
                              color: PdfColors.black),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Table.fromTextArray(
                        border: pw.TableBorder.all(),
                        headers: [
                          'Tarif',
                          'Quantité',
                          'Accompte',
                          'Solde',
                          'Paiement',
                        ],
                        headerStyle: pw.TextStyle(
                          font: ttf, // Police
                          fontSize: 10, // Taille de police
                          fontWeight: pw.FontWeight.bold, // En gras
                          color:
                              PdfColors.black, // Couleur du texte des en-têtes
                        ),
                        cellAlignments: {
                          0: pw.Alignment.center,
                          1: pw.Alignment.center,
                          2: pw.Alignment.center,
                          3: pw.Alignment.center,
                          4: pw.Alignment.center,
                        },
                        data: [
                          [
                            function.formatAmount(montant) + " XOF",
                            marchandise.quantite,
                            function.formatAmount(accompte) + " XOF",
                            function.formatAmount(solde) + " XOF",
                            type_paiement.nom
                          ]
                        ],
                        cellStyle: pw.TextStyle(
                          font: ttf, // Police pour le contenu
                          fontSize: 8, // Taille de police pour les cellules
                        ),
                      ),
                      pw.SizedBox(height: 15),
                      // Section de Règlement (Termes)
                      pw.Container(
                        width: double
                            .infinity, // Pour prendre toute la largeur disponible
                        padding: const pw.EdgeInsets.all(7),
                        decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1),
                        ),
                        child: pw.Text(
                          "Informatiosn et dispositions complémentaires"
                              .toUpperCase(),
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              fontSize: 8,
                              color: PdfColors.black),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),

                      pw.Container(
                          width: double.infinity,
                          padding: const pw.EdgeInsets.all(7),
                          decoration: pw.BoxDecoration(
                            border:
                                pw.Border.all(color: PdfColors.black, width: 1),
                          ),
                          child: pw.Column(children: [
                            pw.Text(
                              "La franchise est de 72 heures . Passé ce délai, STL BENIN sera facturé à 25. 000,00 XOF par jour et par camion pour les frais de stationnement de camion.",
                              maxLines: 10,
                              overflow: pw.TextOverflow.visible,
                              style: pw.TextStyle(font: ttf, fontSize: 7),
                              textAlign: pw.TextAlign.justify,
                            ),
                            pw.Text(
                              "L'annulation d'un chargement une fois que le camion se trouve sur le lieu de chargement expose STL BENIN  à un paiement de 25. 000,00 XOF par camion",
                              maxLines: 10,
                              overflow: pw.TextOverflow.visible,
                              style: pw.TextStyle(font: ttf, fontSize: 7),
                              textAlign: pw.TextAlign.justify,
                            ),
                          ])),

                      pw.SizedBox(height: 30),

                      pw.Column(
                        children: [
                          donneur_entreprise.id != 0
                              ? pw.Text(donneur_entreprise.name,
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black))
                              : pw.Text("DONNEUR D'ORDRE",
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black)),
                          pw.SizedBox(height: 0),
                          pw.Image(signatureDriver, width: 80, height: 70),
                          pw.SizedBox(height: 10),
                          pw.Text(donneur_user.name,
                              style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

      final current = DateFormat('yyyy-MM-dd').format(DateTime.now()) +
          "_" +
          DateFormat('HH-mm-ss').format(DateTime.now());
      String fileName = "ordre_transport_sécurisé_$current.pdf";
      final output = await getExternalStorageDirectory();
      final file = File("${output!.path}/$fileName");
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path);
    }
  } catch (e) {
    showCustomSnackBar(context, "Erreur de connection", Colors.redAccent);
  }
}

Future<void> generateSecondOrdre(
    BonCommandes data,
    DonneurOrdres donneur,
    EntiteFactures entite,
    Users donneur_user,
    Users entite_user,
    Expediteurs donneur_expediteur,
    Expediteurs entite_expediteur,
    Entreprises entite_entreprise,
    Entreprises donneur_entreprise,
    Expediteurs expediteur,
    Users expediteur_user,
    Entreprises expediteur_entreprise,
    Marchandises marchandise,
    Localisations localisation,
    Pays pay_depart,
    Pays pay_livraison,
    Villes city_depart,
    Villes city_livraison,
    TypePaiements type_paiement,
    double montant,
    double accompte,
    double solde,
    Destinataires destinataire,
    Users destinataire_user,
    Expediteurs destinataire_expediteur,
    Entreprises destinataire_entreprise,
    Functions function,
    BuildContext context) async {
  final pdf = pw.Document();

  final fontData = await rootBundle.load("fonts/Poppins-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);

  final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()) +
      " à " +
      DateFormat('HH:mm:ss').format(DateTime.now());
  final ref = DateFormat("yyyy").format(data.created_at) +
      " " +
      DateFormat("MM").format(data.created_at) +
      " " +
      DateFormat("dd").format(data.created_at) +
      " " +
      DateFormat("HH:mm:ss").format(data.created_at);

  pdf.addPage(
    pw.MultiPage(
      maxPages: 100,
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(20),
      header: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(currentDate, style: pw.TextStyle(font: ttf, fontSize: 7)),
          ],
        );
      },
      footer: (pw.Context context) {
        return pw.Center(
          child: pw.Text('CONFIEZ-VOUS AUX PROFESSIONNELS !',
              style: pw.TextStyle(
                  font: ttf, fontSize: 10, fontWeight: pw.FontWeight.bold)),
        );
      },
      build: (pw.Context context) => [
        pw.Column(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.only(top: 10),
              child: pw.Column(
                children: [
                  // Section du titre et du QR code
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Ordre de transport sécurisé N° ${data.numero_bon_commande}'
                            .toUpperCase(),
                        style: pw.TextStyle(
                            font: ttf,
                            fontSize: 9,
                            fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Column(
                        children: [
                          pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data: donneur_entreprise.id != 0
                                ? "${data.numero_bon_commande} ${donneur_entreprise.name} $ref"
                                : "${data.numero_bon_commande} ${donneur_user.name} $ref",
                            width: 60,
                            height: 60,
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text('Scannez ici pour authentifier le document',
                              style: pw.TextStyle(font: ttf, fontSize: 3)),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),

                  pw.Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: pw.FlexColumnWidth(5),
                      1: pw.FlexColumnWidth(1.5),
                      2: pw.FlexColumnWidth(2),
                      3: pw.FlexColumnWidth(1.5),
                      4: pw.FlexColumnWidth(2),
                    },
                    children: [
                      pw.TableRow(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.orange, // Couleur d'en-tête
                        ),
                        children: [
                          donneur_user.id != entite_user.id
                              ? pw.Padding(
                                  padding: pw.EdgeInsets.all(5),
                                  child: pw.Text(
                                    "DONNEUR D'ORDRE",
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                )
                              : pw.Padding(
                                  padding: pw.EdgeInsets.all(5),
                                  child: pw.Text(
                                    "DONNEUR D'ORDRE/Entité à facturer"
                                        .toUpperCase(),
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(5),
                            child: pw.Center(
                              child: pw.Text(
                                'IDENTIFIANT',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8,
                                  color: PdfColors.black,
                                ),
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(5),
                            child: pw.Center(
                              child: pw.Text(
                                donneur.reference,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8,
                                  color: PdfColors.white,
                                ),
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(5),
                            child: pw.Center(
                              child: pw.Text(
                                'DATE',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(5),
                            child: pw.Center(
                              child: pw.Text(
                                function.date(marchandise.date_chargement),
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  color: PdfColors.white,
                                ),
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  pw.Table.fromTextArray(
                    border: pw.TableBorder.all(),
                    headers: ['Nom', 'IFU', 'Adresse', 'Tél', 'Email'],
                    headerStyle: pw.TextStyle(
                      font: ttf, // Police
                      fontSize: 10, // Taille de police
                      fontWeight: pw.FontWeight.bold, // En gras
                      color: PdfColors.black, // Couleur du texte des en-têtes
                    ),
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center
                    },
                    data: [
                      [
                        donneur_entreprise.id != 0
                            ? donneur_entreprise.name
                            : donneur_user.name,
                        donneur_entreprise.id != 0
                            ? donneur_entreprise.ifu ?? "---"
                            : "----",
                        donneur_user.adresse ?? "-----",
                        donneur_user.telephone,
                        donneur_user.email ?? "----"
                      ]
                    ],
                    cellStyle: pw.TextStyle(
                      font: ttf, // Police pour le contenu
                      fontSize: 8, // Taille de police pour les cellules
                    ),
                  ),

                  donneur_user.id != entite_user.id
                      ? pw.Column(children: [
                          pw.SizedBox(height: 10),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              color: PdfColors.orange,
                            ),
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Entité à facturer".toUpperCase(),
                              style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black),
                            ),
                          ),
                          pw.Table.fromTextArray(
                            border: pw.TableBorder.all(),
                            headers: ['Nom', 'IFU', 'Adresse', 'Tél', 'Email'],
                            headerStyle: pw.TextStyle(
                              font: ttf, // Police
                              fontSize: 10, // Taille de police
                              fontWeight: pw.FontWeight.bold, // En gras
                              color: PdfColors
                                  .black, // Couleur du texte des en-têtes
                            ),
                            cellAlignments: {
                              0: pw.Alignment.center,
                              1: pw.Alignment.center,
                              2: pw.Alignment.center,
                              3: pw.Alignment.center,
                              4: pw.Alignment.center,
                            },
                            data: [
                              [
                                entite_entreprise.id != 0
                                    ? entite_entreprise.name
                                    : entite_user.name,
                                entite_entreprise.id != 0
                                    ? entite_entreprise.ifu ?? "---"
                                    : "----",
                                entite_user.adresse ?? "-----",
                                entite_user.telephone,
                                entite_user.email ?? "----",
                              ]
                            ],
                            cellStyle: pw.TextStyle(
                              font: ttf, // Police pour le contenu
                              fontSize: 8, // Taille de police pour les cellules
                            ),
                          ),
                        ])
                      : pw.Container(),

                  pw.SizedBox(height: 10),

                  pw.Container(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.orange,
                    ),
                    padding: const pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      "TRANSPORTEUR",
                      style: pw.TextStyle(
                          font: ttf,
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black),
                    ),
                  ),

                  pw.Table.fromTextArray(
                    border: pw.TableBorder.all(),
                    headers: ['Nom', 'IFU', 'Adresse', 'Tél', 'Email'],
                    headerStyle: pw.TextStyle(
                      font: ttf, // Police
                      fontSize: 10, // Taille de police
                      fontWeight: pw.FontWeight.bold, // En gras
                      color: PdfColors.black, // Couleur du texte des en-têtes
                    ),
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                    },
                    data: [
                      [
                        'BODAH LOGISTICS SARL',
                        '32 02 32 27 30 95 2',
                        'RNIE1, Godomey, Abomey-Calavi, Bénin',
                        '+229 20 22 60 42',
                        'info@bodah.bj'
                      ]
                    ],
                    cellStyle: pw.TextStyle(
                      font: ttf, // Police pour le contenu
                      fontSize: 8, // Taille de police pour les cellules
                    ),
                  ),

                  pw.SizedBox(height: 10),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.orange,
                    ),
                    padding: const pw.EdgeInsets.all(5),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      "MARCHANDISE",
                      style: pw.TextStyle(
                          font: ttf,
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black),
                    ),
                  ),

                  pw.Table.fromTextArray(
                    border: pw.TableBorder.all(),
                    headers: [
                      "Référence",
                      'Nature',
                      'Quantité',
                      'Poids',
                      'Lieu de chargement',
                      'Date de chargement',
                      'Lieu de livraison',
                      'Date de livraison'
                    ],
                    headerStyle: pw.TextStyle(
                      font: ttf, // Police
                      fontSize: 7, // Taille de police
                      fontWeight: pw.FontWeight.bold, // En gras
                      color: PdfColors.black, // Couleur du texte des en-têtes
                    ),
                    data: [
                      [
                        marchandise.numero_marchandise,
                        marchandise.nom,
                        marchandise.quantite,
                        marchandise.poids,
                        localisation.address_exp != null
                            ? "${localisation.address_exp} , ${city_depart.name}, ${pay_depart.name}"
                            : "${city_depart.name} , ${pay_depart.name}",
                        function.date(marchandise.date_chargement),
                        localisation.address_liv != null
                            ? "${localisation.address_liv} , ${city_livraison.name}, ${pay_livraison.name}"
                            : "${city_livraison.name} , ${pay_livraison.name}",
                        '---'
                      ]
                    ],
                    cellStyle: pw.TextStyle(
                      font: ttf, // Police pour le contenu
                      fontSize: 7, // Taille de police pour les cellules
                    ),
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                      5: pw.Alignment.center,
                      6: pw.Alignment.center,
                      7: pw.Alignment.center,
                    },
                  ),

                  destinataire.id != 0
                      ? pw.Column(children: [
                          pw.SizedBox(height: 10),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              color: PdfColors.orange,
                            ),
                            padding: const pw.EdgeInsets.all(5),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "DESTINATAIRE",
                              style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black),
                            ),
                          ),
                          pw.Table.fromTextArray(
                            border: pw.TableBorder.all(),
                            headers: [
                              'Nom',
                              'IFU',
                              'Adresse',
                              'Tél',
                              'Email',
                            ],
                            headerStyle: pw.TextStyle(
                              font: ttf, // Police
                              fontSize: 10, // Taille de police
                              fontWeight: pw.FontWeight.bold, // En gras
                              color: PdfColors
                                  .black, // Couleur du texte des en-têtes
                            ),
                            cellAlignments: {
                              0: pw.Alignment.center,
                              1: pw.Alignment.center,
                              2: pw.Alignment.center,
                              3: pw.Alignment.center,
                              4: pw.Alignment.center,
                            },
                            data: [
                              [
                                destinataire_entreprise.id != 0
                                    ? destinataire_entreprise.name
                                    : destinataire_user.name,
                                destinataire_entreprise.id != 0
                                    ? destinataire_entreprise.ifu ?? "---"
                                    : "----",
                                destinataire_user.adresse ?? "-----",
                                destinataire_user.telephone,
                                destinataire_user.email ?? "----",
                              ]
                            ],
                            cellStyle: pw.TextStyle(
                              font: ttf, // Police pour le contenu
                              fontSize: 8, // Taille de police pour les cellules
                            ),
                          ),
                        ])
                      : pw.Container(),

                  pw.SizedBox(height: 15),
                  pw.Container(
                    width: double
                        .infinity, // Pour prendre toute la largeur disponible
                    padding: const pw.EdgeInsets.all(7),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 1),
                    ),
                    child: pw.Text(
                      "REGLEMENT",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          fontSize: 8,
                          color: PdfColors.black),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Table.fromTextArray(
                    border: pw.TableBorder.all(),
                    headers: [
                      'Tarif',
                      'Quantité',
                      'Accompte',
                      'Solde',
                      'Paiement',
                    ],
                    headerStyle: pw.TextStyle(
                      font: ttf, // Police
                      fontSize: 10, // Taille de police
                      fontWeight: pw.FontWeight.bold, // En gras
                      color: PdfColors.black, // Couleur du texte des en-têtes
                    ),
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                    },
                    data: [
                      [
                        function.formatAmount(montant) + " XOF",
                        marchandise.quantite,
                        function.formatAmount(accompte) + " XOF",
                        function.formatAmount(solde) + " XOF",
                        type_paiement.nom
                      ]
                    ],
                    cellStyle: pw.TextStyle(
                      font: ttf, // Police pour le contenu
                      fontSize: 8, // Taille de police pour les cellules
                    ),
                  ),
                  pw.SizedBox(height: 15),
                  // Section de Règlement (Termes)
                  pw.Container(
                    width: double
                        .infinity, // Pour prendre toute la largeur disponible
                    padding: const pw.EdgeInsets.all(7),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 1),
                    ),
                    child: pw.Text(
                      "Informatiosn et dispositions complémentaires"
                          .toUpperCase(),
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          fontSize: 8,
                          color: PdfColors.black),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),

                  pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(7),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black, width: 1),
                      ),
                      child: pw.Column(children: [
                        pw.Text(
                          "La franchise est de 72 heures . Passé ce délai, STL BENIN sera facturé à 25. 000,00 XOF par jour et par camion pour les frais de stationnement de camion.",
                          maxLines: 10,
                          overflow: pw.TextOverflow.visible,
                          style: pw.TextStyle(font: ttf, fontSize: 7),
                          textAlign: pw.TextAlign.justify,
                        ),
                        pw.Text(
                          "L'annulation d'un chargement une fois que le camion se trouve sur le lieu de chargement expose STL BENIN  à un paiement de 25. 000,00 XOF par camion",
                          maxLines: 10,
                          overflow: pw.TextOverflow.visible,
                          style: pw.TextStyle(font: ttf, fontSize: 7),
                          textAlign: pw.TextAlign.justify,
                        ),
                      ])),

                  pw.SizedBox(height: 30),

                  pw.Column(
                    children: [
                      pw.Text("Lu et approuvé".toUpperCase(),
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black)),
                      pw.SizedBox(height: 30),
                      donneur_entreprise.id != 0
                          ? pw.Text(donneur_entreprise.name,
                              style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black))
                          : pw.Text(donneur_user.name,
                              style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  final current = DateFormat('yyyy-MM-dd').format(DateTime.now()) +
      "_" +
      DateFormat('HH-mm-ss').format(DateTime.now());
  String fileName = "ordre_transport_sécurisé_$current.pdf";
  final output = await getExternalStorageDirectory();
  final file = File("${output!.path}/$fileName");
  await file.writeAsBytes(await pdf.save());

  await OpenFile.open(file.path);
}
