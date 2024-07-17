// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Voitures {
  final int id;
  final int transporteur_id;
  final String immatriculation;
  Voitures({
    required this.id,
    required this.transporteur_id,
    required this.immatriculation,
  });

  Voitures copyWith({
    int? id,
    int? transporteur_id,
    String? immatriculation,
  }) {
    return Voitures(
      id: id ?? this.id,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      immatriculation: immatriculation ?? this.immatriculation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'transporteur_id': transporteur_id,
      'immatriculation': immatriculation,
    };
  }

  factory Voitures.fromMap(Map<String, dynamic> map) {
    return Voitures(
      id: map['id'] as int,
      transporteur_id: map['transporteur_id'] as int,
      immatriculation: map['immatriculation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Voitures.fromJson(String source) =>
      Voitures.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Voitures(id: $id, transporteur_id: $transporteur_id, immatriculation: $immatriculation)';

  @override
  bool operator ==(covariant Voitures other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.transporteur_id == transporteur_id &&
        other.immatriculation == immatriculation;
  }

  @override
  int get hashCode =>
      id.hashCode ^ transporteur_id.hashCode ^ immatriculation.hashCode;
}
