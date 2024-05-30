// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bodah/wrappers/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../colors/color.dart';
import '../../functions/function.dart';

class ConnexionNotFound extends StatelessWidget {
  const ConnexionNotFound({Key? key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi,
              color: Colors.red,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Connexion internet",
              style: TextStyle(
                fontSize: 25,
                color: function.convertHexToColor("#222523"),
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 14),
              child: Text(
                "Vous n'avez pas activé vos données mobiles. Activez et réessayez",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: function.convertHexToColor("#79747E"),
                  fontFamily: "Poppins",
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: MyColors.secondary),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return Wrappers();
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
                  },
                  child: Text(
                    "Réessayez",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
