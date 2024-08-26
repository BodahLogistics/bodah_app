// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class LivraisonCargaison {
  final int id;
  final String reference;
  final int country_id;
  final int city_id;
  final String address;
  final int quantite;
  final int client_id;
  final int cargaison_id;
  final int deleted;
  final DateTime? date;
  final String modele_type;
  final int modele_id;
  LivraisonCargaison({
    required this.id,
    required this.reference,
    required this.country_id,
    required this.city_id,
    required this.address,
    required this.quantite,
    required this.client_id,
    required this.cargaison_id,
    required this.deleted,
    this.date,
    required this.modele_type,
    required this.modele_id,
  });

  LivraisonCargaison copyWith({
    int? id,
    String? reference,
    int? country_id,
    int? city_id,
    String? address,
    int? quantite,
    int? client_id,
    int? cargaison_id,
    int? deleted,
    DateTime? date,
    String? modele_type,
    int? modele_id,
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
      deleted: deleted ?? this.deleted,
      date: date ?? this.date,
      modele_type: modele_type ?? this.modele_type,
      modele_id: modele_id ?? this.modele_id,
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
      'deleted': deleted,
      'date': date?.millisecondsSinceEpoch,
      'modele_type': modele_type,
      'modele_id': modele_id,
    };
  }

  factory LivraisonCargaison.fromMap(Map<String, dynamic> map) {
    return LivraisonCargaison(
      id: map['id'] as int,
      reference: map['reference'] as String,
      country_id: map['country_id'] as int,
      city_id: map['city_id'] as int,
      address: map['address'] as String,
      quantite: map['quantite'] as int,
      client_id: map['client_id'] as int,
      cargaison_id: map['cargaison_id'] as int,
      deleted: map['deleted'] as int,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      modele_type: map['modele_type'] as String,
      modele_id: map['modele_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LivraisonCargaison.fromJson(String source) =>
      LivraisonCargaison.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LivraisonCargaison(id: $id, reference: $reference, country_id: $country_id, city_id: $city_id, address: $address, quantite: $quantite, client_id: $client_id, cargaison_id: $cargaison_id, deleted: $deleted, date: $date, modele_type: $modele_type, modele_id: $modele_id)';
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
        other.deleted == deleted &&
        other.date == date &&
        other.modele_type == modele_type &&
        other.modele_id == modele_id;
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
        deleted.hashCode ^
        date.hashCode ^
        modele_type.hashCode ^
        modele_id.hashCode;
  }
}
