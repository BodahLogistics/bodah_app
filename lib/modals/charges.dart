// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Charge {
  int id;
  String quantite;
  String poids;
  String cargaison_type;
  int cargaison_id;
  String chargement_type;
  int chargement_id;

  Charge({
    required this.id,
    required this.quantite,
    required this.poids,
    required this.cargaison_type,
    required this.cargaison_id,
    required this.chargement_type,
    required this.chargement_id,
    required this.deleted,
  });

  Charge copyWith({
    int? id,
    int? quantite,
    int? poids,
    String? cargaison_type,
    int? cargaison_id,
    String? chargement_type,
    int? chargement_id,
    int? deleted,
  }) {
    return Charge(
      id: id ?? this.id,
      quantite: quantite ?? this.quantite,
      poids: poids ?? this.poids,
      cargaison_type: cargaison_type ?? this.cargaison_type,
      cargaison_id: cargaison_id ?? this.cargaison_id,
      chargement_type: chargement_type ?? this.chargement_type,
      chargement_id: chargement_id ?? this.chargement_id,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantite': quantite,
      'poids': poids,
      'cargaison_type': cargaison_type,
      'cargaison_id': cargaison_id,
      'chargement_type': chargement_type,
      'chargement_id': chargement_id,
      'deleted': deleted,
    };
  }

  factory Charge.fromMap(Map<String, dynamic> map) {
    return Charge(
      id: map['id'] as int,
      quantite: map['quantite'] as int,
      poids: map['poids'] as int,
      cargaison_type: map['cargaison_type'] as String,
      cargaison_id: map['cargaison_id'] as int,
      chargement_type: map['chargement_type'] as String,
      chargement_id: map['chargement_id'] as int,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Charge.fromJson(String source) =>
      Charge.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Charge(id: $id, quantite: $quantite, poids: $poids, cargaison_type: $cargaison_type, cargaison_id: $cargaison_id, chargement_type: $chargement_type, chargement_id: $chargement_id, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Charge other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.quantite == quantite &&
        other.poids == poids &&
        other.cargaison_type == cargaison_type &&
        other.cargaison_id == cargaison_id &&
        other.chargement_type == chargement_type &&
        other.chargement_id == chargement_id &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        quantite.hashCode ^
        poids.hashCode ^
        cargaison_type.hashCode ^
        cargaison_id.hashCode ^
        chargement_type.hashCode ^
        chargement_id.hashCode ^
        deleted.hashCode;
  }
}
