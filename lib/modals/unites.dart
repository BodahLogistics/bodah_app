// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Unites {
  final int id;
  final String name;
  Unites({
    required this.id,
    required this.name,
  });

  Unites copyWith({
    int? id,
    String? name,
  }) {
    return Unites(
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

  factory Unites.fromMap(Map<String, dynamic> map) {
    return Unites(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Unites.fromJson(String source) =>
      Unites.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Unites(id: $id, name: $name)';

  @override
  bool operator ==(covariant Unites other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
