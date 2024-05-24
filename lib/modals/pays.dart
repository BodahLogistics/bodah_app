// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Pays {
  final int id;
  final String name;
  final String flag;
  final String country_code;
  Pays({
    required this.id,
    required this.name,
    required this.flag,
    required this.country_code,
  });

  Pays copyWith({
    int? id,
    String? name,
    String? flag,
    String? country_code,
  }) {
    return Pays(
      id: id ?? this.id,
      name: name ?? this.name,
      flag: flag ?? this.flag,
      country_code: country_code ?? this.country_code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'flag': flag,
      'country_code': country_code,
    };
  }

  factory Pays.fromMap(Map<String, dynamic> map) {
    return Pays(
      id: map['id'] as int,
      name: map['name'] as String,
      flag: map['flag'] as String,
      country_code: map['country_code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pays.fromJson(String source) =>
      Pays.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pays(id: $id, name: $name, flag: $flag, country_code: $country_code)';
  }

  @override
  bool operator ==(covariant Pays other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.flag == flag &&
        other.country_code == country_code;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ flag.hashCode ^ country_code.hashCode;
  }
}
