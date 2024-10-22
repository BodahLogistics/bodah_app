// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class BordereauLivraisons {
  int id;
  String numero_borderau;
  int expedition_id;
  int? transp_sign_id;
  String? representant;
  int? dest_sign_id;
  DateTime created_at;
  BordereauLivraisons({
    required this.id,
    required this.numero_borderau,
    required this.expedition_id,
    this.transp_sign_id,
    this.representant,
    this.dest_sign_id,
    required this.created_at,
  });

  BordereauLivraisons copyWith({
    int? id,
    String? numero_borderau,
    int? expedition_id,
    int? transp_sign_id,
    String? representant,
    int? dest_sign_id,
    DateTime? created_at,
  }) {
    return BordereauLivraisons(
      id: id ?? this.id,
      numero_borderau: numero_borderau ?? this.numero_borderau,
      expedition_id: expedition_id ?? this.expedition_id,
      transp_sign_id: transp_sign_id ?? this.transp_sign_id,
      representant: representant ?? this.representant,
      dest_sign_id: dest_sign_id ?? this.dest_sign_id,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_borderau': numero_borderau,
      'expedition_id': expedition_id,
      'transp_sign_id': transp_sign_id,
      'representant': representant,
      'dest_sign_id': dest_sign_id,
      'created_at': created_at.millisecondsSinceEpoch,
    };
  }

  factory BordereauLivraisons.fromMap(Map<String, dynamic> map) {
    return BordereauLivraisons(
      id: map['id'] as int,
      numero_borderau: map['numero_borderau'] as String,
      expedition_id: map['expedition_id'] as int,
      transp_sign_id:
          map['transp_sign_id'] != null ? map['transp_sign_id'] as int : null,
      representant:
          map['representant'] != null ? map['representant'] as String : null,
      dest_sign_id:
          map['dest_sign_id'] != null ? map['dest_sign_id'] as int : null,
      created_at: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory BordereauLivraisons.fromJson(String source) =>
      BordereauLivraisons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BordereauLivraisons(id: $id, numero_borderau: $numero_borderau, expedition_id: $expedition_id, transp_sign_id: $transp_sign_id, representant: $representant, dest_sign_id: $dest_sign_id, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant BordereauLivraisons other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_borderau == numero_borderau &&
        other.expedition_id == expedition_id &&
        other.transp_sign_id == transp_sign_id &&
        other.representant == representant &&
        other.dest_sign_id == dest_sign_id &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_borderau.hashCode ^
        expedition_id.hashCode ^
        transp_sign_id.hashCode ^
        representant.hashCode ^
        dest_sign_id.hashCode ^
        created_at.hashCode;
  }
}
