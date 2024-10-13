// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/camions.dart';
import '../../../../../../modals/chargement_effectues.dart';
import '../../../../../../modals/conducteur.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/pieces.dart';
import '../../../../../../modals/positions.dart';
import '../../../../../../modals/tarifs.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../../providers/users/expediteur/import/transp/add.dart';
import '../../route/add.dart';

class ListTransporteur extends StatelessWidget {
  const ListTransporteur(
      {super.key, required this.data_id, required this.data_modele});
  final int data_id;
  final String data_modele;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<ChargementEffectue> chargement_effectues =
        api_provider.chargement_effectues;
    chargement_effectues = function.data_chargemnt_effectues(
        chargement_effectues, data_id, data_modele);
    List<Camions> camions = api_provider.camions;
    List<Pieces> pieces = api_provider.pieces;
    List<Conducteur> conducteurs = api_provider.conducteurs;
    List<Positions> positions = api_provider.positions;
    List<Tarif> tarifs = api_provider.tarifs;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    Users? user = api_provider.user;
    final provider = Provider.of<ProvAddTransp>(context);

    Future<void> refresh() async {
      await api_provider.InitChargementEffectue();
    }

    return chargement_effectues.isEmpty
        ? RefreshIndicator(
            onRefresh: refresh,
            child: Center(
                child: Text(
              "Vous n'avez encore pas ajouté de transporteurs",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: user!.dark_mode == 1 ? MyColors.light : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            )),
          )
        : RefreshIndicator(
            color: MyColors.secondary,
            onRefresh: refresh,
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height), //
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    ChargementEffectue chargement_effectue =
                        chargement_effectues[index];
                    Positions position = function.chargement_effectue_position(
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
                      padding:
                          const EdgeInsets.only(bottom: 4, left: 8, right: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.2),
                            borderRadius: BorderRadius.circular(20),
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
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nom ",
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
                                        Text(
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Contact",
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
                                        Text(
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "N° Permis",
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
                                        Text(
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "N° Camion",
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
                                        Text(
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Row(
                                          children: [
                                            pay_depart.id == 0
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "https://test.bodah.bj/countries/${pay_depart.flag}",
                                                      fit: BoxFit.cover,
                                                      height: 10,
                                                      width: 17,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress,
                                                        color:
                                                            MyColors.secondary,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
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
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Destination",
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
                                        Row(
                                          children: [
                                            pay_dest.id == 0
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "https://test.bodah.bj/countries/${pay_dest.flag}",
                                                      fit: BoxFit.cover,
                                                      height: 10,
                                                      width: 17,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress,
                                                        color:
                                                            MyColors.secondary,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                            Expanded(
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
                                                    fontSize: 9),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tarif",
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
                                        Text(
                                          function.formatAmount(tarif.montant) +
                                              " XOF",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontSize: 9),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Acompte",
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
                                        Text(
                                          function.formatAmount(
                                                  tarif.accompte) +
                                              " XOF",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontSize: 9),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Solde",
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
                                        Text(
                                          function.formatAmount(tarif.montant -
                                                  tarif.accompte) +
                                              " XOF",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: user.dark_mode == 1
                                                  ? MyColors.light
                                                  : MyColors.textColor,
                                              fontFamily: "Poppins",
                                              fontSize: 9),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  child: Row(
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
                                            UpdateTransp(
                                                context, chargement_effectue);
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
                                            DeleteTransp(
                                                context,
                                                chargement_effectue,
                                                conducteur);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20,
                                            color: Colors.redAccent,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: chargement_effectues.length),
            ),
          );
  }
}
