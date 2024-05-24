// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Villes {
  final int id;
  final String name;
  final double? lat;
  final double? long;
  final int country_id;
  Villes({
    required this.id,
    required this.name,
    this.lat,
    this.long,
    required this.country_id,
  });

  Villes copyWith({
    int? id,
    String? name,
    double? lat,
    double? long,
    int? country_id,
  }) {
    return Villes(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      country_id: country_id ?? this.country_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lat': lat,
      'long': long,
      'country_id': country_id,
    };
  }

  factory Villes.fromMap(Map<String, dynamic> map) {
    return Villes(
      id: map['id'] as int,
      name: map['name'] as String,
      lat: map['lat'] != null ? map['lat'] as double : null,
      long: map['long'] != null ? map['long'] as double : null,
      country_id: map['country_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Villes.fromJson(String source) =>
      Villes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Villes(id: $id, name: $name, lat: $lat, long: $long, country_id: $country_id)';
  }

  @override
  bool operator ==(covariant Villes other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.lat == lat &&
        other.long == long &&
        other.country_id == country_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        country_id.hashCode;
  }
}
