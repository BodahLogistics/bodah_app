// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransportMode {
  final int id;
  final String nom;
  TransportMode({
    required this.id,
    required this.nom,
  });

  TransportMode copyWith({
    int? id,
    String? nom,
  }) {
    return TransportMode(
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

  factory TransportMode.fromMap(Map<String, dynamic> map) {
    return TransportMode(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportMode.fromJson(String source) =>
      TransportMode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TransportMode(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant TransportMode other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}
