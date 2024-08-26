// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Conducteur {
  final int id;
  final String reference;
  final String nom;
  final String telephone;
  final int country_id;
  final int deleted;
  Conducteur({
    required this.id,
    required this.reference,
    required this.nom,
    required this.telephone,
    required this.country_id,
    required this.deleted,
  });

  Conducteur copyWith({
    int? id,
    String? reference,
    String? nom,
    String? telephone,
    int? country_id,
    int? deleted,
  }) {
    return Conducteur(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      nom: nom ?? this.nom,
      telephone: telephone ?? this.telephone,
      country_id: country_id ?? this.country_id,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'nom': nom,
      'telephone': telephone,
      'country_id': country_id,
      'deleted': deleted,
    };
  }

  factory Conducteur.fromMap(Map<String, dynamic> map) {
    return Conducteur(
      id: map['id'] as int,
      reference: map['reference'] as String,
      nom: map['nom'] as String,
      telephone: map['telephone'] as String,
      country_id: map['country_id'] as int,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conducteur.fromJson(String source) =>
      Conducteur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conducteur(id: $id, reference: $reference, nom: $nom, telephone: $telephone, country_id: $country_id, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Conducteur other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.nom == nom &&
        other.telephone == telephone &&
        other.country_id == country_id &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        nom.hashCode ^
        telephone.hashCode ^
        country_id.hashCode ^
        deleted.hashCode;
  }
}
