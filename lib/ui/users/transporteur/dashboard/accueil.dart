// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_adjacent_string_concatenation

import 'package:bodah/colors/color.dart';
import 'package:bodah/ui/users/transporteur/dashboard/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../functions/function.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';

class TransporteurDashboard extends StatelessWidget {
  const TransporteurDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 60),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bienvenue " + user.name,
                  style: TextStyle(
                      color:
                          user.dark_mode == 1 ? MyColors.light : MyColors.black,
                      fontFamily: "Poppins",
                      fontSize:
                          MediaQuery.of(context).size.width > 520 ? 20 : 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "images/transp.png",
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.7,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child: Text(
                  "Planifiez paisiblement vos trajets et à l'avance avec Bodah",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          user.dark_mode == 1 ? MyColors.light : MyColors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return WelcomeTransporteur();
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
                    "Commencez",
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
