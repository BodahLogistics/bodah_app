// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Statuts {
  final int id;
  final String name;
  Statuts({
    required this.id,
    required this.name,
  });

  Statuts copyWith({
    int? id,
    String? name,
  }) {
    return Statuts(
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

  factory Statuts.fromMap(Map<String, dynamic> map) {
    return Statuts(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Statuts.fromJson(String source) =>
      Statuts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Statuts(id: $id, name: $name)';

  @override
  bool operator ==(covariant Statuts other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
