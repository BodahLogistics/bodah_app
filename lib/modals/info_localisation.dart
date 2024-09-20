// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class InfoLocalisations {
  int id;
  int pays_dep_id;
  int pays_dest_id;
  int ville_dep_id;
  int ville_dest_id;
  int annonce_id;
  InfoLocalisations({
    required this.id,
    required this.pays_dep_id,
    required this.pays_dest_id,
    required this.ville_dep_id,
    required this.ville_dest_id,
    required this.annonce_id,
  });

  InfoLocalisations copyWith({
    int? id,
    int? pays_dep_id,
    int? pays_dest_id,
    int? ville_dep_id,
    int? ville_dest_id,
    int? annonce_id,
  }) {
    return InfoLocalisations(
      id: id ?? this.id,
      pays_dep_id: pays_dep_id ?? this.pays_dep_id,
      pays_dest_id: pays_dest_id ?? this.pays_dest_id,
      ville_dep_id: ville_dep_id ?? this.ville_dep_id,
      ville_dest_id: ville_dest_id ?? this.ville_dest_id,
      annonce_id: annonce_id ?? this.annonce_id,
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
    };
  }

  factory InfoLocalisations.fromMap(Map<String, dynamic> map) {
    return InfoLocalisations(
      id: map['id'] as int,
      pays_dep_id: map['pays_dep_id'] as int,
      pays_dest_id: map['pays_dest_id'] as int,
      ville_dep_id: map['ville_dep_id'] as int,
      ville_dest_id: map['ville_dest_id'] as int,
      annonce_id: map['annonce_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoLocalisations.fromJson(String source) =>
      InfoLocalisations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InfoLocalisations(id: $id, pays_dep_id: $pays_dep_id, pays_dest_id: $pays_dest_id, ville_dep_id: $ville_dep_id, ville_dest_id: $ville_dest_id, annonce_id: $annonce_id)';
  }

  @override
  bool operator ==(covariant InfoLocalisations other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pays_dep_id == pays_dep_id &&
        other.pays_dest_id == pays_dest_id &&
        other.ville_dep_id == ville_dep_id &&
        other.ville_dest_id == ville_dest_id &&
        other.annonce_id == annonce_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pays_dep_id.hashCode ^
        pays_dest_id.hashCode ^
        ville_dep_id.hashCode ^
        ville_dest_id.hashCode ^
        annonce_id.hashCode;
  }
}
