// ignore_for_file: use_super_parameters, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors/color.dart';
import '../providers/api/api_data.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:bodah/ui/users/expediteur/dashboard/index.dart';
import '../ui/users/transporteur/dashboard/index.dart';
import 'package:bodah/functions/function.dart';
import 'package:bodah/modals/rules.dart';

class Wrappers extends StatefulWidget {
  const Wrappers({Key? key}) : super(key: key);

  @override
  State<Wrappers> createState() => _WrappersState();
}

class _WrappersState extends State<Wrappers> {
  @override
  void initState() {
    super.initState();

    Provider.of<ApiProvider>(context, listen: false).InitData(context);
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    bool loading = apiProvider.loading;
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: MyColors.secondary,
          ),
        ),
      );
    }

    final user = apiProvider.user;

    if (user.id > 0) {
      List<Rules> rules = apiProvider.roles;
      bool is_transporteur = function.hasRole(rules, "Expéditeur");

      if (is_transporteur) {
        return TransporteurDashboard();
      }

      return ExpediteurDashBoard();
    }
    return SignIn();
  }
}
