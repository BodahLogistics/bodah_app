// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class AnnonceColis {
  final int id;
  final String reference;
  final int user_id;
  final int expediteur_id;
  final int deleted;
  final DateTime created_at;
  final DateTime updated_at;
  AnnonceColis({
    required this.id,
    required this.reference,
    required this.user_id,
    required this.expediteur_id,
    required this.deleted,
    required this.created_at,
    required this.updated_at,
  });

  AnnonceColis copyWith({
    int? id,
    String? reference,
    int? user_id,
    int? expediteur_id,
    int? deleted,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return AnnonceColis(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      user_id: user_id ?? this.user_id,
      expediteur_id: expediteur_id ?? this.expediteur_id,
      deleted: deleted ?? this.deleted,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'user_id': user_id,
      'expediteur_id': expediteur_id,
      'deleted': deleted,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory AnnonceColis.fromMap(Map<String, dynamic> map) {
    return AnnonceColis(
      id: map['id'] as int,
      reference: map['reference'] as String,
      user_id: map['user_id'] as int,
      expediteur_id: map['expediteur_id'] as int,
      deleted: map['deleted'] as int,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnonceColis.fromJson(String source) =>
      AnnonceColis.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnnonceColis(id: $id, reference: $reference, user_id: $user_id, expediteur_id: $expediteur_id, deleted: $deleted, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant AnnonceColis other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.user_id == user_id &&
        other.expediteur_id == expediteur_id &&
        other.deleted == deleted &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        user_id.hashCode ^
        expediteur_id.hashCode ^
        deleted.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
