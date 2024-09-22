// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:bodah/modals/annonce_photos.dart';
import 'package:bodah/modals/annonces.dart';
import 'package:bodah/modals/appeles.dart';
import 'package:bodah/modals/bordereau_livraisons.dart';
import 'package:bodah/modals/cargaison.dart';
import 'package:bodah/modals/coli_photos.dart';
import 'package:bodah/modals/coli_tarifs.dart';
import 'package:bodah/modals/colis.dart';
import 'package:bodah/modals/entite_factures.dart';
import 'package:bodah/modals/envoi_colis.dart';
import 'package:bodah/modals/interchanges.dart';
import 'package:bodah/modals/location_colis.dart';
import 'package:bodah/modals/notifications.dart';
import 'package:bodah/modals/rules.dart';
import 'package:bodah/modals/unites.dart';
import 'package:bodah/modals/vgms.dart';
import 'package:bodah/modals/villes.dart';
import 'package:bodah/modals/voiture_photos.dart';
import 'package:bodah/modals/voitures.dart';
import 'package:bodah/providers/api/api_data.dart';
import 'package:bodah/providers/auth/prov_reset_password.dart';
import 'package:bodah/providers/auth/prov_val_account.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path; //
import 'package:path_provider/path_provider.dart';

import '../apis/bodah/infos.dart';
import '../modals/annonce_colis.dart';
import '../modals/annonce_transporteurs.dart';
import '../modals/arrondissements.dart';
import '../modals/autre_docs.dart';
import '../modals/avds.dart';
import '../modals/bfus.dart';
import '../modals/bl.dart';
import '../modals/bon_commandes.dart';
import '../modals/camions.dart';
import '../modals/cargaison_client.dart';
import '../modals/cartificat_origine.dart';
import '../modals/certificat_phyto_sanitaire.dart';
import '../modals/chargement.dart';
import '../modals/chargement_effectues.dart';
import '../modals/charges.dart';
import '../modals/client.dart';
import '../modals/communes.dart';
import '../modals/conducteur.dart';
import '../modals/declaration.dart';
import '../modals/departements.dart';
import '../modals/destinataires.dart';
import '../modals/devises.dart';
import '../modals/donneur_ordres.dart';
import '../modals/entreprises.dart';
import '../modals/expediteurs.dart';
import '../modals/expeditions.dart';
import '../modals/exports.dart';
import '../modals/fiche_technique.dart';
import '../modals/import.dart';
import '../modals/info_localisation.dart';
import '../modals/letrre_voyage.dart';
import '../modals/livraison_cargaison.dart';
import '../modals/localisations.dart';
import '../modals/lta.dart';
import '../modals/marchandise_transporteur.dart';
import '../modals/marchandises.dart';
import '../modals/ordre_transport.dart';
import '../modals/path.dart';
import '../modals/pays.dart';
import '../modals/pieces.dart';
import '../modals/positions.dart';
import '../modals/quartiers.dart';
import '../modals/recus.dart';
import '../modals/souscriptions.dart';
import '../modals/statut_expeditions.dart';
import '../modals/statuts.dart';
import '../modals/tarifications.dart';
import '../modals/tarifs.dart';
import '../modals/tdos.dart';
import '../modals/transport_liaison.dart';
import '../modals/transport_mode.dart';
import '../modals/transporteurs.dart';
import '../modals/type_camions.dart';
import '../modals/type_chargements.dart';
import '../modals/users.dart';
import 'secure_storage.dart';

class DBServices {
  var api_url = ApiInfos.baseUrl;
  var api_key = ApiInfos.api_key;
  var auth_token = ApiInfos.aauth_token;
  SecureStorage secure = SecureStorage();

