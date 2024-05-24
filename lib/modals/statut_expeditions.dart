// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StatutExpeditions {
  final int id;
  final String nom;
  StatutExpeditions({
    required this.id,
    required this.nom,
  });

  StatutExpeditions copyWith({
    int? id,
    String? nom,
  }) {
    return StatutExpeditions(
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

  factory StatutExpeditions.fromMap(Map<String, dynamic> map) {
    return StatutExpeditions(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatutExpeditions.fromJson(String source) =>
      StatutExpeditions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StatutExpeditions(id: $id, nom: $nom)';

  @override
  bool operator ==(covariant StatutExpeditions other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nom == nom;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode;
}
