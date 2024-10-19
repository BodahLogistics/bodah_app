// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class EntiteFactures {
  int id;
  int user_id;
  String? ifu;
  String reference;
  EntiteFactures({
    required this.id,
    required this.user_id,
    this.ifu,
    required this.reference,
  });

  EntiteFactures copyWith({
    int? id,
    int? user_id,
    String? ifu,
    String? reference,
  }) {
    return EntiteFactures(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      ifu: ifu ?? this.ifu,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'ifu': ifu,
      'reference': reference,
    };
  }

  factory EntiteFactures.fromMap(Map<String, dynamic> map) {
    return EntiteFactures(
      id: map['id'] as int,
      user_id: map['user_id'] as int,
      ifu: map['ifu'] != null ? map['ifu'] as String : null,
      reference: map['reference'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EntiteFactures.fromJson(String source) =>
      EntiteFactures.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EntiteFactures(id: $id, user_id: $user_id, ifu: $ifu, reference: $reference)';
  }

  @override
  bool operator ==(covariant EntiteFactures other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.ifu == ifu &&
        other.reference == reference;
  }

  @override
  int get hashCode {
    return id.hashCode ^ user_id.hashCode ^ ifu.hashCode ^ reference.hashCode;
  }
}
