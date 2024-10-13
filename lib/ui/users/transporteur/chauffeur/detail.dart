// ignore_for_file: prefer_const_constructors

import 'package:bodah/modals/camions.dart';
import 'package:bodah/modals/transport_liaison.dart';
import 'package:bodah/providers/users/transporteur/chauffeurs/add.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../functions/function.dart';
import '../../../../modals/pays.dart';
import '../../../../modals/pieces.dart';
import '../../../../modals/transporteurs.dart';
import '../../../../modals/users.dart';
import '../../../../modals/villes.dart';
import '../../../../providers/api/api_data.dart';
import '../drawer/index.dart';
import 'edit.dart';

class DetailsChauffeur extends StatelessWidget {
  const DetailsChauffeur({super.key, required this.chauffeur});
  final TransportLiaisons chauffeur;

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final provider = Provider.of<ProvAddChauffeur>(context);
    final function = Provider.of<Functions>(context);
    Users? user = apiProvider.user;
    List<Transporteurs> transporteurs = apiProvider.transporteurs;
    List<Users> users = apiProvider.users;
    List<Pays> pays = apiProvider.pays;
    List<Villes> villes = apiProvider.all_villes;
    List<Pieces> pieces = apiProvider.pieces;
    Transporteurs transporteur =
        function.transporteur(transporteurs, chauffeur.transporteur_id);
    Users chauffeurUser = function.user(users, transporteur.user_id);
    Pays pay = function.pay(pays, chauffeurUser.country_id);
    Villes ville = function.ville(villes, chauffeurUser.city_id ?? 0);
    Pieces piece = function.data_piece(pieces, transporteur.id, "Transporteur");
    List<Camions> camions = apiProvider.camions;
    camions = function.transporteur_camions(camions, transporteur);

    Future<void> refresh() async {
      await apiProvider.InitChauffeurs();
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
      body: RefreshIndicator(
        color: MyColors.secondary,
        onRefresh: refresh,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: [
              transporteur.photo_url != null
                  ? Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 250,
                        height: 250,
                        child: CircleAvatar(
                          radius: 40, // Ajuster la taille du cercle
                          backgroundImage: CachedNetworkImageProvider(
                            "https://test.bodah.bj/storage/${transporteur.photo_url}",
                          ),
                          backgroundColor: Colors.grey[
                              200], // Optionnel, couleur de fond si l'image n'est pas encore chargée
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "images/avatar.png",
                        height: 250,
                        width: 250,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              "Nom",
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              chauffeurUser.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              "Pays",
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
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Row(
                                children: [
                                  pay.id == 0
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://test.bodah.bj/countries/${pay.flag}",
                                            fit: BoxFit.cover,
                                            height: 13,
                                            width: 20,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              color: MyColors.secondary,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(),
                                          ),
                                        ),
                                  Expanded(
                                    child: Text(
                                      pay.name,
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
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              "Ville",
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
                          ),
                          ville.name.isEmpty
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    "-----",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontSize: 10),
                                  ),
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    ville.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: user.dark_mode == 1
                                            ? MyColors.light
                                            : MyColors.textColor,
                                        fontFamily: "Poppins",
                                        fontSize: 10),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              "Adresse",
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              chauffeurUser.adresse ?? "-----",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              "Téléphone",
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              chauffeurUser.telephone,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              "Email",
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              chauffeurUser.email ?? "----",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              "N° Tracteur",
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
                          ),
                          camions.isEmpty
                              ? Container()
                              : camions.first.num_immatriculation.contains("/")
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        camions.first.num_immatriculation
                                            .split("/")
                                            .first,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10),
                                      ),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        camions.first.num_immatriculation,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10),
                                      ),
                                    ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              "N° Rémorque",
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
                          ),
                          camions.isEmpty
                              ? Container()
                              : camions.first.num_immatriculation.contains("/")
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        camions.first.num_immatriculation
                                            .split("/")
                                            .last,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10),
                                      ),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        camions.first.num_immatriculation,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: user.dark_mode == 1
                                                ? MyColors.light
                                                : MyColors.textColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10),
                                      ),
                                    ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.34,
                            child: Text(
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              piece.num_piece,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.34,
                            child: Text(
                              "Carte transporteur",
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              "-----",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: user.dark_mode == 1
                                      ? MyColors.light
                                      : MyColors.textColor,
                                  fontFamily: "Poppins",
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 100,
                        height: 35,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              provider.change_chauffeur(
                                  chauffeurUser, piece, pay, ville);
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return UpdateChauffeur(
                                      transporteur: transporteur,
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
                            child: Text(
                              "Modifiez",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MyColors.light,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
