// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class TrajetLocalisations {
  final int id;
  final int pays_dep_id;
  final int pays_dest_id;
  final int ville_dep_id;
  final int ville_dest_id;
  final int annonce_id;
  final String? address_dep;
  final String? address_dest;
  TrajetLocalisations({
    required this.id,
    required this.pays_dep_id,
    required this.pays_dest_id,
    required this.ville_dep_id,
    required this.ville_dest_id,
    required this.annonce_id,
    this.address_dep,
    this.address_dest,
  });

  TrajetLocalisations copyWith({
    int? id,
    int? pays_dep_id,
    int? pays_dest_id,
    int? ville_dep_id,
    int? ville_dest_id,
    int? annonce_id,
    String? address_dep,
    String? address_dest,
  }) {
    return TrajetLocalisations(
      id: id ?? this.id,
      pays_dep_id: pays_dep_id ?? this.pays_dep_id,
      pays_dest_id: pays_dest_id ?? this.pays_dest_id,
      ville_dep_id: ville_dep_id ?? this.ville_dep_id,
      ville_dest_id: ville_dest_id ?? this.ville_dest_id,
      annonce_id: annonce_id ?? this.annonce_id,
      address_dep: address_dep ?? this.address_dep,
      address_dest: address_dest ?? this.address_dest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pays_dep_id': pays_dep_id,
      'pays_dest_id': pays_dest_id,
      'ville_dep_id': ville_dep_id,
      'ville_dest_id': ville_dest_id,
      'annonce_id': annonce_id,
      'address_dep': address_dep,
      'address_dest': address_dest,
    };
  }

  factory TrajetLocalisations.fromMap(Map<String, dynamic> map) {
    return TrajetLocalisations(
      id: map['id'] as int,
      pays_dep_id: map['pays_dep_id'] as int,
      pays_dest_id: map['pays_dest_id'] as int,
      ville_dep_id: map['ville_dep_id'] as int,
      ville_dest_id: map['ville_dest_id'] as int,
      annonce_id: map['annonce_id'] as int,
      address_dep:
          map['address_dep'] != null ? map['address_dep'] as String : null,
      address_dest:
          map['address_dest'] != null ? map['address_dest'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrajetLocalisations.fromJson(String source) =>
      TrajetLocalisations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TrajetLocalisations(id: $id, pays_dep_id: $pays_dep_id, pays_dest_id: $pays_dest_id, ville_dep_id: $ville_dep_id, ville_dest_id: $ville_dest_id, annonce_id: $annonce_id, address_dep: $address_dep, address_dest: $address_dest)';
  }

  @override
  bool operator ==(covariant TrajetLocalisations other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pays_dep_id == pays_dep_id &&
        other.pays_dest_id == pays_dest_id &&
        other.ville_dep_id == ville_dep_id &&
        other.ville_dest_id == ville_dest_id &&
        other.annonce_id == annonce_id &&
        other.address_dep == address_dep &&
        other.address_dest == address_dest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pays_dep_id.hashCode ^
        pays_dest_id.hashCode ^
        ville_dep_id.hashCode ^
        ville_dest_id.hashCode ^
        annonce_id.hashCode ^
        address_dep.hashCode ^
        address_dest.hashCode;
  }
}
