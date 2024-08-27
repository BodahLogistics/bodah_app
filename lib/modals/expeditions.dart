// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Expeditions {
  final int id;
  final int annonce_id;
  final String numero_expedition;
  final int transporteur_id;
  final int statu_expedition_id;
  final int deleted;
  final String? description;
  final DateTime date_depart;
  final DateTime? date_arrivee;
  final double? caution;
  final int type_paiement_id;
  final int vehicule_id;
  final DateTime created_at;
  final DateTime updated_at;
  Expeditions({
    required this.id,
    required this.annonce_id,
    required this.numero_expedition,
    required this.transporteur_id,
    required this.statu_expedition_id,
    required this.deleted,
    this.description,
    required this.date_depart,
    this.date_arrivee,
    this.caution,
    required this.type_paiement_id,
    required this.vehicule_id,
    required this.created_at,
    required this.updated_at,
  });

  Expeditions copyWith({
    int? id,
    int? annonce_id,
    String? numero_expedition,
    int? transporteur_id,
    int? statu_expedition_id,
    int? deleted,
    String? description,
    DateTime? date_depart,
    DateTime? date_arrivee,
    double? caution,
    int? type_paiement_id,
    int? vehicule_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Expeditions(
      id: id ?? this.id,
      annonce_id: annonce_id ?? this.annonce_id,
      numero_expedition: numero_expedition ?? this.numero_expedition,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      statu_expedition_id: statu_expedition_id ?? this.statu_expedition_id,
      deleted: deleted ?? this.deleted,
      description: description ?? this.description,
      date_depart: date_depart ?? this.date_depart,
      date_arrivee: date_arrivee ?? this.date_arrivee,
      caution: caution ?? this.caution,
      type_paiement_id: type_paiement_id ?? this.type_paiement_id,
      vehicule_id: vehicule_id ?? this.vehicule_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'annonce_id': annonce_id,
      'numero_expedition': numero_expedition,
      'transporteur_id': transporteur_id,
      'statu_expedition_id': statu_expedition_id,
      'deleted': deleted,
      'description': description,
      'date_depart': date_depart.millisecondsSinceEpoch,
      'date_arrivee': date_arrivee?.millisecondsSinceEpoch,
      'caution': caution,
      'type_paiement_id': type_paiement_id,
      'vehicule_id': vehicule_id,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Expeditions.fromMap(Map<String, dynamic> map) {
    return Expeditions(
      annonce_id: map['annonce_id'] as int,
      id: map['id'] as int,
      numero_expedition: map['numero_expedition'] as String,
      transporteur_id: map['transporteur_id'] as int,
      statu_expedition_id: map['statu_expedition_id'] as int,
      deleted: map['deleted'] as int,
      description:
          map['description'] != null ? map['description'] as String : null,
      date_depart: DateTime.parse(map['date_depart'] as String),
      date_arrivee: map['date_arrivee'] != null
          ? DateTime.parse(map['date_arrivee'] as String)
          : null,
      caution: map['caution'] != null
          ? double.tryParse(map['caution'].toString())
          : null,
      type_paiement_id: map['type_paiement_id'] as int,
      vehicule_id: map['vehicule_id'] as int,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Expeditions.fromJson(String source) =>
      Expeditions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expeditions(id: $id, annonce_id: $annonce_id, numero_expedition: $numero_expedition, transporteur_id: $transporteur_id, statu_expedition_id: $statu_expedition_id, deleted: $deleted, description: $description, date_depart: $date_depart, date_arrivee: $date_arrivee, caution: $caution, type_paiement_id: $type_paiement_id, vehicule_id: $vehicule_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Expeditions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.annonce_id == annonce_id &&
        other.numero_expedition == numero_expedition &&
        other.transporteur_id == transporteur_id &&
        other.statu_expedition_id == statu_expedition_id &&
        other.deleted == deleted &&
        other.description == description &&
        other.date_depart == date_depart &&
        other.date_arrivee == date_arrivee &&
        other.caution == caution &&
        other.type_paiement_id == type_paiement_id &&
        other.vehicule_id == vehicule_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        annonce_id.hashCode ^
        numero_expedition.hashCode ^
        transporteur_id.hashCode ^
        statu_expedition_id.hashCode ^
        deleted.hashCode ^
        description.hashCode ^
        date_depart.hashCode ^
        date_arrivee.hashCode ^
        caution.hashCode ^
        type_paiement_id.hashCode ^
        vehicule_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
