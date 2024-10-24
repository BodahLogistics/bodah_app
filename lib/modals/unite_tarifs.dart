// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UniteTarifs {
  final int id;
  final String nom;
  UniteTarifs({
    required this.id,
    required this.nom,
  });

  UniteTarifs copyWith({
    int? id,
    String? nom,
  }) {
    return UniteTarifs(
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

  factory UniteTarifs.fromMap(Map<String, dynamic> map) {
    return UniteTarifs(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UniteTarifs.fromJson(String source) =>
      UniteTarifs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UniteTarifs(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant UniteTarifs other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}
