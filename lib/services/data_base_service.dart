// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/appeles.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/modals/coli_photos.dart';
import 'package:bodah/modals/coli_tarifs.dart';
import 'package:bodah/modals/colis.dart';
import 'package:bodah/modals/entite_factures.dart';
import 'package:bodah/modals/envoi_colis.dart';
import 'package:bodah/modals/interchanges.dart';
import 'package:bodah/modals/location_colis.dart';
import 'package:bodah/modals/notifications.dart';
import 'package:bodah/modals/recepteurs.dart';
import 'package:bodah/modals/recus.dart';
import 'package:bodah/modals/rules.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/modals/vgms.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/modals/voiture_photos.dart';
import 'package:bodah/modals/voitures.dart';
import 'package:bodah/providers/auth/prov_reset_password.dart';
import 'package:bodah/providers/auth/prov_val_account.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path; //
import 'package:path_provider/path_provider.dart';

import '../apis/bodah/infos.dart';
import '../modals/annonce_colis.dart';
import '../modals/arrondissements.dart';
import '../modals/bon_commandes.dart';
import '../modals/camions.dart';
import '../modals/communes.dart';
import '../modals/departements.dart';
import '../modals/destinataires.dart';
import '../modals/devises.dart';
import '../modals/donneur_ordres.dart';
import '../modals/entreprises.dart';
import '../modals/expediteurs.dart';
import '../modals/expeditions.dart';
import '../modals/localisations.dart';
import '../modals/marchandises.dart';
import '../modals/pays.dart';
import '../modals/quartiers.dart';
import '../modals/statuts.dart';
import '../modals/tarifications.dart';
import '../modals/tdos.dart';
import '../modals/transporteurs.dart';
import '../modals/type_chargements.dart';
import '../modals/users.dart';
import 'secure_storage.dart';

class DBServices {
  var api_url = ApiInfos.baseUrl;
  var api_key = ApiInfos.api_key;
  var auth_token = ApiInfos.aauth_token;
  SecureStorage secure = SecureStorage();

  Future<List<dynamic>> user() async {
    String? token = await secure.readSecureData('token');

    if (token.isNotEmpty) {
      var url = "${api_url}user";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data.containsKey('user') &&
            data['user'] != null &&
            data['user'] is Map<String, dynamic>) {
          Users user = Users.fromMap(data['user'] as Map<String, dynamic>);
          List<Rules> rules = [];

          if (data['roles'] is List) {
            final roles = data['roles'] as List<dynamic>;
            rules = roles
                .map((role) => Rules.fromMap(role as Map<String, dynamic>))
                .toList();
          } else {
            final role = data['roles'] as Map<String, dynamic>;
            rules = [Rules.fromMap(role)];
          }

          return [user, rules];
        } else {
          return [
            Users(
              dark_mode: 0,
              id: 0,
              name: "",
              country_id: 0,
              telephone: "",
              deleted: 0,
              is_verified: 0,
              is_active: 0,
            ),
            <Rules>[]
          ];
        }
      }

