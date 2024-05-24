// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../apis/bodah/infos.dart';
import '../modals/pays.dart';
import '../modals/users.dart';
import 'package:http/http.dart' as http;

class DBServices {
  var api_url = ApiInfos.baseUrl;
  var api_key = ApiInfos.api_key;
  var auth_token = ApiInfos.aauth_token;

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Users> get user async {
    var token = await getToken();
    var url = Uri.https(api_url, 'user');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'API_Key': api_key,
      'AUTH_Token': auth_token
    });

    if (response.statusCode == 200) {
      return Users.fromJson(jsonDecode(response.body));
    }

    return Users(
        id: 0,
        name: "",
        country_id: 0,
        telephone: "",
        deleted: 0,
        is_verified: 0,
        is_active: 0,
        code_sended: "");
  }

  Future<List<Pays>> get pays async {
    var url = Uri.https(api_url, 'countries');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'API_Key': api_key,
      'AUTH_Token': auth_token
    });

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Pays.fromJson(json)).toList();
    }

    return [];
  }
}
