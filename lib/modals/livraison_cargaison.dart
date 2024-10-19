// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LivraisonCargaison {
  int id;
  String reference;
  int country_id;
  int city_id;
  String address;
  int quantite;
  int client_id;
  int cargaison_id;
  String modele_type;
  int modele_id;
  String? superviseur;

  LivraisonCargaison({
    required this.id,
    required this.reference,
    required this.country_id,
    required this.city_id,
    required this.address,
    required this.quantite,
    required this.client_id,
    required this.cargaison_id,
    required this.modele_type,
    required this.modele_id,
    this.superviseur,
  });

  factory LivraisonCargaison.fromMap(Map<String, dynamic> map) {
    // Méthode pour convertir un champ en entier en prenant en charge les chaînes de caractères
    int parseInt(dynamic value) {
      if (value is String) {
        return int.tryParse(value) ?? 0; // Retourner 0 si la conversion échoue
      }
      return value as int;
    }

    return LivraisonCargaison(
      id: parseInt(map['id']),
      reference: map['reference'] as String,
      country_id: parseInt(map['country_id']),
      city_id: parseInt(map['city_id']),
      address: map['address'] as String,
      quantite: parseInt(map['quantite']),
      client_id: parseInt(map['client_id']),
      cargaison_id: parseInt(map['cargaison_id']),
      modele_type: map['modele_type'] as String,
      modele_id: parseInt(map['modele_id']),
      superviseur:
          map['superviseur'] != null ? map['superviseur'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'country_id': country_id,
      'city_id': city_id,
      'address': address,
      'quantite': quantite,
      'client_id': client_id,
      'cargaison_id': cargaison_id,
      'modele_type': modele_type,
      'modele_id': modele_id,
      'superviseur': superviseur,
    };
  }

  String toJson() => json.encode(toMap());

  factory LivraisonCargaison.fromJson(String source) =>
      LivraisonCargaison.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LivraisonCargaison(id: $id, reference: $reference, country_id: $country_id, city_id: $city_id, address: $address, quantite: $quantite, client_id: $client_id, cargaison_id: $cargaison_id, modele_type: $modele_type, modele_id: $modele_id, superviseur: $superviseur)';
  }

  @override
  bool operator ==(covariant LivraisonCargaison other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.country_id == country_id &&
        other.city_id == city_id &&
        other.address == address &&
        other.quantite == quantite &&
        other.client_id == client_id &&
        other.cargaison_id == cargaison_id &&
        other.modele_type == modele_type &&
        other.modele_id == modele_id &&
        other.superviseur == superviseur;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        country_id.hashCode ^
        city_id.hashCode ^
        address.hashCode ^
        quantite.hashCode ^
        client_id.hashCode ^
        cargaison_id.hashCode ^
        modele_type.hashCode ^
        modele_id.hashCode ^
        superviseur.hashCode;
  }

  LivraisonCargaison copyWith({
    int? id,
    String? reference,
    int? country_id,
    int? city_id,
    String? address,
    int? quantite,
    int? client_id,
    int? cargaison_id,
    String? modele_type,
    int? modele_id,
    String? superviseur,
  }) {
    return LivraisonCargaison(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      country_id: country_id ?? this.country_id,
      city_id: city_id ?? this.city_id,
      address: address ?? this.address,
      quantite: quantite ?? this.quantite,
      client_id: client_id ?? this.client_id,
      cargaison_id: cargaison_id ?? this.cargaison_id,
      modele_type: modele_type ?? this.modele_type,
      modele_id: modele_id ?? this.modele_id,
      superviseur: superviseur ?? this.superviseur,
    );
  }
}
