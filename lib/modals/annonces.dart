// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Annonces {
  final int id;
  final String numero_annonce;
  final int is_active;
  final int user_id;
  final int deleted;
  final int expediteur_id;
  final String? numero_bl;
  final DateTime created_at;
  final DateTime updated_at;

  Annonces({
    required this.id,
    required this.numero_annonce,
    required this.is_active,
    required this.user_id,
    required this.deleted,
    required this.expediteur_id,
    this.numero_bl,
    required this.created_at,
    required this.updated_at,
  });

  Annonces copyWith({
    int? id,
    String? numero_annonce,
    int? is_active,
    int? user_id,
    int? deleted,
    int? expediteur_id,
    String? numero_bl,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Annonces(
      id: id ?? this.id,
      numero_annonce: numero_annonce ?? this.numero_annonce,
      is_active: is_active ?? this.is_active,
      user_id: user_id ?? this.user_id,
      deleted: deleted ?? this.deleted,
      expediteur_id: expediteur_id ?? this.expediteur_id,
      numero_bl: numero_bl ?? this.numero_bl,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_annonce': numero_annonce,
      'is_active': is_active,
      'user_id': user_id,
      'deleted': deleted,
      'expediteur_id': expediteur_id,
      'numero_bl': numero_bl,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }

  factory Annonces.fromMap(Map<String, dynamic> map) {
    return Annonces(
      id: map['id'] as int,
      numero_annonce: map['numero_annonce'] as String,
      is_active: map['is_active'] as int,
      user_id: map['user_id'] as int,
      deleted: map['deleted'] as int,
      expediteur_id: map['expediteur_id'] as int,
      numero_bl: map['numero_bl'] != null ? map['numero_bl'] as String : null,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Annonces.fromJson(String source) =>
      Annonces.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Annonces(id: $id, numero_annonce: $numero_annonce, is_active: $is_active, user_id: $user_id, deleted: $deleted, expediteur_id: $expediteur_id, numero_bl: $numero_bl, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Annonces other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_annonce == numero_annonce &&
        other.is_active == is_active &&
        other.user_id == user_id &&
        other.deleted == deleted &&
        other.expediteur_id == expediteur_id &&
        other.numero_bl == numero_bl &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_annonce.hashCode ^
        is_active.hashCode ^
        user_id.hashCode ^
        deleted.hashCode ^
        expediteur_id.hashCode ^
        numero_bl.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
