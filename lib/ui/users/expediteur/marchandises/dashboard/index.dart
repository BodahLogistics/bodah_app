// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers

import 'package:bodah/providers/users/expediteur/marchandises/prov_dash_march.dart';
import 'package:bodah/ui/users/expediteur/drawer/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/annonces/add.dart';
import 'package:bodah/ui/users/expediteur/marchandises/dashboard.dart';
import 'package:bodah/ui/users/expediteur/marchandises/documents/index.dart';
import 'package:bodah/ui/users/expediteur/marchandises/expeditions/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../providers/api/api_data.dart';
import '../nav_bottom/index.dart';

class DashMarchExp extends StatelessWidget {
  DashMarchExp({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProvChangeDashMarch>(context);
    int current_index = provider.current_index;
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;

    PageController _pageController =
        PageController(viewportFraction: 0.25, initialPage: 0);
    final pages = [
      HomeMarchExp(),
      PublishAnnonceExp(),
      ListExpExp(),
      DashBoardDocExp(),
    ];

    return Scaffold(
      backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
      bottomNavigationBar: NavigBot(),
      drawer: DrawerExpediteur(),
      appBar: AppBar(
        backgroundColor: user.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Annonces",
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
                  height: 75,
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
                              color: current_index == index
                                  ? MyColors.secondary
                                  : null,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              index == 0
                                  ? "Dashboard"
                                  : index == 1
                                      ? "Publiez annonce"
                                      : index == 2
                                          ? "Expéditions"
                                          : "Documents",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: current_index == index
                                      ? MyColors.light
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
          SizedBox(
            height: 10,
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
