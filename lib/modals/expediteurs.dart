// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Expediteurs {
  final int id;
  final int user_id;
  final String numero_expediteur;
  final int deleted;
  Expediteurs({
    required this.id,
    required this.user_id,
    required this.numero_expediteur,
    required this.deleted,
  });

  Expediteurs copyWith({
    int? id,
    int? user_id,
    String? numero_expediteur,
    int? deleted,
  }) {
    return Expediteurs(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      numero_expediteur: numero_expediteur ?? this.numero_expediteur,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'numero_expediteur': numero_expediteur,
      'deleted': deleted,
    };
  }

  factory Expediteurs.fromMap(Map<String, dynamic> map) {
    return Expediteurs(
      id: map['id'] as int,
      user_id: map['user_id'] as int,
      numero_expediteur: map['numero_expediteur'] as String,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expediteurs.fromJson(String source) =>
      Expediteurs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expediteurs(id: $id, user_id: $user_id, numero_expediteur: $numero_expediteur, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Expediteurs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.numero_expediteur == numero_expediteur &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        numero_expediteur.hashCode ^
        deleted.hashCode;
  }
}
