// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/wrappers/loading.dart';
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

class ListTransporteur extends StatefulWidget {
  const ListTransporteur(
      {super.key, required this.data_id, required this.data_modele});
  final int data_id;
  final String data_modele;

  @override
  State<ListTransporteur> createState() => _ListTransporteurState();
}

class _ListTransporteurState extends State<ListTransporteur> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitChargementEffectue();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<ChargementEffectue> chargement_effectues =
        api_provider.chargement_effectues;
    chargement_effectues = function.data_chargemnt_effectues(
        chargement_effectues, widget.data_id, widget.data_modele);
    List<Camions> camions = api_provider.camions;
    List<Pieces> pieces = api_provider.pieces;
    List<Conducteur> conducteurs = api_provider.conducteurs;
    List<Position> positions = api_provider.positions;
    List<Tarif> tarifs = api_provider.tarifs;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    Users user = api_provider.user;
    bool loading = api_provider.loading;

    return loading
        ? Loading()
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: user.dark_mode == 1
                  ? MyColors.secondDark
                  : MyColors.textColor.withOpacity(.4),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          );
  }
}
