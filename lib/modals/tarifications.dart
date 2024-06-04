// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Tarifications {
  final int id;
  final int marchandise_id;
  final double prix_expedition;
  final double prix_transport;
  final int? unite_tarif_id;

  Tarifications({
    required this.id,
    required this.marchandise_id,
    required this.prix_expedition,
    required this.prix_transport,
    this.unite_tarif_id,
  });

  Tarifications copyWith({
    int? id,
    int? marchandise_id,
    double? prix_expedition,
    double? prix_transport,
    int? unite_tarif_id,
  }) {
    return Tarifications(
      id: id ?? this.id,
      marchandise_id: marchandise_id ?? this.marchandise_id,
      prix_expedition: prix_expedition ?? this.prix_expedition,
      prix_transport: prix_transport ?? this.prix_transport,
      unite_tarif_id: unite_tarif_id ?? this.unite_tarif_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'marchandise_id': marchandise_id,
      'prix_expedition': prix_expedition,
      'prix_transport': prix_transport,
      'unite_tarif_id': unite_tarif_id,
    };
  }

  factory Tarifications.fromMap(Map<String, dynamic> map) {
    return Tarifications(
      id: map['id'] as int,
      marchandise_id: map['marchandise_id'] as int,
      prix_expedition: map['prix_expedition'] is String
          ? double.parse(map['prix_expedition'])
          : map['prix_expedition'] as double,
      prix_transport: map['prix_transport'] is String
          ? double.parse(map['prix_transport'])
          : map['prix_transport'] as double,
      unite_tarif_id:
          map['unite_tarif_id'] != null ? map['unite_tarif_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tarifications.fromJson(String source) =>
      Tarifications.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tarifications(id: $id, marchandise_id: $marchandise_id, prix_expedition: $prix_expedition, prix_transport: $prix_transport, unite_tarif_id: $unite_tarif_id)';
  }

  @override
  bool operator ==(covariant Tarifications other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.marchandise_id == marchandise_id &&
        other.prix_expedition == prix_expedition &&
        other.prix_transport == prix_transport &&
        other.unite_tarif_id == unite_tarif_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        marchandise_id.hashCode ^
        prix_expedition.hashCode ^
        prix_transport.hashCode ^
        unite_tarif_id.hashCode;
  }
}
