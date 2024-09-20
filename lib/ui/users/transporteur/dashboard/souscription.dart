// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:bodah/modals/localisations.dart';
import 'package:bodah/modals/marchandises.dart';
import 'package:bodah/modals/souscriptions.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/wrappers/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/annonces.dart';
import '../../../../../modals/pays.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';

class MesSouscription extends StatefulWidget {
  const MesSouscription({super.key});

  @override
  State<MesSouscription> createState() => _MesSouscriptionState();
}

class _MesSouscriptionState extends State<MesSouscription> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitSouscriptions();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    bool loading = api_provider.loading;
    List<Souscriptions> souscriptions = api_provider.souscriptions;
    List<Marchandises> marchandises = api_provider.marchandises;
    List<Localisations> localisations = api_provider.localisations;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<Annonces> annonces = api_provider.annonces;

    return loading
        ? Loading()
        : souscriptions.isEmpty
            ? Center(
                child: Text(
                "Auncune souscription disponible",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: user!.dark_mode == 1 ? MyColors.light : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ))
            : Column(
                children: [],
              );
  }
}
