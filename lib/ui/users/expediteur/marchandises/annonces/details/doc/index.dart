// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/ordres/detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../colors/color.dart';
import '../../../../../../../functions/function.dart';
import '../../../../../../../modals/appeles.dart';
import '../../../../../../../modals/autre_docs.dart';
import '../../../../../../../modals/avds.dart';
import '../../../../../../../modals/bfus.dart';
import '../../../../../../../modals/bl.dart';
import '../../../../../../../modals/bon_commandes.dart';
import '../../../../../../../modals/cartificat_origine.dart';
import '../../../../../../../modals/certificat_phyto_sanitaire.dart';
import '../../../../../../../modals/declaration.dart';
import '../../../../../../../modals/expeditions.dart';
import '../../../../../../../modals/fiche_technique.dart';
import '../../../../../../../modals/interchanges.dart';
import '../../../../../../../modals/lta.dart';
import '../../../../../../../modals/recus.dart';
import '../../../../../../../modals/tdos.dart';
import '../../../../../../../modals/users.dart';
import '../../../../../../../modals/vgms.dart';
import '../../../../../../../providers/api/api_data.dart';
import '../../../../../transporteur/annonces/details/docs/index.dart';
import '../../../../import/details/docs/index.dart';

class ListDocAnnonce extends StatelessWidget {
  const ListDocAnnonce({super.key, required this.annonce});
  final Annonces annonce;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Expeditions> expeditions = api_provider.expeditions;
    expeditions = function.annonce_expeditions(expeditions, annonce);
    List<Appeles> appeles = api_provider.appeles;
    appeles = function.expedition_appeles(appeles, expeditions);
    List<Interchanges> interchanges = api_provider.interchanges;
    interchanges = function.expedition_interchanges(interchanges, expeditions);
    List<Tdos> tdos = api_provider.tdos;
    tdos = function.expedition_tdo(tdos, expeditions);
    List<Vgms> vgms = api_provider.vgms;
    vgms = function.expedition_vgm(vgms, expeditions);
    List<Recus> recus = api_provider.recus;
    recus = function.annonce_recus(annonce, expeditions, recus);
    List<AutreDocs> autre_docs = api_provider.autre_docs;
    autre_docs = function.data_autre_docs(autre_docs, annonce.id, "Annonce");
    List<Avd> avds = api_provider.avds;
    avds = function.data_avds(avds, annonce.id, "Annonce");
    List<Bl> bls = api_provider.bls;
    bls = function.data_bl(bls, annonce.id, "Annonce");
    List<Lta> ltas = api_provider.ltas;
    ltas = function.data_lta(ltas, annonce.id, "Annonce");
    List<Bfu> bfus = api_provider.bfus;
    bfus = function.data_bfus(bfus, annonce.id, "Annonce");
    List<CO> cos = api_provider.cos;
    cos = function.data_cos(cos, annonce.id, "Annonce");
    List<CPS> cps = api_provider.cps;
    cps = function.data_cps(cps, annonce.id, "Annonce");
    List<Declaration> declarations = api_provider.declarations;
    declarations =
        function.data_declarations(declarations, annonce.id, "Annonce");
    List<FicheTechnique> fiche_techniques = api_provider.fiche_techniques;
    fiche_techniques =
        function.data_fiches(fiche_techniques, annonce.id, "Annonce");
    List<BonCommandes> ordres = api_provider.ordres;
    BonCommandes ordre = function.annonce_bon_commande(ordres, annonce);
    List<BordereauLivraisons> bordereaux = api_provider.bordereaux;
    bordereaux = function.expedition_bordereaux(bordereaux, expeditions);

    Future<void> refresh() async {
      await api_provider.InitDocuments();
    }

