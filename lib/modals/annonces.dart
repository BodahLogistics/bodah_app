// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Annonces {
  int id;
  String numero_annonce;
  int is_active;
  int user_id;
  int expediteur_id;
  String? numero_bl;
  DateTime created_at;

  Annonces({
    required this.id,
    required this.numero_annonce,
    required this.is_active,
    required this.user_id,
    required this.expediteur_id,
    this.numero_bl,
    required this.created_at,
  });

  Annonces copyWith({
    int? id,
    String? numero_annonce,
    int? is_active,
    int? user_id,
    int? expediteur_id,
    String? numero_bl,
    DateTime? created_at,
  }) {
    return Annonces(
      id: id ?? this.id,
      numero_annonce: numero_annonce ?? this.numero_annonce,
      is_active: is_active ?? this.is_active,
      user_id: user_id ?? this.user_id,
      expediteur_id: expediteur_id ?? this.expediteur_id,
      numero_bl: numero_bl ?? this.numero_bl,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_annonce': numero_annonce,
      'is_active': is_active,
      'user_id': user_id,
      'expediteur_id': expediteur_id,
      'numero_bl': numero_bl,
      'created_at': created_at.millisecondsSinceEpoch,
    };
  }

  factory Annonces.fromMap(Map<String, dynamic> map) {
    return Annonces(
      id: map['id'] != null ? map['id'] as int : 0, // Par défaut à 0 si null
      numero_annonce: map['numero_annonce'] as String,
      is_active: map['is_active'] != null
          ? map['is_active'] as int
          : 0, // Par défaut à 0 si null
      user_id: map['user_id'] != null
          ? map['user_id'] as int
          : 0, // Par défaut à 0 si null
      expediteur_id: map['expediteur_id'] != null
          ? map['expediteur_id'] as int
          : 0, // Par défaut à 0 si null
      numero_bl: map['numero_bl'] != null
          ? map['numero_bl'] as String
          : null, // Laisser null si absent
      created_at: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(), // Par défaut à la date actuelle si null
    );
  }

  String toJson() => json.encode(toMap());

  factory Annonces.fromJson(String source) =>
      Annonces.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Annonces(id: $id, numero_annonce: $numero_annonce, is_active: $is_active, user_id: $user_id, expediteur_id: $expediteur_id, numero_bl: $numero_bl, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant Annonces other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_annonce == numero_annonce &&
        other.is_active == is_active &&
        other.user_id == user_id &&
        other.expediteur_id == expediteur_id &&
        other.numero_bl == numero_bl &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_annonce.hashCode ^
        is_active.hashCode ^
        user_id.hashCode ^
        expediteur_id.hashCode ^
        numero_bl.hashCode ^
        created_at.hashCode;
  }
}
