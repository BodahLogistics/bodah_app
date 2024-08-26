// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Cargaison {
  final int id;
  final String reference;
  final String? ref;
  final String modele_type;
  final int modele_id;
  final String nom;
  final int deleted;
  Cargaison({
    required this.id,
    required this.reference,
    this.ref,
    required this.modele_type,
    required this.modele_id,
    required this.nom,
    required this.deleted,
  });

  Cargaison copyWith({
    int? id,
    String? reference,
    String? ref,
    String? modele_type,
    int? modele_id,
    String? nom,
    int? deleted,
  }) {
    return Cargaison(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      ref: ref ?? this.ref,
      modele_type: modele_type ?? this.modele_type,
      modele_id: modele_id ?? this.modele_id,
      nom: nom ?? this.nom,
      deleted: deleted ?? this.deleted,
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
      'deleted': deleted,
    };
  }

  factory Cargaison.fromMap(Map<String, dynamic> map) {
    return Cargaison(
      id: map['id'] as int,
      reference: map['reference'] as String,
      ref: map['ref'] != null ? map['ref'] as String : null,
      modele_type: map['modele_type'] as String,
      modele_id: map['modele_id'] as int,
      nom: map['nom'] as String,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cargaison.fromJson(String source) =>
      Cargaison.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cargaison(id: $id, reference: $reference, ref: $ref, modele_type: $modele_type, modele_id: $modele_id, nom: $nom, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Cargaison other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.ref == ref &&
        other.modele_type == modele_type &&
        other.modele_id == modele_id &&
        other.nom == nom &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        ref.hashCode ^
        modele_type.hashCode ^
        modele_id.hashCode ^
        nom.hashCode ^
        deleted.hashCode;
  }
}
