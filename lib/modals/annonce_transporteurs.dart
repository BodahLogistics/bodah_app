// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class AnnonceTransporteurs {
  int id;
  String numero_annonce;
  int transporteur_id;
  int? type_chargement_id;
  int vehicule_id;
  DateTime created_at;

  AnnonceTransporteurs({
    required this.id,
    required this.numero_annonce,
    required this.transporteur_id,
    required this.type_chargement_id,
    required this.vehicule_id,
    required this.created_at,
  });

  AnnonceTransporteurs copyWith({
    int? id,
    String? numero_annonce,
    int? transporteur_id,
    int? type_chargement_id,
    int? vehicule_id,
    DateTime? created_at,
  }) {
    return AnnonceTransporteurs(
      id: id ?? this.id,
      numero_annonce: numero_annonce ?? this.numero_annonce,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      type_chargement_id: type_chargement_id ?? this.type_chargement_id,
      vehicule_id: vehicule_id ?? this.vehicule_id,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_annonce': numero_annonce,
      'transporteur_id': transporteur_id,
      'type_chargement_id': type_chargement_id,
      'vehicule_id': vehicule_id,
      'created_at': created_at.millisecondsSinceEpoch,
    };
  }

  factory AnnonceTransporteurs.fromMap(Map<String, dynamic> map) {
    return AnnonceTransporteurs(
      id: map['id'] as int,
      numero_annonce: map['numero_annonce'] as String,
      transporteur_id: map['transporteur_id'] as int,
      type_chargement_id: map['type_chargement_id'] != null
          ? (map['type_chargement_id'] is String
              ? int.parse(map['type_chargement_id'])
              : map['type_chargement_id'] as int)
          : null,
      vehicule_id: map['vehicule_id'] is String
          ? int.parse(map['vehicule_id'])
          : map['vehicule_id'] as int,
      created_at: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnonceTransporteurs.fromJson(String source) =>
      AnnonceTransporteurs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnnonceTransporteurs(id: $id, numero_annonce: $numero_annonce, transporteur_id: $transporteur_id, type_chargement_id: $type_chargement_id, vehicule_id: $vehicule_id, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant AnnonceTransporteurs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_annonce == numero_annonce &&
        other.transporteur_id == transporteur_id &&
        other.type_chargement_id == type_chargement_id &&
        other.vehicule_id == vehicule_id &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_annonce.hashCode ^
        transporteur_id.hashCode ^
        type_chargement_id.hashCode ^
        vehicule_id.hashCode ^
        created_at.hashCode;
  }
}
