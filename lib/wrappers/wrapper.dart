// ignore_for_file: use_super_parameters, prefer_const_constructors, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:bodah/modals/rules.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:bodah/ui/users/expediteur/dashboard/index.dart';
import 'package:bodah/wrappers/load.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/users.dart';
import '../providers/api/api_data.dart';
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
    bool loading = apiProvider.loading;

    if (loading) {
      return LoadingPage();
    }

    Users? user = apiProvider.user;
    Rules? rule = apiProvider.rule;

    if (user != null && rule != null) {
      if (rule.nom == "Expéditeur") {
        return ExpediteurDashBoard();
      }

      return TransporteurDashboard();
    }
    return SignIn();
  }
}
