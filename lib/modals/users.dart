// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Users {
  int id;
  String name;
  String? email;
  String? adresse;
  int country_id;
  int? city_id;
  String telephone;
  int deleted;
  int is_verified;
  int is_active;
  int dark_mode;
  Users({
    required this.id,
    required this.name,
    this.email,
    this.adresse,
    required this.country_id,
    this.city_id,
    required this.telephone,
    required this.deleted,
    required this.is_verified,
    required this.is_active,
    required this.dark_mode,
  });

  Users copyWith({
    int? id,
    String? name,
    String? email,
    String? adresse,
    int? country_id,
    int? city_id,
    String? telephone,
    int? deleted,
    int? is_verified,
    int? is_active,
    int? dark_mode,
  }) {
    return Users(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      adresse: adresse ?? this.adresse,
      country_id: country_id ?? this.country_id,
      city_id: city_id ?? this.city_id,
      telephone: telephone ?? this.telephone,
      deleted: deleted ?? this.deleted,
      is_verified: is_verified ?? this.is_verified,
      is_active: is_active ?? this.is_active,
      dark_mode: dark_mode ?? this.dark_mode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'adresse': adresse,
      'country_id': country_id,
      'city_id': city_id,
      'telephone': telephone,
      'deleted': deleted,
      'is_verified': is_verified,
      'is_active': is_active,
      'dark_mode': dark_mode,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      adresse: map['adresse'] != null ? map['adresse'] as String : null,
      country_id: int.parse(map['country_id'].toString()), // Conversion en int
      city_id: map['city_id'] != null
          ? int.parse(map['city_id'].toString())
          : null, // Conversion en int
      telephone: map['telephone'] as String,
      deleted: map['deleted'] != null ? map['deleted'] as int : 0,
      is_verified: map['is_verified'] != null ? map['is_verified'] as int : 0,
      is_active: map['is_active'] != null ? map['is_active'] as int : 0,
      dark_mode: map['dark_mode'] != null ? map['dark_mode'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(id: $id, name: $name, email: $email, adresse: $adresse, country_id: $country_id, city_id: $city_id, telephone: $telephone, deleted: $deleted, is_verified: $is_verified, is_active: $is_active, dark_mode: $dark_mode)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.adresse == adresse &&
        other.country_id == country_id &&
        other.city_id == city_id &&
        other.telephone == telephone &&
        other.deleted == deleted &&
        other.is_verified == is_verified &&
        other.is_active == is_active &&
        other.dark_mode == dark_mode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        adresse.hashCode ^
        country_id.hashCode ^
        city_id.hashCode ^
        telephone.hashCode ^
        deleted.hashCode ^
        is_verified.hashCode ^
        is_active.hashCode ^
        dark_mode.hashCode;
  }
}
