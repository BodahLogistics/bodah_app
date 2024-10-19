// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Positions {
  int id;
  int pay_dep_id;
  int pay_liv_id;
  int city_dep_id;
  int city_liv_id;
  String? address_dep;
  String? address_liv;
  int modele_id;
  String modele_type;

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
  });

  factory Positions.fromMap(Map<String, dynamic> map) {
    // Fonction pour convertir une chaîne en entier si nécessaire
    int parseInt(dynamic value) {
      if (value is String) {
        return int.tryParse(value) ?? 0; // Utilise 0 par défaut si échec
      } else if (value is int) {
        return value;
      }
      return 0; // Valeur par défaut si null ou autre
    }

    return Positions(
      id: parseInt(map['id']),
      pay_dep_id: parseInt(map['pay_dep_id']), // Conversion explicite en entier
      pay_liv_id: parseInt(map['pay_liv_id']), // Conversion explicite en entier
      city_dep_id:
          parseInt(map['city_dep_id']), // Conversion explicite en entier
      city_liv_id:
          parseInt(map['city_liv_id']), // Conversion explicite en entier
      address_dep:
          map['address_dep'] != null ? map['address_dep'] as String : null,
      address_liv:
          map['address_liv'] != null ? map['address_liv'] as String : null,
      modele_id: parseInt(map['modele_id']),
      modele_type: map['modele_type'] as String,
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
    };
  }

  String toJson() => json.encode(toMap());

  factory Positions.fromJson(String source) =>
      Positions.fromMap(json.decode(source) as Map<String, dynamic>);

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
    );
  }

  @override
  String toString() {
    return 'Positions(id: $id, pay_dep_id: $pay_dep_id, pay_liv_id: $pay_liv_id, city_dep_id: $city_dep_id, city_liv_id: $city_liv_id, address_dep: $address_dep, address_liv: $address_liv, modele_id: $modele_id, modele_type: $modele_type)';
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
        other.modele_type == modele_type;
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
        modele_type.hashCode;
  }
}
