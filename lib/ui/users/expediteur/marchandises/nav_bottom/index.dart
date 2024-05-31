// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../colors/color.dart';
import '../../../../../functions/function.dart';
import '../../../../../providers/users/expediteur/marchandises/nav_bottom/index.dart';

class NavigBot extends StatelessWidget {
  const NavigBot({super.key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final provider = Provider.of<ProvNavMarchBottomExp>(context);
    int current_index = provider.current_index;

    return BottomNavigationBar(
        backgroundColor: MyColors.navColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: current_index,
        selectedItemColor: MyColors.secondary,
        unselectedItemColor: function.convertHexToColor("#263238"),
        elevation: 0,
        onTap: (value) => provider.change_index(value),
        items: [
          BottomNavigationBarItem(
              tooltip: "Page d'accueil",
              icon: Icon(Icons.dashboard),
              label: "Accueil"),
          BottomNavigationBarItem(
              tooltip: "Page de statistiques",
              icon: Icon(Icons.insert_chart),
              label: "Statistiques"),
          BottomNavigationBarItem(
              tooltip: "Page des annexes",
              icon: Icon(Icons.compare_arrows),
              label: "Annexes"),
          BottomNavigationBarItem(
              tooltip: "Paramètres",
              icon: Icon(Icons.person),
              label: "Paramètres"),
        ]);
  }
}
