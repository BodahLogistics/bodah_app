// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:bodah/modals/lta.dart';
import 'package:bodah/wrappers/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/appeles.dart';
import '../../../../../../modals/autre_docs.dart';
import '../../../../../../modals/avds.dart';
import '../../../../../../modals/bfus.dart';
import '../../../../../../modals/bl.dart';
import '../../../../../../modals/cargaison.dart';
import '../../../../../../modals/cargaison_client.dart';
import '../../../../../../modals/cartificat_origine.dart';
import '../../../../../../modals/certificat_phyto_sanitaire.dart';
import '../../../../../../modals/chargement.dart';
import '../../../../../../modals/client.dart';
import '../../../../../../modals/declaration.dart';
import '../../../../../../modals/fiche_technique.dart';
import '../../../../../../modals/interchanges.dart';
import '../../../../../../modals/pays.dart';
import '../../../../../../modals/positions.dart';
import '../../../../../../modals/recus.dart';
import '../../../../../../modals/tdos.dart';
import '../../../../../../modals/users.dart';
import '../../../../../../modals/vgms.dart';
import '../../../../../../modals/villes.dart';
import '../../../../../../providers/api/api_data.dart';

class ListCargaison extends StatefulWidget {
  const ListCargaison(
      {super.key, required this.data_id, required this.data_modele});
  final int data_id;
  final String data_modele;

  @override
  State<ListCargaison> createState() => _ListCargaisonState();
}

class _ListCargaisonState extends State<ListCargaison> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitCargaison();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    List<Cargaison> cargaisons = api_provider.cargaisons;
    cargaisons = function.data_cargaisons(
        cargaisons, widget.data_id, widget.data_modele);
    List<Client> clients = api_provider.clients;
    List<CargaisonClient> cargaison_client = api_provider.cargaison_clients;
    List<Chargement> chargements = api_provider.chargements;
    List<Position> positions = api_provider.positions;
    List<Pays> pays = api_provider.pays;
    List<Villes> all_villes = api_provider.all_villes;
    List<Appeles> appeles = api_provider.appeles;
    List<Interchanges> interchanges = api_provider.interchanges;
    List<Tdos> tdos = api_provider.tdos;
    List<Vgms> vgms = api_provider.vgms;
    List<Recus> recus = api_provider.recus;
    List<AutreDocs> autre_docs = api_provider.autre_docs;
    List<Avd> avds = api_provider.avds;
    List<Bl> bls = api_provider.bls;
    List<Lta> ltas = api_provider.ltas;
    List<Bfu> bfus = api_provider.bfus;
    List<CO> cos = api_provider.cos;
    List<CPS> cps = api_provider.cps;
    List<Declaration> declarations = api_provider.declarations;
    List<FicheTechnique> fiche_techniques = api_provider.fiche_techniques;
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
