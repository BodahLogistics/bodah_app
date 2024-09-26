// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/api/api_data.dart';
import '../../services/data_base_service.dart';
import '../auth/sign_in.dart';

class AccountDeleted extends StatefulWidget {
  const AccountDeleted({Key? key});

  @override
  State<AccountDeleted> createState() => _AccountDeletedState();
}

class _AccountDeletedState extends State<AccountDeleted> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ApiProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.change_delete(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    final service = Provider.of<DBServices>(context);
    bool delete = apiProvider.delete;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Compte supprimé",
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
                "Votre compte a été supprimé. Cliquez sur le boutton ci-dessous pour créer un nouveau compte",
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
                  onPressed: delete
                      ? null
                      : () async {
                          apiProvider.change_delete(true);
                          String statut = await service.logout();
                          if (statut == "202") {
                            showCustomSnackBar(context,
                                "Une erreur s'est produite", Colors.redAccent);
                            apiProvider.change_delete(false);
                          } else if (statut == "500") {
                            showCustomSnackBar(
                                context,
                                "Vérifiez votre connection  internet",
                                Colors.redAccent);
                          } else {
                            apiProvider.change_delete(false);
                            Navigator.of(context).pop();

                            Navigator.of(context).pushAndRemoveUntil(
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return SignIn();
                                },
                                transitionsBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                    Widget child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                              ModalRoute.withName("/register"),
                            );
                          }
                        },
                  child: Text(
                    "Créez un compte",
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
