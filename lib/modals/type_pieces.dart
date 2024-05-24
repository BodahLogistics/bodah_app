// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TypePieces {
  final int id;
  final String nom;
  TypePieces({
    required this.id,
    required this.nom,
  });

  TypePieces copyWith({
    int? id,
    String? nom,
  }) {
    return TypePieces(
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

  factory TypePieces.fromMap(Map<String, dynamic> map) {
    return TypePieces(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypePieces.fromJson(String source) =>
      TypePieces.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TypePieces(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant TypePieces other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}
