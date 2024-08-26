// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Pieces {
  final int id;
  final String num_piace;
  final int? type_piece_id;
  final int modele_id;
  final String modele_type;
  Pieces({
    required this.id,
    required this.num_piace,
    required this.type_piece_id,
    required this.modele_id,
    required this.modele_type,
  });

  Pieces copyWith({
    int? id,
    String? num_piace,
    int? type_piece_id,
    int? modele_id,
    String? modele_type,
  }) {
    return Pieces(
      id: id ?? this.id,
      num_piace: num_piace ?? this.num_piace,
      type_piece_id: type_piece_id ?? this.type_piece_id,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'num_piace': num_piace,
      'type_piece_id': type_piece_id,
      'modele_id': modele_id,
      'modele_type': modele_type,
    };
  }

  factory Pieces.fromMap(Map<String, dynamic> map) {
    return Pieces(
      id: map['id'] as int,
      num_piace: map['num_piace'] as String,
      type_piece_id:
          map['type_piece_id'] != null ? map['type_piece_id'] as int : null,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pieces.fromJson(String source) =>
      Pieces.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pieces(id: $id, num_piace: $num_piace, type_piece_id: $type_piece_id, modele_id: $modele_id, modele_type: $modele_type)';
  }

  @override
  bool operator ==(covariant Pieces other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.num_piace == num_piace &&
        other.type_piece_id == type_piece_id &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        num_piace.hashCode ^
        type_piece_id.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode;
  }
}
