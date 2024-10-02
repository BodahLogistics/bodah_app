// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Positions {
  final int id;
  final int pay_dep_id;
  final int pay_liv_id;
  final int city_dep_id;
  final int city_liv_id;
  final String? address_dep;
  final String? address_liv;
  final int modele_id;
  final String modele_type;
  final int deleted;
  Positions({
    required this.id,
    required this.pay_dep_id,
    required this.pay_liv_id,
    required this.city_dep_id,
    required this.city_liv_id,
    this.address_dep,
    this.address_liv,
    required this.modele_id,
    required this.modele_type,
    required this.deleted,
  });

  Positions copyWith({
    int? id,
    int? pay_dep_id,
    int? pay_liv_id,
    int? city_dep_id,
    int? city_liv_id,
    String? address_dep,
    String? address_liv,
    int? modele_id,
    String? modele_type,
    int? deleted,
  }) {
    return Positions(
      id: id ?? this.id,
      pay_dep_id: pay_dep_id ?? this.pay_dep_id,
      pay_liv_id: pay_liv_id ?? this.pay_liv_id,
      city_dep_id: city_dep_id ?? this.city_dep_id,
      city_liv_id: city_liv_id ?? this.city_liv_id,
      address_dep: address_dep ?? this.address_dep,
      address_liv: address_liv ?? this.address_liv,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pay_dep_id': pay_dep_id,
      'pay_liv_id': pay_liv_id,
      'city_dep_id': city_dep_id,
      'city_liv_id': city_liv_id,
      'address_dep': address_dep,
      'address_liv': address_liv,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'deleted': deleted,
    };
  }

  factory Positions.fromMap(Map<String, dynamic> map) {
    return Positions(
      id: map['id'] as int,
      pay_dep_id: map['pay_dep_id'] as int,
      pay_liv_id: map['pay_liv_id'] as int,
      city_dep_id: map['city_dep_id'] as int,
      city_liv_id: map['city_liv_id'] as int,
      address_dep:
          map['address_dep'] != null ? map['address_dep'] as String : null,
      address_liv:
          map['address_liv'] != null ? map['address_liv'] as String : null,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Positions.fromJson(String source) =>
      Positions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Position(id: $id, pay_dep_id: $pay_dep_id, pay_liv_id: $pay_liv_id, city_dep_id: $city_dep_id, city_liv_id: $city_liv_id, address_dep: $address_dep, address_liv: $address_liv, modele_id: $modele_id, modele_type: $modele_type, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Positions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pay_dep_id == pay_dep_id &&
        other.pay_liv_id == pay_liv_id &&
        other.city_dep_id == city_dep_id &&
        other.city_liv_id == city_liv_id &&
        other.address_dep == address_dep &&
        other.address_liv == address_liv &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pay_dep_id.hashCode ^
        pay_liv_id.hashCode ^
        city_dep_id.hashCode ^
        city_liv_id.hashCode ^
        address_dep.hashCode ^
        address_liv.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        deleted.hashCode;
  }
}
