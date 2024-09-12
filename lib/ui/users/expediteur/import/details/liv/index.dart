// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/wrappers/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/cargaison.dart';
import '../../../../../../modals/client.dart';
import '../../../../../../modals/livraison_cargaison.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../../providers/users/expediteur/import/liv/add.dart';
import '../../route/add.dart';

class ListLivraisons extends StatefulWidget {
  const ListLivraisons(
      {super.key, required this.data_id, required this.data_modele});
  final int data_id;
  final String data_modele;

  @override
  State<ListLivraisons> createState() => _ListLivraisonsState();
}

class _ListLivraisonsState extends State<ListLivraisons> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitLivraison();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<LivraisonCargaison> livraisons = api_provider.livraisons;
    livraisons = function.data_livraisons(
        livraisons, widget.data_id, widget.data_modele);
    List<Cargaison> cargaisons = api_provider.cargaisons;
    List<Client> clients = api_provider.clients;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    Users user = api_provider.user;
    bool loading = api_provider.loading;
    final provider = Provider.of<ProvAddLiv>(context);

    return loading
        ? Loading()
        : livraisons.isEmpty
            ? Center(
                child: Text(
                "Vous n'avez encore pas ajouté de livraisons",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: user.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ))
            : Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height), //
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      LivraisonCargaison livraison = livraisons[index];
                      Cargaison cargaison = function.cargaison(
                          cargaisons, livraison.cargaison_id);
                      Client client =
                          function.client(clients, livraison.client_id);
                      Pays pay = function.pay(pays, livraison.country_id);
                      Villes ville =
                          function.ville(all_villes, livraison.city_id);

                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: 4, left: 7, right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(20),
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
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Destinataire",
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
                                            client.nom,
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
                                            "Contact ",
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
                                            client.telephone,
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
                                            "Ville , pays",
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
                                              pay.id == 0
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://test.bodah.bj/countries/${pay.flag}",
                                                        fit: BoxFit.cover,
                                                        height: 10,
                                                        width: 17,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress,
                                                          color: MyColors
                                                              .secondary,
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
                                                  ville.name + " , " + pay.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                            "Adresse ",
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
                                            livraison.address,
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
                                            "Quantité",
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
                                            livraison.quantite.toString(),
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
                                            "Marchandise",
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
                                            cargaison.nom,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: user.dark_mode == 1
                                                    ? MyColors.light
                                                    : MyColors.textColor,
                                                fontFamily: "Poppins",
                                                fontSize: 9),
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
                                            "Superviseur",
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
                                            livraison.superviseur ??
                                                "Non défini",
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
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
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
                                              provider.change_livraison(
                                                  livraison,
                                                  cargaison,
                                                  client,
                                                  pay,
                                                  ville);
                                              UpdateLiv(
                                                  context,
                                                  livraison,
                                                  widget.data_id,
                                                  widget.data_modele);
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
                                              DeleteLiv(context, livraison,
                                                  client, cargaison);
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
                    itemCount: livraisons.length),
              );
  }
}
