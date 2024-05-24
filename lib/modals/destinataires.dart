// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Destinataires {
  final int id;
  final String numero_destinataire;
  final String? ifu;
  final int user_id;
  final int deleted;
  Destinataires({
    required this.id,
    required this.numero_destinataire,
    this.ifu,
    required this.user_id,
    required this.deleted,
  });

  Destinataires copyWith({
    int? id,
    String? numero_destinataire,
    String? ifu,
    int? user_id,
    int? deleted,
  }) {
    return Destinataires(
      id: id ?? this.id,
      numero_destinataire: numero_destinataire ?? this.numero_destinataire,
      ifu: ifu ?? this.ifu,
      user_id: user_id ?? this.user_id,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_destinataire': numero_destinataire,
      'ifu': ifu,
      'user_id': user_id,
      'deleted': deleted,
    };
  }

  factory Destinataires.fromMap(Map<String, dynamic> map) {
    return Destinataires(
      id: map['id'] as int,
      numero_destinataire: map['numero_destinataire'] as String,
      ifu: map['ifu'] != null ? map['ifu'] as String : null,
      user_id: map['user_id'] as int,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Destinataires.fromJson(String source) =>
      Destinataires.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Destinataires(id: $id, numero_destinataire: $numero_destinataire, ifu: $ifu, user_id: $user_id, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Destinataires other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_destinataire == numero_destinataire &&
        other.ifu == ifu &&
        other.user_id == user_id &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_destinataire.hashCode ^
        ifu.hashCode ^
        user_id.hashCode ^
        deleted.hashCode;
  }
}
