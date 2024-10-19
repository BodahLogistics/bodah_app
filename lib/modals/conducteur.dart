// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Conducteur {
  int id;
  String reference;
  String nom;
  String telephone;
  int country_id;

  Conducteur({
    required this.id,
    required this.reference,
    required this.nom,
    required this.telephone,
    required this.country_id,
  });

  Conducteur copyWith({
    int? id,
    String? reference,
    String? nom,
    String? telephone,
    int? country_id,
  }) {
    return Conducteur(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      nom: nom ?? this.nom,
      telephone: telephone ?? this.telephone,
      country_id: country_id ?? this.country_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'nom': nom,
      'telephone': telephone,
      'country_id': country_id,
    };
  }

  factory Conducteur.fromMap(Map<String, dynamic> map) {
    return Conducteur(
      id: map['id'] as int,
      reference: map['reference'] as String,
      nom: map['nom'] as String,
      telephone: map['telephone'] as String,
      country_id: map['country_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conducteur.fromJson(String source) =>
      Conducteur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conducteur(id: $id, reference: $reference, nom: $nom, telephone: $telephone, country_id: $country_id)';
  }

  @override
  bool operator ==(covariant Conducteur other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.nom == nom &&
        other.telephone == telephone &&
        other.country_id == country_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        nom.hashCode ^
        telephone.hashCode ^
        country_id.hashCode;
  }
}
