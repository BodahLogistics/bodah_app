// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Gps {
  int id;
  double lat;
  double long;
  int modele_id;
  String modele_type;
  Gps({
    required this.id,
    required this.lat,
    required this.long,
    required this.modele_id,
    required this.modele_type,
  });

  Gps copyWith({
    int? id,
    double? lat,
    double? long,
    int? modele_id,
    String? modele_type,
  }) {
    return Gps(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lat': lat,
      'long': long,
      'modele_id': modele_id,
      'modele_type': modele_type,
    };
  }

  factory Gps.fromMap(Map<String, dynamic> map) {
    return Gps(
      id: map['id'] as int,
      lat: map['lat'] as double,
      long: map['long'] as double,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Gps.fromJson(String source) =>
      Gps.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Gps(id: $id, lat: $lat, long: $long, modele_id: $modele_id, modele_type: $modele_type)';
  }

  @override
  bool operator ==(covariant Gps other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.lat == lat &&
        other.long == long &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode;
  }
}
