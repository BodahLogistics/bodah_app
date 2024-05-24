// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Devises {
  final int id;
  final String nom;
  Devises({
    required this.id,
    required this.nom,
  });

  Devises copyWith({
    int? id,
    String? nom,
  }) {
    return Devises(
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

  factory Devises.fromMap(Map<String, dynamic> map) {
    return Devises(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Devises.fromJson(String source) =>
      Devises.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Devises(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant Devises other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}
