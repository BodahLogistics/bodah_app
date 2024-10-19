// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Expediteurs {
  int id;
  int user_id;
  String numero_expediteur;

  Expediteurs({
    required this.id,
    required this.user_id,
    required this.numero_expediteur,
  });

  Expediteurs copyWith({
    int? id,
    int? user_id,
    String? numero_expediteur,
  }) {
    return Expediteurs(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      numero_expediteur: numero_expediteur ?? this.numero_expediteur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'numero_expediteur': numero_expediteur,
    };
  }

  factory Expediteurs.fromMap(Map<String, dynamic> map) {
    return Expediteurs(
      id: map['id'] as int,
      user_id: map['user_id'] as int,
      numero_expediteur: map['numero_expediteur'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expediteurs.fromJson(String source) =>
      Expediteurs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Expediteurs(id: $id, user_id: $user_id, numero_expediteur: $numero_expediteur)';

  @override
  bool operator ==(covariant Expediteurs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.numero_expediteur == numero_expediteur;
  }

  @override
  int get hashCode =>
      id.hashCode ^ user_id.hashCode ^ numero_expediteur.hashCode;
}
