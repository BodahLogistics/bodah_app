// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rules {
  final int id;
  final String nom;
  Rules({
    required this.id,
    required this.nom,
  });

  Rules copyWith({
    int? id,
    String? nom,
  }) {
    return Rules(
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

  factory Rules.fromMap(Map<String, dynamic> map) {
    return Rules(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rules.fromJson(String source) =>
      Rules.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Rules(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant Rules other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}
