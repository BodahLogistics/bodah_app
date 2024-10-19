// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Pieces {
  int id;
  String num_piece;
  int modele_id;
  int? type_piece_id;
  String modele_type;
  Pieces({
    required this.id,
    required this.num_piece,
    required this.modele_id,
    this.type_piece_id,
    required this.modele_type,
  });

  Pieces copyWith({
    int? id,
    String? num_piece,
    int? modele_id,
    int? type_piece_id,
    String? modele_type,
  }) {
    return Pieces(
      id: id ?? this.id,
      num_piece: num_piece ?? this.num_piece,
      modele_id: modele_id ?? this.modele_id,
      type_piece_id: type_piece_id ?? this.type_piece_id,
      modele_type: modele_type ?? this.modele_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'num_piece': num_piece,
      'modele_id': modele_id,
      'type_piece_id': type_piece_id,
      'modele_type': modele_type,
    };
  }

  factory Pieces.fromMap(Map<String, dynamic> map) {
    return Pieces(
      id: map['id'] as int,
      num_piece: map['num_piece'] as String,
      modele_id: map['modele_id'] as int,
      type_piece_id:
          map['type_piece_id'] != null ? map['type_piece_id'] as int : null,
      modele_type: map['modele_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pieces.fromJson(String source) =>
      Pieces.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pieces(id: $id, num_piece: $num_piece, modele_id: $modele_id, type_piece_id: $type_piece_id, modele_type: $modele_type)';
  }

  @override
  bool operator ==(covariant Pieces other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.num_piece == num_piece &&
        other.modele_id == modele_id &&
        other.type_piece_id == type_piece_id &&
        other.modele_type == modele_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        num_piece.hashCode ^
        modele_id.hashCode ^
        type_piece_id.hashCode ^
        modele_type.hashCode;
  }
}
