// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, deprecated_member_use, use_build_context_synchronously

import 'package:bodah/ui/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors/color.dart';
import '../../functions/function.dart';
import '../../modals/users.dart';
import '../../providers/api/api_data.dart';
import '../../services/data_base_service.dart';

class AccountNoRule extends StatefulWidget {
  const AccountNoRule({Key? key});

  @override
  State<AccountNoRule> createState() => _AccountNoRuleState();
}

class _AccountNoRuleState extends State<AccountNoRule> {
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
    Users? user = apiProvider.user;
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
              "Compte non-opérationne l",
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
                    user!.name +
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
                            String phoneNumber = "+22940349975";
                            final url = 'https://wa.me/$phoneNumber';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
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
