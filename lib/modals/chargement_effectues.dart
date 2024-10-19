// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class ChargementEffectue {
  int id;
  String reference;
  DateTime? debut;
  DateTime? fin;
  int modele_id;
  String modele_type;
  int vehicule_id;
  int conducteur_id;
  ChargementEffectue({
    required this.id,
    required this.reference,
    this.debut,
    this.fin,
    required this.modele_id,
    required this.modele_type,
    required this.vehicule_id,
    required this.conducteur_id,
  });

  ChargementEffectue copyWith({
    int? id,
    String? reference,
    DateTime? debut,
    DateTime? fin,
    int? modele_id,
    String? modele_type,
    int? vehicule_id,
    int? conducteur_id,
  }) {
    return ChargementEffectue(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      debut: debut ?? this.debut,
      fin: fin ?? this.fin,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      vehicule_id: vehicule_id ?? this.vehicule_id,
      conducteur_id: conducteur_id ?? this.conducteur_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'debut': debut?.millisecondsSinceEpoch,
      'fin': fin?.millisecondsSinceEpoch,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'vehicule_id': vehicule_id,
      'conducteur_id': conducteur_id,
    };
  }

  factory ChargementEffectue.fromMap(Map<String, dynamic> map) {
    return ChargementEffectue(
      id: map['id'] is String ? int.parse(map['id']) : map['id'] as int,
      reference: map['reference'] as String,
      fin: map['fin'] != null ? DateTime.parse(map['fin'] as String) : null,
      debut:
          map['debut'] != null ? DateTime.parse(map['debut'] as String) : null,
      modele_id: map['modele_id'] is String
          ? int.parse(map['modele_id'])
          : map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      vehicule_id: map['vehicule_id'] is String
          ? int.parse(map['vehicule_id'])
          : map['vehicule_id'] as int,
      conducteur_id: map['conducteur_id'] is String
          ? int.parse(map['conducteur_id'])
          : map['conducteur_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChargementEffectue.fromJson(String source) =>
      ChargementEffectue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChargementEffectue(id: $id, reference: $reference, debut: $debut, fin: $fin, modele_id: $modele_id, modele_type: $modele_type, vehicule_id: $vehicule_id, conducteur_id: $conducteur_id)';
  }

  @override
  bool operator ==(covariant ChargementEffectue other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.debut == debut &&
        other.fin == fin &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.vehicule_id == vehicule_id &&
        other.conducteur_id == conducteur_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        debut.hashCode ^
        fin.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        vehicule_id.hashCode ^
        conducteur_id.hashCode;
  }
}
