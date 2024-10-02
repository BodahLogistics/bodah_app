// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class PaiementSolde {
  int id;
  double montant;
  int modele_id;
  String modele_type;
  PaiementSolde({
    required this.id,
    required this.montant,
    required this.modele_id,
    required this.modele_type,
  });

  PaiementSolde copyWith({
    int? id,
    double? montant,
    int? modele_id,
    String? modele_type,
  }) {
    return PaiementSolde(
      id: id ?? this.id,
      montant: montant ?? this.montant,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'montant': montant,
      'modele_id': modele_id,
      'modele_type': modele_type,
    };
  }

  factory PaiementSolde.fromMap(Map<String, dynamic> map) {
    return PaiementSolde(
      id: map['id'] as int,
      montant: map['montant'] as double,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaiementSolde.fromJson(String source) =>
      PaiementSolde.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaiementSolde(id: $id, montant: $montant, modele_id: $modele_id, modele_type: $modele_type)';
  }

  @override
  bool operator ==(covariant PaiementSolde other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.montant == montant &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        montant.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode;
  }
}
