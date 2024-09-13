// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Paths {
  final int id;
  final String value;
  final int modele_id;
  final String modele_type;
  Paths({
    required this.id,
    required this.value,
    required this.modele_id,
    required this.modele_type,
  });

  Paths copyWith({
    int? id,
    String? value,
    int? modele_id,
    String? modele_type,
  }) {
    return Paths(
      id: id ?? this.id,
      value: value ?? this.value,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'modele_id': modele_id,
      'modele_type': modele_type,
    };
  }

  factory Paths.fromMap(Map<String, dynamic> map) {
    return Paths(
      id: map['id'] as int,
      value: map['value'] as String,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Paths.fromJson(String source) =>
      Paths.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Paths(id: $id, value: $value, modele_id: $modele_id, modele_type: $modele_type)';
  }

  @override
  bool operator ==(covariant Paths other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.value == value &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        value.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode;
  }
}
