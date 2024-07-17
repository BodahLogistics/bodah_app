// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Colis {
  final int id;
  final String reference;
  final int deleted;
  final int annonce_id;
  final int user_id;
  final String nom;
  final int quantite;
  final DateTime date_envoie;
  final int recepteur_id;
  final DateTime created_at;
  final DateTime updated_at;
  Colis({
    required this.id,
    required this.reference,
    required this.deleted,
    required this.annonce_id,
    required this.user_id,
    required this.nom,
    required this.quantite,
    required this.date_envoie,
    required this.recepteur_id,
    required this.created_at,
    required this.updated_at,
  });

  Colis copyWith({
    int? id,
    String? reference,
    int? deleted,
    int? annonce_id,
    int? user_id,
    String? nom,
    int? quantite,
    DateTime? date_envoie,
    int? recepteur_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Colis(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      deleted: deleted ?? this.deleted,
      annonce_id: annonce_id ?? this.annonce_id,
      user_id: user_id ?? this.user_id,
      nom: nom ?? this.nom,
      quantite: quantite ?? this.quantite,
      date_envoie: date_envoie ?? this.date_envoie,
      recepteur_id: recepteur_id ?? this.recepteur_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'deleted': deleted,
      'annonce_id': annonce_id,
      'user_id': user_id,
      'nom': nom,
      'quantite': quantite,
      'date_envoie': date_envoie.millisecondsSinceEpoch,
      'recepteur_id': recepteur_id,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Colis.fromMap(Map<String, dynamic> map) {
    return Colis(
      id: map['id'] as int,
      reference: map['reference'] as String,
      deleted: map['deleted'] as int,
      annonce_id: map['annonce_id'] as int,
      user_id: map['user_id'] as int,
      nom: map['nom'] as String,
      quantite: map['quantite'] as int,
      date_envoie: DateTime.parse(map['date_envoie'] as String),
      recepteur_id: map['recepteur_id'] as int,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Colis.fromJson(String source) =>
      Colis.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Colis(id: $id, reference: $reference, deleted: $deleted, annonce_id: $annonce_id, user_id: $user_id, nom: $nom, quantite: $quantite, date_envoie: $date_envoie, recepteur_id: $recepteur_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Colis other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.deleted == deleted &&
        other.annonce_id == annonce_id &&
        other.user_id == user_id &&
        other.nom == nom &&
        other.quantite == quantite &&
        other.date_envoie == date_envoie &&
        other.recepteur_id == recepteur_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        deleted.hashCode ^
        annonce_id.hashCode ^
        user_id.hashCode ^
        nom.hashCode ^
        quantite.hashCode ^
        date_envoie.hashCode ^
        recepteur_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
