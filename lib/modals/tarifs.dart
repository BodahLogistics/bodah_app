import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

class Tarif {
  int id;
  double montant;
  double accompte;
  String modele_type;
  int modele_id;

  Tarif({
    required this.id,
    required this.montant,
    required this.accompte,
    required this.modele_type,
    required this.modele_id,
  });

  Tarif copyWith({
    int? id,
    double? montant,
    double? accompte,
    String? modele_type,
    int? modele_id,
  }) {
    return Tarif(
      id: id ?? this.id,
      montant: montant ?? this.montant,
      accompte: accompte ?? this.accompte,
      modele_type: modele_type ?? this.modele_type,
      modele_id: modele_id ?? this.modele_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'montant': montant,
      'accompte': accompte,
      'modele_type': modele_type,
      'modele_id': modele_id,
    };
  }

  factory Tarif.fromMap(Map<String, dynamic> map) {
    return Tarif(
      id: map['id'] as int,
      montant: map['montant'] is String
          ? double.tryParse(map['montant']) ?? 0.0
          : map['montant'] as double,
      accompte: map['accompte'] is String
          ? double.tryParse(map['accompte']) ?? 0.0
          : map['accompte'] as double,
      modele_type: map['modele_type'] as String,
      modele_id: map['modele_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tarif.fromJson(String source) =>
      Tarif.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tarif(id: $id, montant: $montant, accompte: $accompte, modele_type: $modele_type, modele_id: $modele_id)';
  }

  @override
  bool operator ==(covariant Tarif other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.montant == montant &&
        other.accompte == accompte &&
        other.modele_type == modele_type &&
        other.modele_id == modele_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        montant.hashCode ^
        accompte.hashCode ^
        modele_type.hashCode ^
        modele_id.hashCode;
  }
}
