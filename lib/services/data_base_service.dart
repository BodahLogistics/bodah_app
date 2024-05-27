// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:convert';

import 'package:bodah/modals/rules.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/providers/auth/prov_reset_password.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../apis/bodah/infos.dart';
import '../modals/pays.dart';
import '../modals/statuts.dart';
import '../modals/users.dart';
import 'package:http/http.dart' as http;

class DBServices {
  var api_url = ApiInfos.baseUrl;
  var api_key = ApiInfos.api_key;
  var auth_token = ApiInfos.aauth_token;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Future<void> writeSecureToken(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readSecureToken(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteSecureToken(String key) async {
    await storage.delete(key: key);
  }

  Future<Users> user() async {
    var token = await readSecureToken("token");

    if (token != null) {
      var url = "${api_url}user";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return Users.fromMap(userData);
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
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
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
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
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
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
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
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
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
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
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
    try {
      var url = "${api_url}register";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      }, body: {
        'name': nom,
        'phone_number': number,
        'statut': statut.id.toString(),
        'role': rule.id.toString(),
        'city': ville.id.toString(),
        'country': pay.id.toString(),
        'password': password,
        'confirm_password': confirm_password
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        await writeSecureToken('token', token);
      }

      return response.statusCode.toString();
    } catch (e) {
      return "502";
    }
  }

  Future<String> login(String number, String password) async {
    try {
      var url = "${api_url}login";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      }, body: {
        'phone_number': number,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        await writeSecureToken('token', token);
      }

      return response.statusCode.toString();
    } catch (e) {
      return "502";
    }
  }

  Future<String> validateAccount(String code, Users user) async {
    var url = "${api_url}account/validate/" + user.id.toString();
    final uri = Uri.parse(url);
    final response = await http.post(uri, headers: {
      'API-KEY': api_key,
      'AUTH-TOKEN': auth_token
    }, body: {
      'code': code,
    });

    return response.statusCode.toString();
  }

  Future<String> resetPassword(
      String number, ProvResetPassword provider) async {
    try {
      var url = "${api_url}reset/send/code";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      }, body: {
        'phone_number': number,
      });

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        final user = Users.fromMap(userData);
        provider.change_user(user);
      }

      return response.statusCode.toString();
    } catch (e) {
      return "502";
    }
  }

  Future<String> validateResetCode(String code, Users user) async {
    try {
      var url = "${api_url}reset/validate/" + user.id.toString();
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      }, body: {
        'code': code,
      });

      return response.statusCode.toString();
    } catch (e) {
      return "502";
    }
  }

  Future<String> change_password(
      Users user, String password, String confirm_password) async {
    try {
      var url = "${api_url}reset/" + user.id.toString();
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          headers: {'API-KEY': api_key, 'AUTH-TOKEN': auth_token},
          body: {'password': password, 'confirm_password': confirm_password});

      return response.statusCode.toString();
    } catch (e) {
      return "502";
    }
  }
}
