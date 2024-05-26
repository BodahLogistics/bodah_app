// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:bodah/modals/rules.dart';
import 'package:bodah/modals/villes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/bodah/infos.dart';
import '../modals/pays.dart';
import '../modals/statuts.dart';
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

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
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

  Future<List<Pays>> getPays() async {
    try {
      var url = "${api_url}countries";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'AKI_KEY': api_key,
        'AUTH_TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Pays.fromMap(json)).toList();
      } else {
        return <Pays>[];
      }
    } catch (error) {
      return <Pays>[];
    }
  }

  Future<List<Rules>> getRules() async {
    try {
      var url = "${api_url}roles";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'AKI_KEY': api_key,
        'AUTH_TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Rules.fromMap(json)).toList();
      } else {
        return <Rules>[];
      }
    } catch (error) {
      return <Rules>[];
    }
  }

  Future<List<Statuts>> getStatuts() async {
    try {
      var url = "${api_url}statuts";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'AKI_KEY': api_key,
        'AUTH_TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Statuts.fromMap(json)).toList();
      } else {
        return <Statuts>[];
      }
    } catch (error) {
      return <Statuts>[];
    }
  }

  Future<List<Users>> getUsers() async {
    try {
      var url = "${api_url}users";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'AKI_KEY': api_key,
        'AUTH_TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Users.fromMap(json)).toList();
      } else {
        return <Users>[];
      }
    } catch (error) {
      return <Users>[];
    }
  }

  Future<List<Villes>> getVilles(int countr_id) async {
    try {
      var url = "${api_url}country/" + countr_id.toString();
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'AKI_KEY': api_key,
        'AUTH_TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Villes.fromMap(json)).toList();
      } else {
        return <Villes>[];
      }
    } catch (e) {
      return <Villes>[];
    }
  }

  Future<String> register(String nom, String number, Statuts statut, Rules rule,
      String password, String confirm_password, Villes ville, Pays pay) async {
    var url = "${api_url}register";
    final uri = Uri.parse(url);
    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json',
      'AKI_KEY': api_key,
      'AUTH_TOKEN': auth_token
    }, body: {
      'name': nom,
      'phone_number': number,
      'statut': statut.id,
      'role': rule.id,
      'city': ville.id,
      'country': pay.id,
      'password': password,
      'confirm_password': confirm_password
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];
      await setToken(token);
    }

    return response.statusCode.toString();
  }

  Future<String> login(String number, String password) async {
    try {
      var url = "${api_url}login";
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode({
            'phone_number': number,
            'password': password,
          }));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        await setToken(token);
      }

      if (response.statusCode == 500) {
        final data = jsonDecode(response.body);
        print(data);
      }

      return response.statusCode.toString();
    } catch (e) {
      print(e);
      return "802";
    }
  }

  Future<String> validateAccount(String code, Users user) async {
    var url = "${api_url}account/validate/" + user.id.toString();
    final uri = Uri.parse(url);
    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json',
      'AKI_KEY': api_key,
      'AUTH_TOKEN': auth_token
    }, body: {
      'code': code,
    });

    return response.statusCode.toString();
  }
}
