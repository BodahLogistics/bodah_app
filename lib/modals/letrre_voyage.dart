// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class LetreVoitures {
  int id;
  int expedition_id;
  String reference;
  int? signature_id;
  DateTime created_at;

  LetreVoitures({
    required this.id,
    required this.expedition_id,
    required this.reference,
    this.signature_id,
    required this.created_at,
  });

  LetreVoitures copyWith({
    int? id,
    int? expedition_id,
    String? reference,
    int? signature_id,
    DateTime? created_at,
  }) {
    return LetreVoitures(
      id: id ?? this.id,
      expedition_id: expedition_id ?? this.expedition_id,
      reference: reference ?? this.reference,
      signature_id: signature_id ?? this.signature_id,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'expedition_id': expedition_id,
      'reference': reference,
      'signature_id': signature_id,
      'created_at': created_at.millisecondsSinceEpoch,
    };
  }

  factory LetreVoitures.fromMap(Map<String, dynamic> map) {
    return LetreVoitures(
      id: map['id'] as int,
      expedition_id: map['expedition_id'] as int,
      reference: map['reference'] as String,
      signature_id:
          map['signature_id'] != null ? map['signature_id'] as int : null,
      created_at: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory LetreVoitures.fromJson(String source) =>
      LetreVoitures.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LetreVoitures(id: $id, expedition_id: $expedition_id, reference: $reference, signature_id: $signature_id, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant LetreVoitures other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.expedition_id == expedition_id &&
        other.reference == reference &&
        other.signature_id == signature_id &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        expedition_id.hashCode ^
        reference.hashCode ^
        signature_id.hashCode ^
        created_at.hashCode;
  }
}
