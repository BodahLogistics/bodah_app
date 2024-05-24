// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Notifications {
  final int id;
  final String nom;
  final int user_id;
  final int modele_id;
  final String modle_type;
  final int readed;
  final int deleted;
  Notifications({
    required this.id,
    required this.nom,
    required this.user_id,
    required this.modele_id,
    required this.modle_type,
    required this.readed,
    required this.deleted,
  });

  Notifications copyWith({
    int? id,
    String? nom,
    int? user_id,
    int? modele_id,
    String? modle_type,
    int? readed,
    int? deleted,
  }) {
    return Notifications(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      user_id: user_id ?? this.user_id,
      modele_id: modele_id ?? this.modele_id,
      modle_type: modle_type ?? this.modle_type,
      readed: readed ?? this.readed,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nom': nom,
      'user_id': user_id,
      'modele_id': modele_id,
      'modle_type': modle_type,
      'readed': readed,
      'deleted': deleted,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      id: map['id'] as int,
      nom: map['nom'] as String,
      user_id: map['user_id'] as int,
      modele_id: map['modele_id'] as int,
      modle_type: map['modle_type'] as String,
      readed: map['readed'] as int,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(String source) =>
      Notifications.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notifications(id: $id, nom: $nom, user_id: $user_id, modele_id: $modele_id, modle_type: $modle_type, readed: $readed, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Notifications other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nom == nom &&
        other.user_id == user_id &&
        other.modele_id == modele_id &&
        other.modle_type == modle_type &&
        other.readed == readed &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        user_id.hashCode ^
        modele_id.hashCode ^
        modle_type.hashCode ^
        readed.hashCode ^
        deleted.hashCode;
  }
}
