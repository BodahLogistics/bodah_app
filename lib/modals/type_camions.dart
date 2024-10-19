// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TypeCamions {
  int id;
  String nom;
  TypeCamions({
    required this.id,
    required this.nom,
  });

  TypeCamions copyWith({
    int? id,
    String? nom,
  }) {
    return TypeCamions(
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

  factory TypeCamions.fromMap(Map<String, dynamic> map) {
    return TypeCamions(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeCamions.fromJson(String source) =>
      TypeCamions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TypeCamions(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant TypeCamions other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}
