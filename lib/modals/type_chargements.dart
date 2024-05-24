// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TypeChargements {
  final int id;
  final String name;
  TypeChargements({
    required this.id,
    required this.name,
  });

  TypeChargements copyWith({
    int? id,
    String? name,
  }) {
    return TypeChargements(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory TypeChargements.fromMap(Map<String, dynamic> map) {
    return TypeChargements(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeChargements.fromJson(String source) =>
      TypeChargements.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TypeChargements(id: $id, name: $name)';

  @override
  bool operator ==(covariant TypeChargements other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