  Future<List<dynamic>> user() async {
    try {
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
    } catch (error) {
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

  Future<List<StatutExpeditions>> getStatutExpeditions() async {
    try {
      var url = "${api_url}status";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => StatutExpeditions.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
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
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/entreprises";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/expediteurs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/transporteurs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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

  Future<List<Transporteurs>> getTransporteur() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/liste";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/destinataires";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/vehicules";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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

  Future<List<Camions>> getTransporteurCamions() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/vehicules";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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

  Future<List<Pieces>> getPieces() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/pieces";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Pieces.fromMap(json)).toList();
      } else {
        return <Pieces>[];
      }
    } catch (error) {
      return <Pieces>[];
    }
  }

  Future<List<Pieces>> getTransporteurPieces() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/pieces";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Pieces.fromMap(json)).toList();
      } else {
        return <Pieces>[];
      }
    } catch (error) {
      return <Pieces>[];
    }
  }

  Future<List<TransportLiaisons>> getChauffeurs() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/chauffeur/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => TransportLiaisons.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<AnnonceTransporteurs>> getTrajet() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/trajet/list";
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
            .map((json) => AnnonceTransporteurs.fromMap(json))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<MarchandiseTransporteur>> getTrajetMarchandise() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/trajet/marchandises";
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
            .map((json) => MarchandiseTransporteur.fromMap(json))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<InfoLocalisations>> getInfoLocalisations() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/trajet/localisations";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => InfoLocalisations.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Souscriptions>> getSouscription() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/souscription/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Souscriptions.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Expeditions>> getTransporteurExpditions() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/expedition/list";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Annonces>> getTransporteurAnnonces() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/list";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<AnnoncePhotos>> getTransporteurAnnoncePhotos() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/photos";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Localisations>> getAnnonceTransporteurLocalisation() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/localisations";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Tarifications>> getAnnonceTransporteurTarification() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/tarifications";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Marchandises>> getAnnonceTransporteurMarchandises() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/marchandises";
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
        return [];
      }
    } catch (error) {
      return [];
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
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/entitefactures";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/donneurordres";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
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

  Future<List<TypeCamions>> getTypeCamions() async {
    try {
      var url = "${api_url}types/camions";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => TypeCamions.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Appeles>> getTransporteurApeles() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/document/apele";
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

  Future<List<Interchanges>> getTransporteurInterchange() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/document/interchange";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Tdos>> getTransporteurTdo() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/document/tdo";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Vgms>> getTransporteurVgm() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/document/vgm";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Recus>> getTransporteurRecus() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/document/recus";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Paths>> getTransporteurPaths() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/document/path";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Paths.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<LetreVoitures>> getTransporteurContrat() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/document/contrat/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => LetreVoitures.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<BordereauLivraisons>> getTransporteurBordereaux() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/document/bordereau/list";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  /*  Appeles */

  Future<List<Appeles>> getApeles() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/apele/list";
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

  Future<String> AddImportApele(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/apele/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateApele(
      String doc_id, List<File> files, Appeles apele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/apele/update/${apele.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteApele(Appeles apele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/apele/delete/${apele.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Appeles */

  /*  Lta */

  Future<List<Lta>> getLtas() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/lta/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Lta.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportLta(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/lta/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateLta(String doc_id, List<File> files, Lta lta) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/lta/update/${lta.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteLta(Lta lta) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/lta/delete/${lta.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Lta */

  /*  BL */

  Future<List<Bl>> getBls() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/bl/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Bl.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportBl(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/bl/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateBl(String doc_id, List<File> files, Bl data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/bl/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteBl(Bl data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/bl/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Bl */

  /*  TDO */

  Future<List<Tdos>> getTdos() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/tdo/list";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportTdo(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/tdo/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateTdo(String doc_id, List<File> files, Tdos data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/tdo/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteTdo(Tdos data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/tdo/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Tdo */

  /* VGML */

  Future<List<Vgms>> getVgms() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/vgm/list";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportVgm(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/vgm/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateVgm(String doc_id, List<File> files, Vgms data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/vgm/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteVgm(Vgms data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/vgm/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End VGM */

  /*  Interchanges */

  Future<List<Interchanges>> getInterchanges() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/interchange/list";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportInterchange(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/interchange/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateInterchange(
      String doc_id, List<File> files, Interchanges data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/interchange/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteInterchange(Interchanges data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/interchange/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Interchanges */

  Future<List<Paths>> getPaths() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/paths";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Paths.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  /*  Odre import export */

  Future<List<OrdreTransport>> getImportOrdre() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/ordre/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => OrdreTransport.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportOrdre(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/ordre/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateImportOrdre(
      String doc_id, List<File> files, OrdreTransport data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/ordre/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteOrdre(OrdreTransport data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/ordre/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Ordre import export */

  /*  Reçu */

  Future<List<Recus>> getRecus() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/recu/list";
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportRecu(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/recu/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateRecu(String doc_id, List<File> files, Recus data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/recu/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteRecu(Recus data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/recu/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Reçus */

  /*  AVD */

  Future<List<Avd>> getAvds() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/avd/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Avd.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportAvd(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/avd/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateAvd(String doc_id, List<File> files, Avd data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/avd/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteAvd(Avd data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/avd/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End AVD */

  /*  BFU */

  Future<List<Bfu>> getBfus() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/bfu/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Bfu.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportBfu(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/bfu/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateBfu(String doc_id, List<File> files, Bfu data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/bfu/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteBfu(Bfu data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/bfu/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End BFU */

  /*  Déclarations */

  Future<List<Declaration>> getDeclarations() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/declaration/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Declaration.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportDeclaration(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/declaration/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateDeclaration(
      String doc_id, List<File> files, Declaration data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/declaration/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteDeclaration(Declaration data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/declaration/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Déclaration */

  /*  Fiche techniques */

  Future<List<FicheTechnique>> getFiches() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/fiche/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => FicheTechnique.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportFiche(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/fiche/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateFiche(
      String doc_id, List<File> files, FicheTechnique data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/fiche/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteFiche(FicheTechnique data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/fiche/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Fiche technique */

  /*  CO */

  Future<List<CO>> getCos() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/co/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => CO.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportCo(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/co/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateCo(String doc_id, List<File> files, CO data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/co/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteCo(CO data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/co/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End CO */

  /*  CPS */

  Future<List<CPS>> getCps() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/cps/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => CPS.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportCps(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/cps/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateCps(String doc_id, List<File> files, CPS data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/cps/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteCps(CPS data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/cps/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End CPS */

  /*  Autre Doc */

  Future<List<AutreDocs>> getAutreDocs() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/document/doc/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => AutreDocs.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> AddImportDoc(
      String doc_id, List<File> files, int data_id, String modele) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/${modele.toLowerCase()}/document/doc/publish/$data_id";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> UpdateDoc(
      String doc_id, List<File> files, AutreDocs data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/doc/update/${data.id}";
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['doc_id'] = doc_id;

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('path[]', file.path));
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  Future<String> DeleteDoc(AutreDocs data) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/document/doc/delete/${data.id}";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token,
        'Authorization': 'Bearer $token',
      });

      return response.statusCode.toString();
    } catch (e) {
      return "202"; // Code d'erreur personnalisé
    }
  }

  /*  End Autre Doc */

  Future<List<BonCommandes>> getOrdres() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/annonce/ordres";
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
      var url = "${api_url}home/expediteur/annonce/list";
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

  Future<List<Import>> getImports() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Import.fromMap(json)).toList();
      } else {
        return <Import>[];
      }
    } catch (error) {
      return <Import>[];
    }
  }

  Future<List<Exports>> getExports() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/export/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Exports.fromMap(json)).toList();
      } else {
        return <Exports>[];
      }
    } catch (error) {
      return <Exports>[];
    }
  }

  Future<List<TransportMode>> getTransportMode() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/types";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => TransportMode.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<int> getImportRouteKey() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/route/key";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        // Vérifier et convertir en int si possible
        if (data is int) {
          return data;
        } else if (data is String && int.tryParse(data) != null) {
          return int.parse(data);
        } else if (data is Map && data['key'] != null) {
          return data['key'] is int
              ? data['key']
              : int.tryParse(data['key'].toString()) ?? 0;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }

  Future<int> getExportRouteKey() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/export/route/key";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        // Vérifier et convertir en int si possible
        if (data is int) {
          return data;
        } else if (data is String && int.tryParse(data) != null) {
          return int.parse(data);
        } else if (data is Map && data['key'] != null) {
          return data['key'] is int
              ? data['key']
              : int.tryParse(data['key'].toString()) ?? 0;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }

  Future<int> getImportMaritimeKey() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/maritime/key";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        // Vérifier et convertir en int si possible
        if (data is int) {
          return data;
        } else if (data is String && int.tryParse(data) != null) {
          return int.parse(data);
        } else if (data is Map && data['key'] != null) {
          return data['key'] is int
              ? data['key']
              : int.tryParse(data['key'].toString()) ?? 0;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }

  Future<int> getExportMaritimeKey() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/export/maritime/key";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        // Vérifier et convertir en int si possible
        if (data is int) {
          return data;
        } else if (data is String && int.tryParse(data) != null) {
          return int.parse(data);
        } else if (data is Map && data['key'] != null) {
          return data['key'] is int
              ? data['key']
              : int.tryParse(data['key'].toString()) ?? 0;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }

  Future<int> getImportAerienKey() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/aerien/key";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        // Vérifier et convertir en int si possible
        if (data is int) {
          return data;
        } else if (data is String && int.tryParse(data) != null) {
          return int.parse(data);
        } else if (data is Map && data['key'] != null) {
          return data['key'] is int
              ? data['key']
              : int.tryParse(data['key'].toString()) ?? 0;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }

  Future<int> getExportAerienKey() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/export/aerien/key";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        // Vérifier et convertir en int si possible
        if (data is int) {
          return data;
        } else if (data is String && int.tryParse(data) != null) {
          return int.parse(data);
        } else if (data is Map && data['key'] != null) {
          return data['key'] is int
              ? data['key']
              : int.tryParse(data['key'].toString()) ?? 0;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }

  Future<List<CargaisonClient>> getCargaisonClients() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/cargaison/clients";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => CargaisonClient.fromMap(json)).toList();
      } else {
        return <CargaisonClient>[];
      }
    } catch (error) {
      return <CargaisonClient>[];
    }
  }

  Future<List<Chargement>> getChargements() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/chargements";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Chargement.fromMap(json)).toList();
      } else {
        return <Chargement>[];
      }
    } catch (error) {
      return <Chargement>[];
    }
  }

  Future<List<Position>> getPositions() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/positions";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Position.fromMap(json)).toList();
      } else {
        return <Position>[];
      }
    } catch (error) {
      return <Position>[];
    }
  }

  Future<List<Tarif>> getTarifs() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/tarifs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Tarif.fromMap(json)).toList();
      } else {
        return <Tarif>[];
      }
    } catch (error) {
      return <Tarif>[];
    }
  }

  Future<List<Tarif>> getTransporteurTarif() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/expedition/tarifs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Tarif.fromMap(json)).toList();
      } else {
        return <Tarif>[];
      }
    } catch (error) {
      return <Tarif>[];
    }
  }

  Future<List<Charge>> getCharges() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/charges";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Charge.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Charge>> getTransporteurCharge() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/annonce/expedition/charges";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Charge.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<Conducteur>> getConducteurs() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/conducteurs";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Conducteur.fromMap(json)).toList();
      } else {
        return <Conducteur>[];
      }
    } catch (error) {
      return <Conducteur>[];
    }
  }

  Future<List<Client>> getClients() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/clients";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Client.fromMap(json)).toList();
      } else {
        return <Client>[];
      }
    } catch (error) {
      return <Client>[];
    }
  }

  Future<List<ChargementEffectue>> getChargementEffectues() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/chargement/effectues";
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
            .map((json) => ChargementEffectue.fromMap(json))
            .toList();
      } else {
        return <ChargementEffectue>[];
      }
    } catch (error) {
      return <ChargementEffectue>[];
    }
  }

  Future<List<LivraisonCargaison>> getLivraisons() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/livraison/list";
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
            .map((json) => LivraisonCargaison.fromMap(json))
            .toList();
      } else {
        return <LivraisonCargaison>[];
      }
    } catch (error) {
      return <LivraisonCargaison>[];
    }
  }

  Future<List<Cargaison>> getCargaisons() async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/marchandise/list";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Cargaison.fromMap(json)).toList();
      } else {
        return <Cargaison>[];
      }
    } catch (error) {
      return <Cargaison>[];
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
      var url = "${api_url}home/expediteur/annonce/notifications";
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
      var url = "${api_url}home/expediteur/annonce/bordereaux";
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
      var url = "${api_url}home/expediteur/annonce/expeditions";
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
      var url = "${api_url}home/expediteur/annonce/marchandises";
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
      var url = "${api_url}home/expediteur/annonce/tarifications";
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
      var url = "${api_url}home/expediteur/annonce/localisations";
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
      var url = "${api_url}home/expediteur/annonce/photos";
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

      if (response.statusCode == 200) {
        await secure.deleteSecureData('token');
        await secure.deleteSecureData("user");
        await secure.deleteSecureData('rule');
      }

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

  Future<String> getFilePath(String filePath) async {
    final directory = await getApplicationDocumentsDirectory();
    String file_name = await fileName(filePath);
    return '${directory.path}/$file_name'; // Nom du fichier téléchargé
  }

  Future<void> saveFileLocally(String filename, List<int> bytes) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = path.join(directory.path, filename);
    File file = File(filePath);
    await file.writeAsBytes(bytes);
  }

  Future<String> fileName(String fileUrl) async {
    final originalFileName = path.basename(fileUrl);
    final fileExtension = path.extension(originalFileName);
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyyMMdd_HHmmss').format(now);
    final newFileName = 'Bodah_document_$formattedDate$fileExtension';

    return newFileName;
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
      double poids,
      int quantite,
      int tarif,
      Pays pay_exp,
      Pays pay_liv,
      String adress_exp,
      String adress_liv,
      Villes ville_exp,
      Villes ville_liv,
      List<File> files,
      ApiProvider provider) async {
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

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> AddTrajet(
      String charge,
      TypeChargements type_chargement,
      Pays pay_exp,
      Pays pay_liv,
      Villes ville_exp,
      Villes ville_liv,
      ApiProvider provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/trajet/add";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['nombre_tonnes'] = charge
        ..fields['type_chargement'] = type_chargement.id.toString()
        ..fields['city_dep'] = ville_exp.id.toString()
        ..fields['pays_dep'] = pay_exp.id.toString()
        ..fields['city_dest'] = ville_liv.id.toString()
        ..fields['pays_dest'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateTrajet(
      String charge,
      TypeChargements type_chargement,
      Pays pay_exp,
      Pays pay_liv,
      Villes ville_exp,
      Villes ville_liv,
      ApiProvider provider,
      AnnonceTransporteurs trajet) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/trajet/update/${trajet.id}";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['nombre_tonnes'] = charge
        ..fields['type_chargement'] = type_chargement.id.toString()
        ..fields['city_dep'] = ville_exp.id.toString()
        ..fields['pays_dep'] = pay_exp.id.toString()
        ..fields['city_dest'] = ville_liv.id.toString()
        ..fields['pays_dest'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> deleteTrajet(AnnonceTransporteurs trajet) async {
    try {
      var url = "${api_url}home/transporteur/trajet/delete/${trajet.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> AddCamion(
      String imm,
      TypeCamions type_camion,
      List<File> files,
      List<File> file2,
      List<File> file3,
      ApiProvider provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/trajet/add/camion";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['imm'] = imm
        ..fields['type_camion'] = type_camion.id.toString();

      if (files.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'face_avant_image', files.first.path));
      }

      if (file2.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'partie_arriere_image', file2.first.path));
      }

      if (file3.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'profil_image', file3.first.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> AddChauffeur(
      String imm,
      TypeCamions type_camion,
      List<File> files,
      List<File> file2,
      List<File> file3,
      List<File> profil,
      String name,
      String telephone,
      String permis,
      Pays pay,
      Villes city,
      String email,
      String adresse,
      ApiProvider provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/transporteur/chauffeur/add";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['imm'] = imm
        ..fields['email'] = email
        ..fields['address'] = adresse
        ..fields['name'] = name
        ..fields['phone_number'] = telephone
        ..fields['city'] = city.id.toString()
        ..fields['country'] = pay.id.toString()
        ..fields['number'] = permis
        ..fields['type_camion'] = type_camion.id.toString();

      if (files.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'face_avant_image', files.first.path));
      }

      if (file2.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'partie_arriere_image', file2.first.path));
      }

      if (file3.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'profil_image', file3.first.path));
      }

      if (profil.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('photo', profil.first.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateChauffeur(
      Transporteurs transporteur,
      String name,
      String telephone,
      String permis,
      Pays pay,
      Villes city,
      String email,
      String adresse,
      ApiProvider provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/transporteur/chauffeur/update/${transporteur.id}";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['email'] = email
        ..fields['address'] = adresse
        ..fields['name'] = name
        ..fields['phone_number'] = telephone
        ..fields['city'] = city.id.toString()
        ..fields['country'] = pay.id.toString()
        ..fields['number'] = permis;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> deleteChauffeur(TransportLiaisons chauffeur) async {
    try {
      var url = "${api_url}home/transporteur/chauffeur/delete/${chauffeur.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> activeChauffeur(TransportLiaisons chauffeur) async {
    try {
      var url = "${api_url}home/transporteur/chauffeur/active/${chauffeur.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> disableChauffeur(TransportLiaisons chauffeur) async {
    try {
      var url = "${api_url}home/transporteur/chauffeur/disable/${chauffeur.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> AddSouscription(Marchandises marchandise) async {
    try {
      var url =
          "${api_url}home/transporteur/annonce/souscription/add/${marchandise.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> DeleteSouscription(Souscriptions souscription) async {
    try {
      var url =
          "${api_url}home/transporteur/annonce/souscription/delete/${souscription.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> addTransp(
      String name,
      String permis,
      String telephone,
      String imm,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      int import_id) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/transporteur/publish/$import_id";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name
        ..fields['permis'] = permis
        ..fields['telephone'] = telephone
        ..fields['imm'] = imm
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addTranspExport(
      String name,
      String permis,
      String telephone,
      String imm,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      int import_id) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/export/transporteur/publish/$import_id";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name
        ..fields['permis'] = permis
        ..fields['telephone'] = telephone
        ..fields['imm'] = imm
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addImportRoute(
      String client_name,
      String permis,
      String client_telephone,
      String imm,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      String marchandise,
      String date_debut,
      String date_fin,
      String conducteur_name,
      String conducteur_telephone,
      int quantite,
      ApiProvider api_provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/route/publish";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['march'] = marchandise
        ..fields['permis'] = permis
        ..fields['cl_name'] = client_name
        ..fields['cl_telephone'] = client_telephone
        ..fields['ch_name'] = conducteur_name
        ..fields['ch_telephone'] = conducteur_telephone
        ..fields['imm'] = imm
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['qte'] = quantite.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        if (data is int) {
          api_provider.change_data_id(data);
        } else if (data is String && int.tryParse(data) != null) {
          api_provider.change_data_id(int.parse(data));
        } else if (data is Map && data['key'] != null) {
          data['key'] is int
              ? api_provider.change_data_id(data['key'])
              : api_provider
                  .change_data_id(int.tryParse(data['key'].toString()) ?? 0);
        }
      }

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addExportRoute(
      String client_name,
      String permis,
      String client_telephone,
      String imm,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      String marchandise,
      String date_debut,
      String date_fin,
      String conducteur_name,
      String conducteur_telephone,
      int quantite,
      ApiProvider api_provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/export/route/publish";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['march'] = marchandise
        ..fields['permis'] = permis
        ..fields['cl_name'] = client_name
        ..fields['cl_telephone'] = client_telephone
        ..fields['ch_name'] = conducteur_name
        ..fields['ch_telephone'] = conducteur_telephone
        ..fields['imm'] = imm
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['qte'] = quantite.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        if (data is int) {
          api_provider.change_data_id(data);
        } else if (data is String && int.tryParse(data) != null) {
          api_provider.change_data_id(int.parse(data));
        } else if (data is Map && data['key'] != null) {
          data['key'] is int
              ? api_provider.change_data_id(data['key'])
              : api_provider
                  .change_data_id(int.tryParse(data['key'].toString()) ?? 0);
        }
      }

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addImportMaritime(
      String client_name,
      String bl,
      String conteneur,
      String client_telephone,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      String marchandise,
      String date_debut,
      String date_fin,
      int quantite,
      ApiProvider api_provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/maritime/publish";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['march'] = marchandise
        ..fields['bl'] = bl
        ..fields['name'] = client_name
        ..fields['telephone'] = client_telephone
        ..fields['ref'] = conteneur
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['qte'] = quantite.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        if (data is int) {
          api_provider.change_data_id(data);
        } else if (data is String && int.tryParse(data) != null) {
          api_provider.change_data_id(int.parse(data));
        } else if (data is Map && data['key'] != null) {
          data['key'] is int
              ? api_provider.change_data_id(data['key'])
              : api_provider
                  .change_data_id(int.tryParse(data['key'].toString()) ?? 0);
        }
      }

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addExportMaritime(
      String client_name,
      String bl,
      String conteneur,
      String client_telephone,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      String marchandise,
      String date_debut,
      String date_fin,
      int quantite,
      ApiProvider api_provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/export/maritime/publish";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['march'] = marchandise
        ..fields['bl'] = bl
        ..fields['name'] = client_name
        ..fields['telephone'] = client_telephone
        ..fields['ref'] = conteneur
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['qte'] = quantite.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        if (data is int) {
          api_provider.change_data_id(data);
        } else if (data is String && int.tryParse(data) != null) {
          api_provider.change_data_id(int.parse(data));
        } else if (data is Map && data['key'] != null) {
          data['key'] is int
              ? api_provider.change_data_id(data['key'])
              : api_provider
                  .change_data_id(int.tryParse(data['key'].toString()) ?? 0);
        }
      }

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addImportAerien(
      String client_name,
      String lta,
      String numero_marchandise,
      String client_telephone,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      String marchandise,
      String date_debut,
      String date_fin,
      int quantite,
      ApiProvider api_provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/aerien/publish";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['march'] = marchandise
        ..fields['lta'] = lta
        ..fields['name'] = client_name
        ..fields['telephone'] = client_telephone
        ..fields['ref'] = numero_marchandise
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['qte'] = quantite.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        if (data is int) {
          api_provider.change_data_id(data);
        } else if (data is String && int.tryParse(data) != null) {
          api_provider.change_data_id(int.parse(data));
        } else if (data is Map && data['key'] != null) {
          data['key'] is int
              ? api_provider.change_data_id(data['key'])
              : api_provider
                  .change_data_id(int.tryParse(data['key'].toString()) ?? 0);
        }
      }

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addExportAerien(
      String client_name,
      String lta,
      String numero_marchandise,
      String client_telephone,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      String marchandise,
      String date_debut,
      String date_fin,
      int quantite,
      ApiProvider api_provider) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/export/aerien/publish";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['march'] = marchandise
        ..fields['lta'] = lta
        ..fields['name'] = client_name
        ..fields['telephone'] = client_telephone
        ..fields['ref'] = numero_marchandise
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['qte'] = quantite.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        if (data is int) {
          api_provider.change_data_id(data);
        } else if (data is String && int.tryParse(data) != null) {
          api_provider.change_data_id(int.parse(data));
        } else if (data is Map && data['key'] != null) {
          data['key'] is int
              ? api_provider.change_data_id(data['key'])
              : api_provider
                  .change_data_id(int.tryParse(data['key'].toString()) ?? 0);
        }
      }

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> deleteImport(Import import) async {
    try {
      var url = "${api_url}home/expediteur/import/delete/${import.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> deleteExport(Exports export) async {
    try {
      var url = "${api_url}home/expediteur/export/delete/${export.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> addMarch(
      String marchandise,
      String date_debut,
      String date_fin,
      String name,
      String telephone,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      int quantite,
      int import_id) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/marchandise/publish/$import_id";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = marchandise
        ..fields['cl_name'] = name
        ..fields['telephone'] = telephone
        ..fields['qte'] = quantite.toString()
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addMarchExport(
      String marchandise,
      String date_debut,
      String date_fin,
      String name,
      String telephone,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      int quantite,
      int import_id) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/export/marchandise/publish/$import_id";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = marchandise
        ..fields['cl_name'] = name
        ..fields['telephone'] = telephone
        ..fields['qte'] = quantite.toString()
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addLiv(
      Cargaison cargaison,
      String name,
      String telephone,
      Pays pay,
      Villes city,
      String adresse,
      int quantite,
      String superviseur,
      int import_id) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/import/livraison/publish/$import_id";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name
        ..fields['march'] = cargaison.id.toString()
        ..fields['telephone'] = telephone
        ..fields['qte'] = quantite.toString()
        ..fields['address'] = adresse
        ..fields['sup'] = superviseur
        ..fields['city'] = city.id.toString()
        ..fields['pay'] = pay.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> addLivExport(
      Cargaison cargaison,
      String name,
      String telephone,
      Pays pay,
      Villes city,
      String adresse,
      int quantite,
      String superviseur,
      int import_id) async {
    try {
      String? token = await secure.readSecureData('token');
      var url = "${api_url}home/expediteur/export/livraison/publish/$import_id";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name
        ..fields['march'] = cargaison.id.toString()
        ..fields['telephone'] = telephone
        ..fields['qte'] = quantite.toString()
        ..fields['address'] = adresse
        ..fields['sup'] = superviseur
        ..fields['city'] = city.id.toString()
        ..fields['pay'] = pay.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> updateLiv(
      Cargaison cargaison,
      String name,
      String telephone,
      Pays pay,
      Villes city,
      String adresse,
      int quantite,
      String superviseur,
      LivraisonCargaison livraison) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/livraison/update/${livraison.id}";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name
        ..fields['march'] = cargaison.id.toString()
        ..fields['telephone'] = telephone
        ..fields['qte'] = quantite.toString()
        ..fields['address'] = adresse
        ..fields['sup'] = superviseur
        ..fields['city'] = city.id.toString()
        ..fields['pay'] = pay.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateMarch(
      String marchandise,
      String date_debut,
      String date_fin,
      String name,
      String telephone,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      int quantite,
      CargaisonClient cargaison_client) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/marchandise/update/${cargaison_client.id}";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = marchandise
        ..fields['cl_name'] = name
        ..fields['telephone'] = telephone
        ..fields['qte'] = quantite.toString()
        ..fields['dep'] = date_debut
        ..fields['liv'] = date_fin
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateTransp(
      String name,
      String permis,
      String telephone,
      String imm,
      Pays pay_dep,
      Villes city_dep,
      Pays pay_liv,
      Villes city_liv,
      double tarif,
      double accompte,
      ChargementEffectue chargement_effectue) async {
    try {
      String? token = await secure.readSecureData('token');
      var url =
          "${api_url}home/expediteur/import/transporteur/update/${chargement_effectue.id}";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'API-KEY': api_key,
          'AUTH-TOKEN': auth_token,
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name
        ..fields['permis'] = permis
        ..fields['telephone'] = telephone
        ..fields['imm'] = imm
        ..fields['accompte'] = accompte.toString()
        ..fields['tarif'] = tarif.toString()
        ..fields['city_dep'] = city_dep.id.toString()
        ..fields['pay_dep'] = pay_dep.id.toString()
        ..fields['city_liv'] = city_liv.id.toString()
        ..fields['pay_liv'] = pay_liv.id.toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateMarchandise(
      String date_chargement,
      String nom,
      Unites unite,
      double poids,
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

      return response.statusCode.toString();
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

      return response.statusCode.toString();
    } catch (e) {
      return "202";
    }
  }

  Future<String> deleteChargementEffectue(
      ChargementEffectue chargement_effectue) async {
    try {
      var url =
          "${api_url}home/expediteur/import/transporteur/delete/${chargement_effectue.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> deleteLiv(LivraisonCargaison livraison) async {
    try {
      var url =
          "${api_url}home/expediteur/import/livraison/delete/${livraison.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

  Future<String> deleteCargaisonClient(CargaisonClient cargaison_client) async {
    try {
      var url =
          "${api_url}home/expediteur/import/marchandise/delete/${cargaison_client.id}";
      final uri = Uri.parse(url);
      String? token = await secure.readSecureData('token');

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

      return response.statusCode.toString();
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

      return response.statusCode.toString();
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

      return response.statusCode.toString();
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

      return response.statusCode.toString();
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
      ProvValiAccount provider,
      ApiProvider api_provider) async {
    try {
      var url = "${api_url}register";
      final uri = Uri.parse(url);
      final response = await http.post(uri, headers: {
        'API-KEY': api_key,
        'AUTH-TOKEN': auth_token
      }, body: {
        'name': nom,
        'phone_number': number,
        'statut': statut.id.toString(), // Convertir en String
        'role': rule.id.toString(), // Convertir en String
        'city': ville.id.toString(), // Convertir en String
        'country': pay.id.toString(), // Convertir en String
        'password': password,
        'confirm_password': confirm_password
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String token = data['token'];

        await secure.writeSecureData('token', token);

        if (data['user'] is Map<String, dynamic>) {
          // Récupération du user dans la réponse (sous forme de Map)
          Map<String, dynamic> userMap = data['user'];

          // Création d'une instance de la classe User à partir de la Map
          Users user = Users.fromMap(userMap);

          // Mise à jour de l'état global via le provider avec l'utilisateur connecté
          api_provider.setUser(user);
          provider.change_user(user);

          // Stockage de l'utilisateur dans SecureStorage sous forme de chaîne JSON
          await secure.writeSecureData('user', jsonEncode(userMap));
        }

        if (data['rule'] is Map<String, dynamic>) {
          // Récupération du user dans la réponse (sous forme de Map)
          Map<String, dynamic> ruleMap = data['rule'];

          // Création d'une instance de la classe User à partir de la Map
          Rules rule = Rules.fromMap(ruleMap);

          // Mise à jour de l'état global via le provider avec l'utilisateur connecté
          api_provider.setRule(rule);

          // Stockage de l'utilisateur dans SecureStorage sous forme de chaîne JSON
          await secure.writeSecureData('rule', jsonEncode(ruleMap));
        }
      }

      return response.statusCode.toString();
    } catch (e) {
      return "502";
    }
  }

  Future<String> login(
      String number, String password, ApiProvider provider) async {
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

        if (data['user'] is Map<String, dynamic>) {
          // Récupération du user dans la réponse (sous forme de Map)
          Map<String, dynamic> userMap = data['user'];

          // Création d'une instance de la classe User à partir de la Map
          Users user = Users.fromMap(userMap);

          // Mise à jour de l'état global via le provider avec l'utilisateur connecté
          provider.setUser(user);

          // Stockage de l'utilisateur dans SecureStorage sous forme de chaîne JSON
          await secure.writeSecureData('user', jsonEncode(userMap));
        }

        if (data['rule'] is Map<String, dynamic>) {
          // Récupération du user dans la réponse (sous forme de Map)
          Map<String, dynamic> ruleMap = data['rule'];

          // Création d'une instance de la classe User à partir de la Map
          Rules rule = Rules.fromMap(ruleMap);

          // Mise à jour de l'état global via le provider avec l'utilisateur connecté
          provider.setRule(rule);

          // Stockage de l'utilisateur dans SecureStorage sous forme de chaîne JSON
          await secure.writeSecureData('rule', jsonEncode(ruleMap));
        }
      }

      return response.statusCode.toString();
    } catch (e) {
      return "204";
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
