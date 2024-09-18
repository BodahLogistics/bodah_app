// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_adjacent_string_concatenation

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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Accueil",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width > 520 ? 15 : 5,
              right: MediaQuery.of(context).size.width > 520 ? 15 : 5,
              top: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bienvenue " + user!.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize:
                          MediaQuery.of(context).size.width > 520 ? 20 : 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Faites ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: function.convertHexToColor("#8A8A8A"),
                      fontFamily: "Poppins",
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
