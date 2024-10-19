// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Client {
  int id;
  String reference;
  String nom;
  String telephone;
  int country_id;

  Client({
    required this.id,
    required this.reference,
    required this.nom,
    required this.telephone,
    required this.country_id,
  });

  Client copyWith({
    int? id,
    String? reference,
    String? nom,
    String? telephone,
    int? country_id,
  }) {
    return Client(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      nom: nom ?? this.nom,
      telephone: telephone ?? this.telephone,
      country_id: country_id ?? this.country_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'nom': nom,
      'telephone': telephone,
      'country_id': country_id,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] != null ? int.tryParse(map['id'].toString()) ?? 0 : 0,
      reference: map['reference'] ?? '',
      nom: map['nom'] ?? '',
      telephone: map['telephone'] ?? '',
      country_id: map['country_id'] != null
          ? int.tryParse(map['country_id'].toString()) ?? 0
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) =>
      Client.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Client(id: $id, reference: $reference, nom: $nom, telephone: $telephone, country_id: $country_id)';
  }

  @override
  bool operator ==(covariant Client other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.nom == nom &&
        other.telephone == telephone &&
        other.country_id == country_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        nom.hashCode ^
        telephone.hashCode ^
        country_id.hashCode;
  }
}
