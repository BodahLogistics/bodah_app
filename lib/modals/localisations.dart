// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Localisations {
  final int id;
  final int pays_exp_id;
  final int payes_liv_id;
  final int city_exp_id;
  final int city_liv_id;
  final int marchandise_id;
  final String? address_exp;
  final String? address_liv;
  Localisations({
    required this.id,
    required this.pays_exp_id,
    required this.payes_liv_id,
    required this.city_exp_id,
    required this.city_liv_id,
    required this.marchandise_id,
    this.address_exp,
    this.address_liv,
  });

  Localisations copyWith({
    int? id,
    int? pays_exp_id,
    int? payes_liv_id,
    int? city_exp_id,
    int? city_liv_id,
    int? marchandise_id,
    String? address_exp,
    String? address_liv,
  }) {
    return Localisations(
      id: id ?? this.id,
      pays_exp_id: pays_exp_id ?? this.pays_exp_id,
      payes_liv_id: payes_liv_id ?? this.payes_liv_id,
      city_exp_id: city_exp_id ?? this.city_exp_id,
      city_liv_id: city_liv_id ?? this.city_liv_id,
      marchandise_id: marchandise_id ?? this.marchandise_id,
      address_exp: address_exp ?? this.address_exp,
      address_liv: address_liv ?? this.address_liv,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pays_exp_id': pays_exp_id,
      'payes_liv_id': payes_liv_id,
      'city_exp_id': city_exp_id,
      'city_liv_id': city_liv_id,
      'marchandise_id': marchandise_id,
      'address_exp': address_exp,
      'address_liv': address_liv,
    };
  }

  factory Localisations.fromMap(Map<String, dynamic> map) {
    return Localisations(
      id: map['id'] as int,
      pays_exp_id: map['pays_exp_id'] as int,
      payes_liv_id: map['payes_liv_id'] as int,
      city_exp_id: map['city_exp_id'] as int,
      city_liv_id: map['city_liv_id'] as int,
      marchandise_id: map['marchandise_id'] as int,
      address_exp:
          map['address_exp'] != null ? map['address_exp'] as String : null,
      address_liv:
          map['address_liv'] != null ? map['address_liv'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Localisations.fromJson(String source) =>
      Localisations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Localisations(id: $id, pays_exp_id: $pays_exp_id, payes_liv_id: $payes_liv_id, city_exp_id: $city_exp_id, city_liv_id: $city_liv_id, marchandise_id: $marchandise_id, address_exp: $address_exp, address_liv: $address_liv)';
  }

  @override
  bool operator ==(covariant Localisations other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pays_exp_id == pays_exp_id &&
        other.payes_liv_id == payes_liv_id &&
        other.city_exp_id == city_exp_id &&
        other.city_liv_id == city_liv_id &&
        other.marchandise_id == marchandise_id &&
        other.address_exp == address_exp &&
        other.address_liv == address_liv;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pays_exp_id.hashCode ^
        payes_liv_id.hashCode ^
        city_exp_id.hashCode ^
        city_liv_id.hashCode ^
        marchandise_id.hashCode ^
        address_exp.hashCode ^
        address_liv.hashCode;
  }
}
