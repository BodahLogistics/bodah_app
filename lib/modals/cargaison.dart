// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Cargaison {
  int id;
  String reference;
  String? ref;
  String modele_type;
  int modele_id;
  String nom;

  Cargaison({
    required this.id,
    required this.reference,
    this.ref,
    required this.modele_type,
    required this.modele_id,
    required this.nom,
  });

  Cargaison copyWith({
    int? id,
    String? reference,
    String? ref,
    String? modele_type,
    int? modele_id,
    String? nom,
  }) {
    return Cargaison(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      ref: ref ?? this.ref,
      modele_type: modele_type ?? this.modele_type,
      modele_id: modele_id ?? this.modele_id,
      nom: nom ?? this.nom,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'ref': ref,
      'modele_type': modele_type,
      'modele_id': modele_id,
      'nom': nom,
    };
  }

  factory Cargaison.fromMap(Map<String, dynamic> map) {
    return Cargaison(
      id: map['id'] != null
          ? (map['id'] is String ? int.parse(map['id']) : map['id'] as int)
          : 0,
      reference: map['reference'] != null ? map['reference'] as String : '',
      ref: map['ref'] != null ? map['ref'] as String : null,
      modele_type:
          map['modele_type'] != null ? map['modele_type'] as String : '',
      modele_id: map['modele_id'] != null
          ? (map['modele_id'] is String
              ? int.parse(map['modele_id'])
              : map['modele_id'] as int)
          : 0,
      nom: map['nom'] != null ? map['nom'] as String : '',
    );
  }
  String toJson() => json.encode(toMap());

  factory Cargaison.fromJson(String source) =>
      Cargaison.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cargaison(id: $id, reference: $reference, ref: $ref, modele_type: $modele_type, modele_id: $modele_id, nom: $nom)';
  }

  @override
  bool operator ==(covariant Cargaison other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.ref == ref &&
        other.modele_type == modele_type &&
        other.modele_id == modele_id &&
        other.nom == nom;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        ref.hashCode ^
        modele_type.hashCode ^
        modele_id.hashCode ^
        nom.hashCode;
  }
}