    return RefreshIndicator(
      color: MyColors.secondary,
      onRefresh: refresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (interchanges.isNotEmpty) {
                          showInterchanges(
                              context, annonce.id, "Expedition", interchanges);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            interchanges.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune intercganges",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : interchanges.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          interchanges.length.toString() +
                                              " interchanges",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          interchanges.length.toString() +
                                              " interchanges",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (recus.isNotEmpty) {
                          showRecus(context, annonce.id, "Annonce", recus);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            recus.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun reçu",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : recus.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (recus.length).toString() + " reçus",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (recus.length).toString() + " reçus",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (fiche_techniques.isNotEmpty) {
                          showFiches(context, annonce.id, "Annonce");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            fiche_techniques.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune fiche technique",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : fiche_techniques.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          fiche_techniques.length.toString() +
                                              " fiche technique",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          fiche_techniques.length.toString() +
                                              " fiches techniques",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            tdos.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun TDO",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      (tdos.length).toString() + " TDO",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            bfus.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun BFU",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      bfus.length.toString() + " BFU",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            cos.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun certificat d'origine",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : cos.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (cos.length).toString() +
                                              " certificat d'origine",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (cos.length).toString() +
                                              " certificats d'origine",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            vgms.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune VGM",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      vgms.length.toString() + " VGM",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            bls.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun BL",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      (bls.length).toString() + " BL",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            avds.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune AVD",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      avds.length.toString() + " AVD",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            cps.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun certificat phyto-sanitaire",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : cps.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (cps.length).toString() +
                                              " certificat phyto-sanitaire",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (cps.length).toString() +
                                              " certificats phyto-sanitaires",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            appeles.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune appélé",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : appeles.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          appeles.length.toString() + " appélé",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          appeles.length.toString() +
                                              " appélés",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            declarations.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucune déclaration",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : declarations.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (declarations.length).toString() +
                                              " déclaration",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (declarations.length).toString() +
                                              " déclarations",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            autre_docs.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun autre document",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : autre_docs.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          autre_docs.length.toString() +
                                              " autre document",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          autre_docs.length.toString() +
                                              " autres documents",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ordres.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun ordre de transport",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      (ordres.length).toString() +
                                          " ordre de transport",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: TextButton(
                      onPressed: () {
                        if (bordereaux.isNotEmpty) {
                          showBordereaux(context, bordereaux);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(.70)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondary,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.receipt,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            bordereaux.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aucun bordereau de livraison",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: MyColors.textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  )
                                : bordereaux.length < 2
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (bordereaux.length).toString() +
                                              " bordereau de livraison",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (bordereaux.length).toString() +
                                              " bordereaux de livraisons",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(.70)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.secondary,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.receipt,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              " Autres",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: MyColors.textColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (ltas.isNotEmpty) {
                          showLta(context, annonce.id, "Annonce");
                        }
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "LTA",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: ltas.isNotEmpty
                                      ? Colors.green
                                      : user!.dark_mode == 1
                                          ? MyColors.light
                                          : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ltas.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (tdos.isNotEmpty) {
                          showTdo(context, annonce.id, "Annonce", tdos);
                        }
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "TDO",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: tdos.isNotEmpty
                                      ? Colors.green
                                      : user!.dark_mode == 1
                                          ? MyColors.light
                                          : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          tdos.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (ordre.id > 0) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return DetailOrdre(
                                  id: ordre.id,
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
                        }
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Ordre de transport",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: ordre.id > 0
                                      ? Colors.green
                                      : user!.dark_mode == 1
                                          ? MyColors.light
                                          : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ordre.id == 0
                              ? Icon(
                                  Icons.add,
                                  size: 20,
                                  color: user!.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.black,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (bfus.isNotEmpty) {
                          showBfu(context, annonce.id, "Annonce");
                        }
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "BFU",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: bfus.isNotEmpty
                                      ? Colors.green
                                      : user!.dark_mode == 1
                                          ? MyColors.light
                                          : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          bfus.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (cos.isNotEmpty) {
                          showCo(context, annonce.id, "Annonce");
                        }
                      },
                      child: Row(
                        children: [
                          cos.length < 2
                              ? Flexible(
                                  child: Text(
                                    "Certificat d'origine",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: cos.isNotEmpty
                                            ? Colors.green
                                            : user!.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : Flexible(
                                  child: Text(
                                    "Certificat d'origines",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.green,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                          cos.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (vgms.isNotEmpty) {
                          showVgm(context, annonce.id, "Annonce", vgms);
                        }
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "VGM",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: vgms.isNotEmpty
                                      ? Colors.green
                                      : user!.dark_mode == 1
                                          ? MyColors.light
                                          : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          vgms.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (bls.isNotEmpty) {
                          showBl(context, annonce.id, "Annonce");
                        }
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "BL",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: bls.isNotEmpty
                                      ? Colors.green
                                      : user!.dark_mode == 1
                                          ? MyColors.light
                                          : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          bls.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (avds.isNotEmpty) {
                          showAvd(context, annonce.id, "Annonce");
                        }
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "AVD",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: avds.isNotEmpty
                                      ? Colors.green
                                      : user!.dark_mode == 1
                                          ? MyColors.light
                                          : MyColors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          avds.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (cps.isNotEmpty) {
                          showCps(context, annonce.id, "Annonce");
                        }
                      },
                      child: Row(
                        children: [
                          cps.length < 2
                              ? Flexible(
                                  child: Text(
                                    "Certificat Phyto-sanitaire",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: cps.isNotEmpty
                                            ? Colors.green
                                            : user!.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : Flexible(
                                  child: Text(
                                    "Certificat phyto-sanitaires",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.green,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                          cps.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (appeles.isNotEmpty) {
                          showApeles(context, annonce.id, "Annonce", appeles);
                        }
                      },
                      child: Row(
                        children: [
                          appeles.length < 2
                              ? Flexible(
                                  child: Text(
                                    "Appélé",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: appeles.isNotEmpty
                                            ? Colors.green
                                            : user!.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : Flexible(
                                  child: Text(
                                    "Appélés",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.green,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                          appeles.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        if (declarations.isNotEmpty) {
                          showDecla(context, annonce.id, "Annonce");
                        }
                      },
                      child: Row(
                        children: [
                          declarations.length < 2
                              ? Flexible(
                                  child: Text(
                                    "Déclaration",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: declarations.isNotEmpty
                                            ? Colors.green
                                            : user!.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : Flexible(
                                  child: Text(
                                    "Déclarations",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.green,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                          declarations.isEmpty
                              ? Container()
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.green,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (autre_docs.isNotEmpty) {
                            showAutreDoc(context, annonce.id, "Annonce");
                          }
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Autre document",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: ltas.isNotEmpty
                                        ? Colors.green
                                        : user!.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            autre_docs.isEmpty
                                ? Container()
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
