// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Quartiers {
  final int id;
  final String nom;
  final int arrondissement_id;
  Quartiers({
    required this.id,
    required this.nom,
    required this.arrondissement_id,
  });

  Quartiers copyWith({
    int? id,
    String? nom,
    int? arrondissement_id,
  }) {
    return Quartiers(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      arrondissement_id: arrondissement_id ?? this.arrondissement_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nom': nom,
      'arrondissement_id': arrondissement_id,
    };
  }

  factory Quartiers.fromMap(Map<String, dynamic> map) {
    return Quartiers(
      id: map['id'] as int,
      nom: map['nom'] as String,
      arrondissement_id: map['arrondissement_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quartiers.fromJson(String source) =>
      Quartiers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Quartiers(id: $id, nom: $nom, arrondissement_id: $arrondissement_id)';

  @override
  bool operator ==(covariant Quartiers other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nom == nom &&
        other.arrondissement_id == arrondissement_id;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode ^ arrondissement_id.hashCode;
}
