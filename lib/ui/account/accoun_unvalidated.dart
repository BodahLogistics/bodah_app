// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bodah/ui/account/validate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../providers/api/api_data.dart';
import '../../services/data_base_service.dart';
import '../auth/sign_in.dart';

class AccountUnValidated extends StatefulWidget {
  const AccountUnValidated({Key? key});

  @override
  State<AccountUnValidated> createState() => _AccountUnValidatedState();
}

class _AccountUnValidatedState extends State<AccountUnValidated> {
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
              Icons.warning_amber_outlined,
              color: Colors.red,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Compte non validé",
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
                "Veuillez cliquer sur le boutton ci-dessous afin de reçevoir le code de validation",
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
                          String statut =
                              await service.ResendCodeForValidationAccount();
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

                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return ForceValidateAccount();
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
                            );
                          }
                        },
                  child: Text(
                    "Procédez à la validation",
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
