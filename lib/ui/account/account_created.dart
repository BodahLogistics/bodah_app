// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:async';

import 'package:bodah/wrappers/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../functions/function.dart';

class AccountCreated extends StatelessWidget {
  const AccountCreated({Key? key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration:
              Duration(milliseconds: 500), // Durée de l'animation
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Wrappers();
          },
        ),
      );
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/icon-park-solid_success.png",
            height: 90,
            width: 90,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Compte créé avec succès",
            style: TextStyle(
              fontSize: 25,
              color: function.convertHexToColor("#222523"),
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Text(
              "Vous serez redirigé vers l’interface d’accueil dans quelques secondes",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: function.convertHexToColor("#79747E"),
                fontFamily: "Poppins",
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
