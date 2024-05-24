// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Arrondissements {
  final int id;
  final String nom;
  final int commune_id;
  Arrondissements({
    required this.id,
    required this.nom,
    required this.commune_id,
  });

  Arrondissements copyWith({
    int? id,
    String? nom,
    int? commune_id,
  }) {
    return Arrondissements(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      commune_id: commune_id ?? this.commune_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nom': nom,
      'commune_id': commune_id,
    };
  }

  factory Arrondissements.fromMap(Map<String, dynamic> map) {
    return Arrondissements(
      id: map['id'] as int,
      nom: map['nom'] as String,
      commune_id: map['commune_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Arrondissements.fromJson(String source) =>
      Arrondissements.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Arrondissements(id: $id, nom: $nom, commune_id: $commune_id)';

  @override
  bool operator ==(covariant Arrondissements other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom && other.commune_id == commune_id;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode ^ commune_id.hashCode;
}
