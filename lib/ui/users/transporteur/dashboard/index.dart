// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers

import 'package:bodah/modals/camions.dart';
import 'package:bodah/modals/transporteurs.dart';
import 'package:bodah/providers/users/transporteur/dashboard/prov_change.dart';
import 'package:bodah/ui/users/transporteur/dashboard/document.dart';
import 'package:bodah/ui/users/transporteur/dashboard/home.dart';
import 'package:bodah/ui/users/transporteur/dashboard/souscription.dart';
import 'package:bodah/ui/users/transporteur/dashboard/trajet.dart';
import 'package:bodah/ui/users/transporteur/drawer/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../modals/users.dart';
import '../../../../../providers/api/api_data.dart';
import '../trajets/add.dart';

class WelcomeTransporteur extends StatelessWidget {
  WelcomeTransporteur({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvDashTransp>(context);
    int current_index = provider.current_index;
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Transporteurs> transporteurs = api_provider.transporteurs;
    List<Camions> camions = api_provider.camions;
    Transporteurs transporteur =
        function.user_transporteur(user, transporteurs);
    camions = function.transporteur_camions(camions, transporteur);
    bool loading = api_provider.loading;
    PageController _pageController =
        PageController(viewportFraction: 0.25, initialPage: 0);
    final pages = [
      HomeTransporteur(),
      MesTrajets(),
      MesSouscription(),
      MesTrajets(),
      TranspDocument()
    ];

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      floatingActionButton: current_index != 1
          ? null
          : FloatingActionButton(
              backgroundColor: loading ? MyColors.primary : MyColors.secondary,
              onPressed: () {
                if (camions.isNotEmpty) {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return AddTrajet();
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
                } else {
                  AddCamion(context);
                }
              },
              child: Icon(Icons.add, color: MyColors.light),
            ),
      drawer: DrawerTransporteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Accueil",
          style: TextStyle(
              fontFamily: "Poppins",
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.w400,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 40, left: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 65,
                  child: ListView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      double screen = MediaQuery.of(context).size.height;
                      int data = screen.toInt();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            provider.change_index(index);
                            _pageController.animateToPage(
                              current_index * data,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: current_index == index
                                  ? Border.all(
                                      color: MyColors.secondary,
                                      width: 1,
                                      style: BorderStyle.solid)
                                  : null,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              index == 0
                                  ? "Dashboard"
                                  : index == 1
                                      ? "Trajets"
                                      : index == 2
                                          ? "Souscriptions"
                                          : index == 3
                                              ? "Transport"
                                              : "Documents",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 10,
                                  color: current_index == index
                                      ? MyColors.secondary
                                      : user.dark_mode == 1
                                          ? MyColors.light
                                          : function
                                              .convertHexToColor("#222523"),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[current_index];
              },
              controller: PageController(initialPage: 0),
              onPageChanged: (value) => provider.change_index(value),
            ),
          )
        ],
      ),
    );
  }
}
