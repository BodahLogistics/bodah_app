// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../modals/users.dart';

class AccountNoRule extends StatelessWidget {
  const AccountNoRule({Key? key});

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final user = Provider.of<Users>(context);

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
              "Compte non-opérationnel",
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
                "Bonjour " +
                    user.name +
                    " !" +
                    "\n Votre compte chez Senna Finance a été créé avec suucès certes, mais vous n'avez pas les droits recquis pour utiliser cette application",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: function.convertHexToColor("#79747E"),
                  fontFamily: "Poppins",
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: MyColors.secondary),
                  onPressed: () async {
                    String phoneNumber = "+22940349975";
                    final url = 'https://wa.me/$phoneNumber';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.8,
                            left: MediaQuery.of(context).size.width * 0.5,
                            right: 20),
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "Vous devez vous connecter à internet. Une erreur s'est produite",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    "Contactez l'administrateur",
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
