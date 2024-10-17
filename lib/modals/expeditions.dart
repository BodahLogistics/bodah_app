// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Expeditions {
  int id;
  int annonce_id;
  String numero_expedition;
  int transporteur_id;
  int statu_expedition_id;
  String? obs;
  DateTime date_depart;
  DateTime? date_arrivee;
  double? caution;
  int type_paiement_id;
  int vehicule_id;

  Expeditions({
    required this.id,
    required this.annonce_id,
    required this.numero_expedition,
    required this.transporteur_id,
    required this.statu_expedition_id,
    this.obs,
    required this.date_depart,
    this.date_arrivee,
    this.caution,
    required this.type_paiement_id,
    required this.vehicule_id,
  });

  Expeditions copyWith({
    int? id,
    int? annonce_id,
    String? numero_expedition,
    int? transporteur_id,
    int? statu_expedition_id,
    String? obs,
    DateTime? date_depart,
    DateTime? date_arrivee,
    double? caution,
    int? type_paiement_id,
    int? vehicule_id,
  }) {
    return Expeditions(
      id: id ?? this.id,
      annonce_id: annonce_id ?? this.annonce_id,
      numero_expedition: numero_expedition ?? this.numero_expedition,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      statu_expedition_id: statu_expedition_id ?? this.statu_expedition_id,
      obs: obs ?? this.obs,
      date_depart: date_depart ?? this.date_depart,
      date_arrivee: date_arrivee ?? this.date_arrivee,
      caution: caution ?? this.caution,
      type_paiement_id: type_paiement_id ?? this.type_paiement_id,
      vehicule_id: vehicule_id ?? this.vehicule_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'annonce_id': annonce_id,
      'numero_expedition': numero_expedition,
      'transporteur_id': transporteur_id,
      'statu_expedition_id': statu_expedition_id,
      'obs': obs,
      'date_depart': date_depart.millisecondsSinceEpoch,
      'date_arrivee': date_arrivee?.millisecondsSinceEpoch,
      'caution': caution,
      'type_paiement_id': type_paiement_id,
      'vehicule_id': vehicule_id,
    };
  }

  factory Expeditions.fromMap(Map<String, dynamic> map) {
    return Expeditions(
      id: map['id'] as int,
      annonce_id: map['annonce_id'] as int,
      numero_expedition: map['numero_expedition'] as String,
      transporteur_id: map['transporteur_id'] as int,
      statu_expedition_id: map['statu_expedition_id'] as int,
      obs: map['obs'] != null ? map['obs'] as String : null,
      date_depart: DateTime.parse(map['date_depart'] as String),
      date_arrivee: map['date_arrivee'] != null
          ? DateTime.parse(map['date_arrivee'] as String)
          : null,
      caution: map['caution'] != null ? map['caution'] as double : null,
      type_paiement_id: map['type_paiement_id'] as int,
      vehicule_id: map['vehicule_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expeditions.fromJson(String source) =>
      Expeditions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expeditions(id: $id, annonce_id: $annonce_id, numero_expedition: $numero_expedition, transporteur_id: $transporteur_id, statu_expedition_id: $statu_expedition_id, obs: $obs, date_depart: $date_depart, date_arrivee: $date_arrivee, caution: $caution, type_paiement_id: $type_paiement_id, vehicule_id: $vehicule_id)';
  }

  @override
  bool operator ==(covariant Expeditions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.annonce_id == annonce_id &&
        other.numero_expedition == numero_expedition &&
        other.transporteur_id == transporteur_id &&
        other.statu_expedition_id == statu_expedition_id &&
        other.obs == obs &&
        other.date_depart == date_depart &&
        other.date_arrivee == date_arrivee &&
        other.caution == caution &&
        other.type_paiement_id == type_paiement_id &&
        other.vehicule_id == vehicule_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        annonce_id.hashCode ^
        numero_expedition.hashCode ^
        transporteur_id.hashCode ^
        statu_expedition_id.hashCode ^
        obs.hashCode ^
        date_depart.hashCode ^
        date_arrivee.hashCode ^
        caution.hashCode ^
        type_paiement_id.hashCode ^
        vehicule_id.hashCode;
  }
}
