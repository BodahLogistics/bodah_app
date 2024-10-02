// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Tarifications {
  int id;
  int marchandise_id;
  double prix_expedition;
  String prix_transport;
  String tarif_unitaire;

  Tarifications({
    required this.id,
    required this.marchandise_id,
    required this.prix_expedition,
    required this.prix_transport,
    required this.tarif_unitaire,
  });

  Tarifications copyWith({
    int? id,
    int? marchandise_id,
    double? prix_expedition,
    String? prix_transport,
    String? tarif_unitaire,
  }) {
    return Tarifications(
      id: id ?? this.id,
      marchandise_id: marchandise_id ?? this.marchandise_id,
      prix_expedition: prix_expedition ?? this.prix_expedition,
      prix_transport: prix_transport ?? this.prix_transport,
      tarif_unitaire: tarif_unitaire ?? this.tarif_unitaire,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'marchandise_id': marchandise_id,
      'prix_expedition': prix_expedition,
      'prix_transport': prix_transport,
      'tarif_unitaire': tarif_unitaire,
    };
  }

  factory Tarifications.fromMap(Map<String, dynamic> map) {
    return Tarifications(
      id: map['id'] as int,
      marchandise_id: map['marchandise_id'] as int,
      prix_expedition: map['prix_expedition'] as double,
      prix_transport: map['prix_transport'] as String,
      tarif_unitaire: map['tarif_unitaire'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tarifications.fromJson(String source) =>
      Tarifications.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tarifications(id: $id, marchandise_id: $marchandise_id, prix_expedition: $prix_expedition, prix_transport: $prix_transport, tarif_unitaire: $tarif_unitaire)';
  }

  @override
  bool operator ==(covariant Tarifications other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.marchandise_id == marchandise_id &&
        other.prix_expedition == prix_expedition &&
        other.prix_transport == prix_transport &&
        other.tarif_unitaire == tarif_unitaire;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        marchandise_id.hashCode ^
        prix_expedition.hashCode ^
        prix_transport.hashCode ^
        tarif_unitaire.hashCode;
  }
}