      return [
        Users(
          dark_mode: 0,
          id: 0,
          name: "",
          country_id: 0,
          telephone: "",
          deleted: 0,
          is_verified: 0,
          is_active: 0,
        ),
        <Rules>[]
      ];
    }

    return [
      Users(
        dark_mode: 0,
        id: 0,
        name: "",
        country_id: 0,
        telephone: "",
        deleted: 0,
        is_verified: 0,
        is_active: 0,
      ),
      <Rules>[]
    ];
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

  Future<List<Departements>> getDepartements() async {
    try {
      var url = "${api_url}departements";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Departements.fromMap(json)).toList();
      } else {
        return <Departements>[];
      }
    } catch (error) {
      return <Departements>[];
    }
  }

  Future<List<Communes>> getAllCommunes() async {
    try {
      var url = "${api_url}communes";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Communes.fromMap(json)).toList();
      } else {
        return <Communes>[];
      }
    } catch (error) {
      return <Communes>[];
    }
  }

  Future<List<Communes>> getCommunes(int departement_id) async {
    try {
      var url = "${api_url}departement/$departement_id";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Communes.fromMap(json)).toList();
      } else {
        return <Communes>[];
      }
    } catch (e) {
      return <Communes>[];
    }
  }

  Future<List<Arrondissements>> getArrondissements(int commune_id) async {
    try {
      var url = "${api_url}commune/$commune_id";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Arrondissements.fromMap(json)).toList();
      } else {
        return <Arrondissements>[];
      }
    } catch (e) {
      return <Arrondissements>[];
    }
  }

  Future<List<Quartiers>> getQuartiers(int arrondissement_id) async {
    try {
      var url = "${api_url}arrondissement/$arrondissement_id";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Quartiers.fromMap(json)).toList();
      } else {
        return <Quartiers>[];
      }
    } catch (e) {
      return <Quartiers>[];
    }
  }

  Future<List<Arrondissements>> getAllArrondissements() async {
    try {
      var url = "${api_url}arrondissements";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Arrondissements.fromMap(json)).toList();
      } else {
        return <Arrondissements>[];
      }
    } catch (error) {
      return <Arrondissements>[];
    }
  }

  Future<List<Quartiers>> getAllQuartiers() async {
    try {
      var url = "${api_url}quartiers";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Quartiers.fromMap(json)).toList();
      } else {
        return <Quartiers>[];
      }
    } catch (error) {
      return <Quartiers>[];
    }
  }

  Future<List<Unites>> getUnites() async {
    try {
      var url = "${api_url}unites";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Unites.fromMap(json)).toList();
      } else {
        return <Unites>[];
      }
    } catch (error) {
      return <Unites>[];
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
      var url = "${api_url}expeditions/statuts";
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

  Future<List<Entreprises>> getEntreprises() async {
    try {
      var url = "${api_url}entreprises";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Entreprises.fromMap(json)).toList();
      } else {
        return <Entreprises>[];
      }
    } catch (error) {
      return <Entreprises>[];
    }
  }

  Future<List<Recepteurs>> getRecepteurs() async {
    try {
      var url = "${api_url}recepteurs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Recepteurs.fromMap(json)).toList();
      } else {
        return <Recepteurs>[];
      }
    } catch (error) {
      return <Recepteurs>[];
    }
  }

  Future<List<Voitures>> getVoitures() async {
    try {
      var url = "${api_url}voitures";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Voitures.fromMap(json)).toList();
      } else {
        return <Voitures>[];
      }
    } catch (error) {
      return <Voitures>[];
    }
  }

  Future<List<VoiturePhotos>> getVoiturePhotos() async {
    try {
      var url = "${api_url}voiture/photos";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => VoiturePhotos.fromMap(json)).toList();
      } else {
        return <VoiturePhotos>[];
      }
    } catch (error) {
      return <VoiturePhotos>[];
    }
  }

  Future<List<Expediteurs>> getExpediteurs() async {
    try {
      var url = "${api_url}expediteurs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Expediteurs.fromMap(json)).toList();
      } else {
        return <Expediteurs>[];
      }
    } catch (error) {
      return <Expediteurs>[];
    }
  }

  Future<List<Transporteurs>> getTransporteurs() async {
    try {
      var url = "${api_url}transporteurs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Transporteurs.fromMap(json)).toList();
      } else {
        return <Transporteurs>[];
      }
    } catch (error) {
      return <Transporteurs>[];
    }
  }

  Future<List<Destinataires>> getDestinataires() async {
    try {
      var url = "${api_url}destinataires";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Destinataires.fromMap(json)).toList();
      } else {
        return <Destinataires>[];
      }
    } catch (error) {
      return <Destinataires>[];
    }
  }

  Future<List<Camions>> getCamions() async {
    try {
      var url = "${api_url}camions";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Camions.fromMap(json)).toList();
      } else {
        return <Camions>[];
      }
    } catch (error) {
      return <Camions>[];
    }
  }

  Future<List<Devises>> getDevises() async {
    try {
      var url = "${api_url}devises";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Devises.fromMap(json)).toList();
      } else {
        return <Devises>[];
      }
    } catch (error) {
      return <Devises>[];
    }
  }

  Future<List<EntiteFactures>> getEntiteFactures() async {
    try {
      var url = "${api_url}entitefactures";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => EntiteFactures.fromMap(json)).toList();
      } else {
        return <EntiteFactures>[];
      }
    } catch (error) {
      return <EntiteFactures>[];
    }
  }

  Future<List<DonneurOrdres>> getDonneurOrdres() async {
    try {
      var url = "${api_url}donneurordres";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => DonneurOrdres.fromMap(json)).toList();
      } else {
        return <DonneurOrdres>[];
      }
    } catch (error) {
      return <DonneurOrdres>[];
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

  Future<List<Villes>> getAllVilles() async {
    try {
      var url = "${api_url}villes";
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

  Future<List<TypeChargements>> getTypeChargements() async {
    try {
      var url = "${api_url}types/chargements";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => TypeChargements.fromMap(json)).toList();
      } else {
        return <TypeChargements>[];
      }
    } catch (error) {
      return <TypeChargements>[];
    }
  }

  Future<List<Recus>> getRecus() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/recus";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Recus.fromMap(json)).toList();
      } else {
        return <Recus>[];
      }
    } catch (error) {
      return <Recus>[];
    }
  }

  Future<List<Interchanges>> getInterchanges() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/interchanges";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Interchanges.fromMap(json)).toList();
      } else {
        return <Interchanges>[];
      }
    } catch (error) {
      return <Interchanges>[];
    }
  }

  Future<List<Vgms>> getVgms() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/vgms";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Vgms.fromMap(json)).toList();
      } else {
        return <Vgms>[];
      }
    } catch (error) {
      return <Vgms>[];
    }
  }

  Future<List<Tdos>> getTdos() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/tdos";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Tdos.fromMap(json)).toList();
      } else {
        return <Tdos>[];
      }
    } catch (error) {
      return <Tdos>[];
    }
  }

  Future<List<Appeles>> getApeles() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/apeles";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Appeles.fromMap(json)).toList();
      } else {
        return <Appeles>[];
      }
    } catch (error) {
      return <Appeles>[];
    }
  }

  Future<List<BonCommandes>> getOrdres() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/ordres";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => BonCommandes.fromMap(json)).toList();
      } else {
        return <BonCommandes>[];
      }
    } catch (error) {
      return <BonCommandes>[];
    }
  }

  Future<List<Annonces>> getAnnonces() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Annonces.fromMap(json)).toList();
      } else {
        return <Annonces>[];
      }
    } catch (error) {
      return <Annonces>[];
    }
  }

  Future<List<AnnonceColis>> getAnnonceColis() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annoncolis/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => AnnonceColis.fromMap(json)).toList();
      } else {
        return <AnnonceColis>[];
      }
    } catch (error) {
      return <AnnonceColis>[];
    }
  }

  Future<List<ColiPhotos>> getColiPhotos() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annoncecolis/photos";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => ColiPhotos.fromMap(json)).toList();
      } else {
        return <ColiPhotos>[];
      }
    } catch (error) {
      return <ColiPhotos>[];
    }
  }

  Future<List<LocationColis>> getLocationColis() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annoncecolis/locations";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => LocationColis.fromMap(json)).toList();
      } else {
        return <LocationColis>[];
      }
    } catch (error) {
      return <LocationColis>[];
    }
  }

  Future<List<ColiTarifs>> getColiTarifs() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annoncecolis/tarifs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => ColiTarifs.fromMap(json)).toList();
      } else {
        return <ColiTarifs>[];
      }
    } catch (error) {
      return <ColiTarifs>[];
    }
  }

  Future<List<Colis>> getColis() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annoncecolis/colis";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Colis.fromMap(json)).toList();
      } else {
        return <Colis>[];
      }
    } catch (error) {
      return <Colis>[];
    }
  }

  Future<List<EnvoiColis>> getEnvoiColis() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annoncecolis/envois";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => EnvoiColis.fromMap(json)).toList();
      } else {
        return <EnvoiColis>[];
      }
    } catch (error) {
      return <EnvoiColis>[];
    }
  }

  Future<List<Notifications>> getNotifications() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/notifications";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Notifications.fromMap(json)).toList();
      } else {
        return <Notifications>[];
      }
    } catch (error) {
      return <Notifications>[];
    }
  }

  Future<List<BordereauLivraisons>> getBordereaux() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/bordereaux";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) => BordereauLivraisons.fromMap(json))
            .toList();
      } else {
        return <BordereauLivraisons>[];
      }
    } catch (error) {
      return <BordereauLivraisons>[];
    }
  }

  Future<List<Expeditions>> getExpeditions() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/expeditions";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Expeditions.fromMap(json)).toList();
      } else {
        return <Expeditions>[];
      }
    } catch (error) {
      return <Expeditions>[];
    }
  }

  Future<List<Marchandises>> getMarchandises() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/marchandises";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Marchandises.fromMap(json)).toList();
      } else {
        return <Marchandises>[];
      }
    } catch (error) {
      return <Marchandises>[];
    }
  }

  Future<List<Tarifications>> getTarifications() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/tarifications";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Tarifications.fromMap(json)).toList();
      } else {
        return <Tarifications>[];
      }
    } catch (error) {
      return <Tarifications>[];
    }
  }

  Future<List<Localisations>> getLocalisations() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/localisations";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Localisations.fromMap(json)).toList();
      } else {
        return <Localisations>[];
      }
    } catch (error) {
      return <Localisations>[];
    }
  }

  Future<List<AnnoncePhotos>> getAnnoncePhotos() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonces/photos";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => AnnoncePhotos.fromMap(json)).toList();
      } else {
        return <AnnoncePhotos>[];
      }
    } catch (error) {
      return <AnnoncePhotos>[];
    }
  }

  Future<String> logout() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}logout";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> darkMode() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}darkmode";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<void> saveFileLocally(String filename, List<int> bytes) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = path.join(directory.path, filename);
    File file = File(filePath);
    await file.writeAsBytes(bytes);
  }

  Future<String> saveFile(String fileUrl) async {
    try {
      final originalFileName = path.basename(fileUrl);
      final fileExtension = path.extension(originalFileName);
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyyMMdd_HHmmss').format(now);
      final newFileName = 'Bodah_document_$formattedDate$fileExtension';

      // Déterminer le chemin du fichier à partir de l'URL
      final directory = await getApplicationDocumentsDirectory();
      path.join(directory.path, newFileName);

      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        await saveFileLocally(newFileName, response.bodyBytes);
        return "200";
      } else {
        return "203";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> publishAnnonce(
    String date_chargement,
    String nom,
    Unites unite,
    int poids,
    int quantite,
    int tarif,
    Pays pay_exp,
    Pays pay_liv,
    String adress_exp,
    String adress_liv,
    Villes ville_exp,
    Villes ville_liv,
    List<File> files,
  ) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/publish";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['date_chargement'] = date_chargement
        ..fields['nom'] = nom
        ..fields['unite'] = unite.id.toString()
        ..fields['poids'] = poids.toString()
        ..fields['quantite'] = quantite.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['city_exp'] = ville_exp.id.toString()
        ..fields['pays_exp'] = pay_exp.id.toString()
        ..fields['city_liv'] = ville_liv.id.toString()
        ..fields['pays_liv'] = pay_liv.id.toString()
        ..fields['address_exp'] = adress_exp
        ..fields['address_liv'] = adress_liv;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('file[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (date_chargement.isEmpty ||
          nom.isEmpty ||
          unite.name.isEmpty ||
          poids <= 0 ||
          pay_exp.name.isEmpty ||
          pay_liv.name.isEmpty ||
          ville_exp.name.isEmpty ||
          ville_liv.name.isEmpty) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> publishMarchandise(
      String date_chargement,
      String nom,
      Unites unite,
      int poids,
      int quantite,
      int tarif,
      Pays pay_exp,
      Pays pay_liv,
      String adress_exp,
      String adress_liv,
      Villes ville_exp,
      Villes ville_liv,
      List<File> files,
      Annonces annonce) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/annonce/marchandise/publish/${annonce.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['date_chargement'] = date_chargement
        ..fields['nom'] = nom
        ..fields['unite'] = unite.id.toString()
        ..fields['poids'] = poids.toString()
        ..fields['quantite'] = quantite.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['city_exp'] = ville_exp.id.toString()
        ..fields['pays_exp'] = pay_exp.id.toString()
        ..fields['city_liv'] = ville_liv.id.toString()
        ..fields['pays_liv'] = pay_liv.id.toString()
        ..fields['address_exp'] = adress_exp
        ..fields['address_liv'] = adress_liv;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('file[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (date_chargement.isEmpty ||
          nom.isEmpty ||
          unite.name.isEmpty ||
          poids <= 0 ||
          pay_exp.name.isEmpty ||
          pay_liv.name.isEmpty ||
          ville_exp.name.isEmpty ||
          ville_liv.name.isEmpty) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateMarchandise(
      String date_chargement,
      String nom,
      Unites unite,
      int poids,
      int quantite,
      int tarif,
      Pays pay_exp,
      Pays pay_liv,
      String adress_exp,
      String adress_liv,
      Villes ville_exp,
      Villes ville_liv,
      List<File> files,
      Marchandises marchandise) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/update/${marchandise.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['date_chargement'] = date_chargement
        ..fields['nom'] = nom
        ..fields['unite'] = unite.id.toString()
        ..fields['poids'] = poids.toString()
        ..fields['quantite'] = quantite.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['city_exp'] = ville_exp.id.toString()
        ..fields['pays_exp'] = pay_exp.id.toString()
        ..fields['city_liv'] = ville_liv.id.toString()
        ..fields['pays_liv'] = pay_liv.id.toString()
        ..fields['address_exp'] = adress_exp
        ..fields['address_liv'] = adress_liv;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('file[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (date_chargement.isEmpty ||
          nom.isEmpty ||
          unite.name.isEmpty ||
          poids <= 0 ||
          pay_exp.name.isEmpty ||
          pay_liv.name.isEmpty ||
          ville_exp.name.isEmpty ||
          ville_liv.name.isEmpty) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> deleteAnnonce(Annonces annonce) async {
    try {
      var url = "${api_url}home/expediteur/annonce/delete/${annonce.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      if (annonce.id <= 0) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> deleteMarchandise(Marchandises marchandise) async {
    try {
      var url =
          "${api_url}home/expediteur/annonce/marchandise/delete/${marchandise.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      if (marchandise.id <= 0) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> addOrdre(
      int delai_chargement,
      double amende_delai_chargement,
      double amende_dechargement,
      String email,
      String name,
      String phone_number,
      String adress,
      String entreprise,
      String entite_name,
      String entite_phone_number,
      String entite_adress,
      String entite_entreprise,
      String ifu,
      String entite_ifu,
      Annonces annonce) async {
    try {
      var url = "${api_url}home/expediteur/annonce/ordre/publish/${annonce.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      }, body: {
        'delai_chargement': delai_chargement.toString(),
        'amende_delai_chargement': amende_delai_chargement.toString(),
        'amende_dechargement': amende_dechargement.toString(),
        'email': email,
        'name': name,
        'phone_number': phone_number,
        'address': adress,
        'entreprise': entreprise,
        'entite_name': entite_name,
        'entite_phone_number': entite_phone_number,
        'entite_address': entite_adress,
        'entite_entreprise': entite_entreprise,
        'entite_ifu': entite_ifu,
        'ifu': ifu
      });

      if (delai_chargement <= 0 ||
          amende_delai_chargement <= 0 ||
          amende_dechargement <= 0 ||
          name.isEmpty ||
          entite_phone_number.length < 8 ||
          phone_number.length < 8 ||
          entite_name.isEmpty ||
          (entreprise.isNotEmpty && ifu.isEmpty) ||
          (entite_entreprise.isNotEmpty && entite_ifu.isEmpty)) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> updateOrdre(
      int delai_chargement,
      double amende_delai_chargement,
      double amende_dechargement,
      String email,
      String name,
      String phone_number,
      String adress,
      String entreprise,
      String entite_name,
      String entite_phone_number,
      String entite_adress,
      String entite_entreprise,
      String ifu,
      String entite_ifu,
      BonCommandes ordre) async {
    try {
      var url = "${api_url}home/expediteur/annonce/ordre/update/${ordre.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      }, body: {
        'delai_chargement': delai_chargement.toString(),
        'amende_delai_chargement': amende_delai_chargement.toString(),
        'amende_dechargement': amende_dechargement.toString(),
        'email': email,
        'name': name,
        'phone_number': phone_number,
        'address': adress,
        'entreprise': entreprise,
        'entite_name': entite_name,
        'entite_phone_number': entite_phone_number,
        'entite_address': entite_adress,
        'entite_entreprise': entite_entreprise,
        'entite_ifu': entite_ifu,
        'ifu': ifu
      });

      if (delai_chargement <= 0 ||
          amende_delai_chargement <= 0 ||
          amende_dechargement <= 0 ||
          name.isEmpty ||
          entite_phone_number.length < 8 ||
          phone_number.length < 8 ||
          entite_name.isEmpty ||
          (entreprise.isNotEmpty && ifu.isEmpty) ||
          (entite_entreprise.isNotEmpty && entite_ifu.isEmpty) ||
          ordre.id <= 0) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> deleteOrdre(BonCommandes ordre) async {
    try {
      var url = "${api_url}home/expediteur/annonce/ordre/delete/${ordre.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      if (ordre.id <= 0) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> validateOrdre(BonCommandes ordre) async {
    try {
      var url = "${api_url}home/expediteur/annonce/ordre/validate/${ordre.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      if (ordre.id <= 0) {
        return "100";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> register(
      String nom,
      String number,
      Statuts statut,
      Rules rule,
      String password,
      String confirm_password,
      Villes ville,
      Pays pay,
      ProvValiAccount provider) async {
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
        'country': pay.id,
        'password': password,
        'confirm_password': confirm_password
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        await secure.writeSecureData('token', token);
        final user = Users.fromMap(data['user']);
        provider.change_user(user);
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
        await secure.writeSecureData('token', token);
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
