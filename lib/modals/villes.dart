// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Villes {
  int id;
  String name;
  int country_id;
  Villes({
    required this.id,
    required this.name,
    required this.country_id,
  });

  Villes copyWith({
    int? id,
    String? name,
    int? country_id,
  }) {
    return Villes(
      id: id ?? this.id,
      name: name ?? this.name,
      country_id: country_id ?? this.country_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'country_id': country_id,
    };
  }

  factory Villes.fromMap(Map<String, dynamic> map) {
    return Villes(
      id: map['id'] as int,
      name: map['name'] as String,
      country_id: map['country_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Villes.fromJson(String source) =>
      Villes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Villes(id: $id, name: $name, country_id: $country_id)';

  @override
  bool operator ==(covariant Villes other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.country_id == country_id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ country_id.hashCode;
}
