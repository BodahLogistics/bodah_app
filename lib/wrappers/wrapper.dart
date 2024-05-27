// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors/color.dart';
import '../providers/api/api_data.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:bodah/ui/users/expediteur/dashboard/index.dart';

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
      Provider.of<ApiProvider>(context, listen: false).InitData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final user = apiProvider.user;
    final bool loading = apiProvider.loading;

    if (loading) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          color: MyColors.secondary,
        )),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user.id > 0) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ExpediteurDashBoard()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
          (route) => false,
        );
      }
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: MyColors.secondary,
        ),
      ),
    );
  }
}
