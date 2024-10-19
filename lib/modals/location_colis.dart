// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class LocationColis {
  int id;
  int coli_id;
  int pay_dep_id;
  int pay_dest_id;
  int dep_dep_id;
  int dep_dest_id;
  int com_dep_id;
  int com_dest_id;
  int arrond_dep_id;
  int arrond_dest_id;
  int quart_dep_id;
  int quart_dest_id;
  String? address_dep;
  String? adress_dest;
  LocationColis({
    required this.id,
    required this.coli_id,
    required this.pay_dep_id,
    required this.pay_dest_id,
    required this.dep_dep_id,
    required this.dep_dest_id,
    required this.com_dep_id,
    required this.com_dest_id,
    required this.arrond_dep_id,
    required this.arrond_dest_id,
    required this.quart_dep_id,
    required this.quart_dest_id,
    this.address_dep,
    this.adress_dest,
  });

  LocationColis copyWith({
    int? id,
    int? coli_id,
    int? pay_dep_id,
    int? pay_dest_id,
    int? dep_dep_id,
    int? dep_dest_id,
    int? com_dep_id,
    int? com_dest_id,
    int? arrond_dep_id,
    int? arrond_dest_id,
    int? quart_dep_id,
    int? quart_dest_id,
    String? address_dep,
    String? adress_dest,
  }) {
    return LocationColis(
      id: id ?? this.id,
      coli_id: coli_id ?? this.coli_id,
      pay_dep_id: pay_dep_id ?? this.pay_dep_id,
      pay_dest_id: pay_dest_id ?? this.pay_dest_id,
      dep_dep_id: dep_dep_id ?? this.dep_dep_id,
      dep_dest_id: dep_dest_id ?? this.dep_dest_id,
      com_dep_id: com_dep_id ?? this.com_dep_id,
      com_dest_id: com_dest_id ?? this.com_dest_id,
      arrond_dep_id: arrond_dep_id ?? this.arrond_dep_id,
      arrond_dest_id: arrond_dest_id ?? this.arrond_dest_id,
      quart_dep_id: quart_dep_id ?? this.quart_dep_id,
      quart_dest_id: quart_dest_id ?? this.quart_dest_id,
      address_dep: address_dep ?? this.address_dep,
      adress_dest: adress_dest ?? this.adress_dest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'coli_id': coli_id,
      'pay_dep_id': pay_dep_id,
      'pay_dest_id': pay_dest_id,
      'dep_dep_id': dep_dep_id,
      'dep_dest_id': dep_dest_id,
      'com_dep_id': com_dep_id,
      'com_dest_id': com_dest_id,
      'arrond_dep_id': arrond_dep_id,
      'arrond_dest_id': arrond_dest_id,
      'quart_dep_id': quart_dep_id,
      'quart_dest_id': quart_dest_id,
      'address_dep': address_dep,
      'adress_dest': adress_dest,
    };
  }

  factory LocationColis.fromMap(Map<String, dynamic> map) {
    return LocationColis(
      id: map['id'] as int,
      coli_id: map['coli_id'] as int,
      pay_dep_id: map['pay_dep_id'] as int,
      pay_dest_id: map['pay_dest_id'] as int,
      dep_dep_id: map['dep_dep_id'] as int,
      dep_dest_id: map['dep_dest_id'] as int,
      com_dep_id: map['com_dep_id'] as int,
      com_dest_id: map['com_dest_id'] as int,
      arrond_dep_id: map['arrond_dep_id'] as int,
      arrond_dest_id: map['arrond_dest_id'] as int,
      quart_dep_id: map['quart_dep_id'] as int,
      quart_dest_id: map['quart_dest_id'] as int,
      address_dep:
          map['address_dep'] != null ? map['address_dep'] as String : null,
      adress_dest:
          map['adress_dest'] != null ? map['adress_dest'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationColis.fromJson(String source) =>
      LocationColis.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationColis(id: $id, coli_id: $coli_id, pay_dep_id: $pay_dep_id, pay_dest_id: $pay_dest_id, dep_dep_id: $dep_dep_id, dep_dest_id: $dep_dest_id, com_dep_id: $com_dep_id, com_dest_id: $com_dest_id, arrond_dep_id: $arrond_dep_id, arrond_dest_id: $arrond_dest_id, quart_dep_id: $quart_dep_id, quart_dest_id: $quart_dest_id, address_dep: $address_dep, adress_dest: $adress_dest)';
  }

  @override
  bool operator ==(covariant LocationColis other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.coli_id == coli_id &&
        other.pay_dep_id == pay_dep_id &&
        other.pay_dest_id == pay_dest_id &&
        other.dep_dep_id == dep_dep_id &&
        other.dep_dest_id == dep_dest_id &&
        other.com_dep_id == com_dep_id &&
        other.com_dest_id == com_dest_id &&
        other.arrond_dep_id == arrond_dep_id &&
        other.arrond_dest_id == arrond_dest_id &&
        other.quart_dep_id == quart_dep_id &&
        other.quart_dest_id == quart_dest_id &&
        other.address_dep == address_dep &&
        other.adress_dest == adress_dest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        coli_id.hashCode ^
        pay_dep_id.hashCode ^
        pay_dest_id.hashCode ^
        dep_dep_id.hashCode ^
        dep_dest_id.hashCode ^
        com_dep_id.hashCode ^
        com_dest_id.hashCode ^
        arrond_dep_id.hashCode ^
        arrond_dest_id.hashCode ^
        quart_dep_id.hashCode ^
        quart_dest_id.hashCode ^
        address_dep.hashCode ^
        adress_dest.hashCode;
  }
}
