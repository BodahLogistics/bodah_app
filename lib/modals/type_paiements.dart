// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TypePaiements {
  int id;
  String nom;
  TypePaiements({
    required this.id,
    required this.nom,
  });

  TypePaiements copyWith({
    int? id,
    String? nom,
  }) {
    return TypePaiements(
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

  factory TypePaiements.fromMap(Map<String, dynamic> map) {
    return TypePaiements(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypePaiements.fromJson(String source) =>
      TypePaiements.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TypePaiements(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant TypePaiements other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}
