// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Recepteurs {
  int id;
  String reference;
  int user_id;
  Recepteurs({
    required this.id,
    required this.reference,
    required this.user_id,
  });

  Recepteurs copyWith({
    int? id,
    String? reference,
    int? user_id,
  }) {
    return Recepteurs(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'user_id': user_id,
    };
  }

  factory Recepteurs.fromMap(Map<String, dynamic> map) {
    return Recepteurs(
      id: map['id'] as int,
      reference: map['reference'] as String,
      user_id: map['user_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recepteurs.fromJson(String source) =>
      Recepteurs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Recepteurs(id: $id, reference: $reference, user_id: $user_id)';

  @override
  bool operator ==(covariant Recepteurs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.user_id == user_id;
  }

  @override
  int get hashCode => id.hashCode ^ reference.hashCode ^ user_id.hashCode;
}
