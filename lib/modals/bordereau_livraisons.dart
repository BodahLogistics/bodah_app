// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class BordereauLivraisons {
  final int id;
  final String numero_borderau;
  final int expedition_id;
  final int? observation_id;
  final int? transp_sign_id;
  final int? dest_sign_id;
  final DateTime created_at;
  final DateTime updated_at;
  BordereauLivraisons({
    required this.id,
    required this.numero_borderau,
    required this.expedition_id,
    required this.observation_id,
    this.transp_sign_id,
    this.dest_sign_id,
    required this.created_at,
    required this.updated_at,
  });

  BordereauLivraisons copyWith({
    int? id,
    String? numero_borderau,
    int? expedition_id,
    int? observation_id,
    int? transp_sign_id,
    int? dest_sign_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return BordereauLivraisons(
      id: id ?? this.id,
      numero_borderau: numero_borderau ?? this.numero_borderau,
      expedition_id: expedition_id ?? this.expedition_id,
      observation_id: observation_id ?? this.observation_id,
      transp_sign_id: transp_sign_id ?? this.transp_sign_id,
      dest_sign_id: dest_sign_id ?? this.dest_sign_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_borderau': numero_borderau,
      'expedition_id': expedition_id,
      'observation_id': observation_id,
      'transp_sign_id': transp_sign_id,
      'dest_sign_id': dest_sign_id,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory BordereauLivraisons.fromMap(Map<String, dynamic> map) {
    return BordereauLivraisons(
      id: map['id'] as int,
      numero_borderau: map['numero_borderau'] as String,
      expedition_id: map['expedition_id'] as int,
      observation_id: map['observation_id'] != null ? map['observation_id'] as int : null,
      transp_sign_id: map['transp_sign_id'] != null ? map['transp_sign_id'] as int : null,
      dest_sign_id: map['dest_sign_id'] != null ? map['dest_sign_id'] as int : null,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BordereauLivraisons.fromJson(String source) =>
      BordereauLivraisons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BordereauLivraisons(id: $id, numero_borderau: $numero_borderau, expedition_id: $expedition_id, observation_id: $observation_id, transp_sign_id: $transp_sign_id, dest_sign_id: $dest_sign_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant BordereauLivraisons other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_borderau == numero_borderau &&
        other.expedition_id == expedition_id &&
        other.observation_id == observation_id &&
        other.transp_sign_id == transp_sign_id &&
        other.dest_sign_id == dest_sign_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_borderau.hashCode ^
        expedition_id.hashCode ^
        observation_id.hashCode ^
        transp_sign_id.hashCode ^
        dest_sign_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
