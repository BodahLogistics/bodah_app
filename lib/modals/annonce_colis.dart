// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class AnnonceColis {
  int id;
  String reference;
  int user_id;
  int expediteur_id;

  AnnonceColis({
    required this.id,
    required this.reference,
    required this.user_id,
    required this.expediteur_id,
  });

  AnnonceColis copyWith({
    int? id,
    String? reference,
    int? user_id,
    int? expediteur_id,
  }) {
    return AnnonceColis(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      user_id: user_id ?? this.user_id,
      expediteur_id: expediteur_id ?? this.expediteur_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'user_id': user_id,
      'expediteur_id': expediteur_id,
    };
  }

  factory AnnonceColis.fromMap(Map<String, dynamic> map) {
    return AnnonceColis(
      id: map['id'] as int,
      reference: map['reference'] as String,
      user_id: map['user_id'] as int,
      expediteur_id: map['expediteur_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnonceColis.fromJson(String source) =>
      AnnonceColis.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnnonceColis(id: $id, reference: $reference, user_id: $user_id, expediteur_id: $expediteur_id)';
  }

  @override
  bool operator ==(covariant AnnonceColis other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.user_id == user_id &&
        other.expediteur_id == expediteur_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        user_id.hashCode ^
        expediteur_id.hashCode;
  }
}
