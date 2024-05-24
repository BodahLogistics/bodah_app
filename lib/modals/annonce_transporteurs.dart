// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class AnnonceTransporteurs {
  final int id;
  final String numero_annonce;
  final int transporteur_id;
  final String? autre_detail;
  final DateTime? date_voyage;
  final double? tarif;
  final int? type_chargement_id;
  final int user_id;
  final int vehicule_id;
  final int deleted;
  AnnonceTransporteurs({
    required this.id,
    required this.numero_annonce,
    required this.transporteur_id,
    required this.autre_detail,
    required this.date_voyage,
    required this.tarif,
    required this.type_chargement_id,
    required this.user_id,
    required this.vehicule_id,
    required this.deleted,
  });

  AnnonceTransporteurs copyWith({
    int? id,
    String? numero_annonce,
    int? transporteur_id,
    String? autre_detail,
    DateTime? date_voyage,
    double? tarif,
    int? type_chargement_id,
    int? user_id,
    int? vehicule_id,
    int? deleted,
  }) {
    return AnnonceTransporteurs(
      id: id ?? this.id,
      numero_annonce: numero_annonce ?? this.numero_annonce,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      autre_detail: autre_detail ?? this.autre_detail,
      date_voyage: date_voyage ?? this.date_voyage,
      tarif: tarif ?? this.tarif,
      type_chargement_id: type_chargement_id ?? this.type_chargement_id,
      user_id: user_id ?? this.user_id,
      vehicule_id: vehicule_id ?? this.vehicule_id,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_annonce': numero_annonce,
      'transporteur_id': transporteur_id,
      'autre_detail': autre_detail,
      'date_voyage': date_voyage?.millisecondsSinceEpoch,
      'tarif': tarif,
      'type_chargement_id': type_chargement_id,
      'user_id': user_id,
      'vehicule_id': vehicule_id,
      'deleted': deleted,
    };
  }

  factory AnnonceTransporteurs.fromMap(Map<String, dynamic> map) {
    return AnnonceTransporteurs(
      id: map['id'] as int,
      numero_annonce: map['numero_annonce'] as String,
      transporteur_id: map['transporteur_id'] as int,
      autre_detail:
          map['autre_detail'] != null ? map['autre_detail'] as String : null,
      date_voyage: map['date_voyage'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date_voyage'] as int)
          : null,
      tarif: map['tarif'] != null ? map['tarif'] as double : null,
      type_chargement_id: map['type_chargement_id'] != null
          ? map['type_chargement_id'] as int
          : null,
      user_id: map['user_id'] as int,
      vehicule_id: map['vehicule_id'] as int,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnonceTransporteurs.fromJson(String source) =>
      AnnonceTransporteurs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnnonceTransporteurs(id: $id, numero_annonce: $numero_annonce, transporteur_id: $transporteur_id, autre_detail: $autre_detail, date_voyage: $date_voyage, tarif: $tarif, type_chargement_id: $type_chargement_id, user_id: $user_id, vehicule_id: $vehicule_id, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant AnnonceTransporteurs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_annonce == numero_annonce &&
        other.transporteur_id == transporteur_id &&
        other.autre_detail == autre_detail &&
        other.date_voyage == date_voyage &&
        other.tarif == tarif &&
        other.type_chargement_id == type_chargement_id &&
        other.user_id == user_id &&
        other.vehicule_id == vehicule_id &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_annonce.hashCode ^
        transporteur_id.hashCode ^
        autre_detail.hashCode ^
        date_voyage.hashCode ^
        tarif.hashCode ^
        type_chargement_id.hashCode ^
        user_id.hashCode ^
        vehicule_id.hashCode ^
        deleted.hashCode;
  }
}
