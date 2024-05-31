// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import '../../../../../colors/color.dart';

class ListExpExp extends StatelessWidget {
  const ListExpExp({super.key});

  @override
  Widget build(BuildContext context) {
    /*final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    final user = api_provider.user;*/

    return Center(
      child: CircularProgressIndicator(
        color: MyColors.secondary,
      ),
    );
  }
}
