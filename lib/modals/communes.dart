// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Communes {
  final int id;
  final String nom;
  final int departement_id;
  Communes({
    required this.id,
    required this.nom,
    required this.departement_id,
  });

  Communes copyWith({
    int? id,
    String? nom,
    int? departement_id,
  }) {
    return Communes(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      departement_id: departement_id ?? this.departement_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nom': nom,
      'departement_id': departement_id,
    };
  }

  factory Communes.fromMap(Map<String, dynamic> map) {
    return Communes(
      id: map['id'] as int,
      nom: map['nom'] as String,
      departement_id: map['departement_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Communes.fromJson(String source) =>
      Communes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Communes(id: $id, nom: $nom, departement_id: $departement_id)';

  @override
  bool operator ==(covariant Communes other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nom == nom &&
        other.departement_id == departement_id;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode ^ departement_id.hashCode;
}
