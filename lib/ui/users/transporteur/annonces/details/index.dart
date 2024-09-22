// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:bodah/providers/users/transporteur/annonces/home.dart';
import 'package:bodah/ui/users/transporteur/annonces/details/docs/index.dart';
import 'package:bodah/ui/users/transporteur/annonces/details/expedition.dart';
import 'package:bodah/ui/users/transporteur/annonces/details/march.dart';
import 'package:bodah/ui/users/transporteur/drawer/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/color.dart';
import '../../../../../../functions/function.dart';
import '../../../../../../modals/annonces.dart';
import '../../../../../../providers/api/api_data.dart';
import '../../../../../modals/users.dart';

class DetailsMarchandises extends StatelessWidget {
  const DetailsMarchandises({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Annonces> annonces = api_provider.annonces;
    Annonces annonce = function.annonce(annonces, id);

    final provider = Provider.of<ProvHoTransp>(context);
    int current_index = provider.current_index;
    PageController pageController = PageController(initialPage: current_index);

    final pages = [
      MarchTransp(annonce: annonce),
      MesChargements(annonce: annonce),
      DocsChargement(annonce: annonce),
    ];

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
          "Annonce d'expédition",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(right: 7, left: 7, top: 2, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        border: current_index == 0
                            ? Border.all(
                                color: MyColors.secondary,
                                width: 1,
                                style: BorderStyle.solid)
                            : null,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            provider.change_index(0);
                          },
                          child: Text(
                            "Marchandise",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: current_index == 0
                                    ? MyColors.secondary
                                    : user.dark_mode == 1
                                        ? MyColors.light
                                        : function.convertHexToColor("#222523"),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        border: current_index == 1
                            ? Border.all(
                                color: MyColors.secondary,
                                width: 1,
                                style: BorderStyle.solid)
                            : null,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            provider.change_index(1);
                          },
                          child: Text(
                            "Chargement",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: current_index == 1
                                    ? MyColors.secondary
                                    : user.dark_mode == 1
                                        ? MyColors.light
                                        : function.convertHexToColor("#222523"),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        border: current_index == 2
                            ? Border.all(
                                color: MyColors.secondary,
                                width: 1,
                                style: BorderStyle.solid)
                            : null,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            provider.change_index(2);
                          },
                          child: Text(
                            "Documents",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: current_index == 2
                                    ? MyColors.secondary
                                    : user.dark_mode == 1
                                        ? MyColors.light
                                        : function.convertHexToColor("#222523"),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return pages[current_index];
                },
                controller: pageController,
                onPageChanged: (value) => provider.change_index(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
