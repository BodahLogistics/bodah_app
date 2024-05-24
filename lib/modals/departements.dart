// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Departements {
  final int id;
  final String nom;
  Departements({
    required this.id,
    required this.nom,
  });

  Departements copyWith({
    int? id,
    String? nom,
  }) {
    return Departements(
      id: id ?? this.id,
      nom: nom ?? this.nom,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nom': nom,
    };
  }

  factory Departements.fromMap(Map<String, dynamic> map) {
    return Departements(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Departements.fromJson(String source) =>
      Departements.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Departements(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant Departements other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}