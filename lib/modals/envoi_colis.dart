// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class EnvoiColis {
  final int id;
  final String reference;
  final int coli_id;
  final int transporteur_id;
  final double? caution;
  EnvoiColis({
    required this.id,
    required this.reference,
    required this.coli_id,
    required this.transporteur_id,
    this.caution,
  });

  EnvoiColis copyWith({
    int? id,
    String? reference,
    int? coli_id,
    int? transporteur_id,
    double? caution,
  }) {
    return EnvoiColis(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      coli_id: coli_id ?? this.coli_id,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      caution: caution ?? this.caution,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'coli_id': coli_id,
      'transporteur_id': transporteur_id,
      'caution': caution,
    };
  }

  factory EnvoiColis.fromMap(Map<String, dynamic> map) {
    return EnvoiColis(
      id: map['id'] as int,
      reference: map['reference'] as String,
      coli_id: map['coli_id'] as int,
      transporteur_id: map['transporteur_id'] as int,
      caution: map['caution'] != null ? map['caution'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnvoiColis.fromJson(String source) =>
      EnvoiColis.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EnvoiColis(id: $id, reference: $reference, coli_id: $coli_id, transporteur_id: $transporteur_id, caution: $caution)';
  }

  @override
  bool operator ==(covariant EnvoiColis other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.coli_id == coli_id &&
        other.transporteur_id == transporteur_id &&
        other.caution == caution;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        coli_id.hashCode ^
        transporteur_id.hashCode ^
        caution.hashCode;
  }
}
