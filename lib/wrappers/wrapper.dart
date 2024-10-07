// ignore_for_file: use_super_parameters, prefer_const_constructors, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:bodah/modals/rules.dart';
import 'package:bodah/providers/connection/index.dart';
import 'package:bodah/ui/account/accoun_unvalidated.dart';
import 'package:bodah/ui/account/account_deleted.dart';
import 'package:bodah/ui/account/account_disabled.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:bodah/ui/users/expediteur/dashboard/index.dart';
import 'package:bodah/wrappers/load.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors/color.dart';
import '../functions/function.dart';
import '../modals/users.dart';
import '../providers/api/api_data.dart';
import '../ui/account/account_no_rule.dart';
import '../ui/users/transporteur/dashboard/accueil.dart';

class Wrappers extends StatefulWidget {
  const Wrappers({Key? key}) : super(key: key);

  @override
  State<Wrappers> createState() => _WrappersState();
}

class _WrappersState extends State<Wrappers> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitData();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final function = Provider.of<Functions>(context);
    bool loading = apiProvider.loading;
    final connexionProvider = Provider.of<ProvConnexion>(context);
    bool isConnected = connexionProvider.isConnected;

    if (loading) {
      return LoadingPage();
    }

    if (!isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showNoConnectionState(
            context, connexionProvider); // Affiche le popup si déconnecté
      });
    }

    function.checkAndRequestLocationPermission(context);

    Users? user = apiProvider.user;
    Rules? rule = apiProvider.rule;

    if (user != null && rule != null) {
      if (user.is_active == 0) {
        return AccountDisabled();
      }

      if (user.deleted == 1) {
        return AccountDeleted();
      }

      if (user.is_verified == 0) {
        return AccountUnValidated();
      }

      if (rule.nom == "Expéditeur") {
        return ExpediteurDashboard();
      }

      if (rule.nom == "Transporteur") {
        return TransporteurDashboard();
      }

      return AccountNoRule();
    }
    return SignIn();
  }
}

void showNoConnectionState(BuildContext context, ProvConnexion provConnexion) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogcontext) {
      return AlertDialog(
        title: Text(
          'Connexion internet',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        content: Text(
          "Vous n'avez aucune connexion internet active",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyColors.textColor,
              fontFamily: "Poppins",
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80,
                height: 30,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 7, right: 7),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      Navigator.of(dialogcontext).pop();
                    },
                    child: Text(
                      "Fermez",
                      style: TextStyle(
                          color: MyColors.light,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          letterSpacing: 1),
                    )),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.only(left: 7, right: 7),
                      backgroundColor: Colors.green),
                  onPressed: () async {
                    Navigator.of(dialogcontext).pop();
                    // Rafraîchir la connexion
                    provConnexion
                        .checkInitialConnection(); // Vérifie la connexion à nouveau
                  },
                  child: Text(
                    "Réessayez",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.light,
                        fontFamily: "Poppins",
                        fontSize: 8,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
