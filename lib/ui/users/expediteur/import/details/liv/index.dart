// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/wrappers/loading.dart';
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
