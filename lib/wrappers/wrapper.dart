// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:bodah/ui/auth/sign_in.dart';
import 'package:bodah/ui/users/expediteur/fashbord/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors/color.dart';
import '../providers/api/api_data.dart';

class Wrappers extends StatefulWidget {
  const Wrappers({super.key});

  @override
  State<Wrappers> createState() => _WrappersState();
}

class _WrappersState extends State<Wrappers> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false).getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;
    final bool loading = api_provider.loading;

    if (loading) {
      return Center(
        child: CircularProgressIndicator(
          color: MyColors.secondary,
        ),
      );
    } else {
      if (user.id == 0) {
        return SignIn();
      }

      return ExpediteurDashBoard();
    }
  }
}
