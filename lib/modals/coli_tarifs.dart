// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class ColiTarifs {
  final int id;
  final int coli_id;
  final double prix_envoie;
  ColiTarifs({
    required this.id,
    required this.coli_id,
    required this.prix_envoie,
  });

  ColiTarifs copyWith({
    int? id,
    int? coli_id,
    double? prix_envoie,
  }) {
    return ColiTarifs(
      id: id ?? this.id,
      coli_id: coli_id ?? this.coli_id,
      prix_envoie: prix_envoie ?? this.prix_envoie,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'coli_id': coli_id,
      'prix_envoie': prix_envoie,
    };
  }

  factory ColiTarifs.fromMap(Map<String, dynamic> map) {
    return ColiTarifs(
      id: map['id'] as int,
      coli_id: map['coli_id'] as int,
      prix_envoie: map['prix_envoie'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColiTarifs.fromJson(String source) =>
      ColiTarifs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ColiTarifs(id: $id, coli_id: $coli_id, prix_envoie: $prix_envoie)';

  @override
  bool operator ==(covariant ColiTarifs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.coli_id == coli_id &&
        other.prix_envoie == prix_envoie;
  }

  @override
  int get hashCode => id.hashCode ^ coli_id.hashCode ^ prix_envoie.hashCode;
}
