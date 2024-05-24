// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Pieces {
  final int id;
  final String num_piace;
  final int type_piece_id;
  final int transporteur_id;
  Pieces({
    required this.id,
    required this.num_piace,
    required this.type_piece_id,
    required this.transporteur_id,
  });

  Pieces copyWith({
    int? id,
    String? num_piace,
    int? type_piece_id,
    int? transporteur_id,
  }) {
    return Pieces(
      id: id ?? this.id,
      num_piace: num_piace ?? this.num_piace,
      type_piece_id: type_piece_id ?? this.type_piece_id,
      transporteur_id: transporteur_id ?? this.transporteur_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'num_piace': num_piace,
      'type_piece_id': type_piece_id,
      'transporteur_id': transporteur_id,
    };
  }

  factory Pieces.fromMap(Map<String, dynamic> map) {
    return Pieces(
      id: map['id'] as int,
      num_piace: map['num_piace'] as String,
      type_piece_id: map['type_piece_id'] as int,
      transporteur_id: map['transporteur_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pieces.fromJson(String source) =>
      Pieces.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pieces(id: $id, num_piace: $num_piace, type_piece_id: $type_piece_id, transporteur_id: $transporteur_id)';
  }

  @override
  bool operator ==(covariant Pieces other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.num_piace == num_piace &&
        other.type_piece_id == type_piece_id &&
        other.transporteur_id == transporteur_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        num_piace.hashCode ^
        type_piece_id.hashCode ^
        transporteur_id.hashCode;
  }
}
