// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class BonCommandes {
  final int id;
  final String numero_bon_commande;
  final int is_validated;
  final String? description;
  final int delai_chargement;
  final double amende_delai_chargement;
  final double amende_dechargement;
  final double? montant_paye;
  final int annonce_id;
  final int donneur_ordre_id;
  final int entite_facture_id;
  final int deleted;
  final DateTime created_at;
  final DateTime updated_at;
  BonCommandes({
    required this.id,
    required this.numero_bon_commande,
    required this.is_validated,
    required this.description,
    required this.delai_chargement,
    required this.amende_delai_chargement,
    required this.amende_dechargement,
    required this.montant_paye,
    required this.annonce_id,
    required this.donneur_ordre_id,
    required this.entite_facture_id,
    required this.deleted,
    required this.created_at,
    required this.updated_at,
  });

  BonCommandes copyWith({
    int? id,
    String? numero_bon_commande,
    int? is_validated,
    String? description,
    int? delai_chargement,
    double? amende_delai_chargement,
    double? amende_dechargement,
    double? montant_paye,
    int? annonce_id,
    int? donneur_ordre_id,
    int? entite_facture_id,
    int? deleted,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return BonCommandes(
      id: id ?? this.id,
      numero_bon_commande: numero_bon_commande ?? this.numero_bon_commande,
      is_validated: is_validated ?? this.is_validated,
      description: description ?? this.description,
      delai_chargement: delai_chargement ?? this.delai_chargement,
      amende_delai_chargement:
          amende_delai_chargement ?? this.amende_delai_chargement,
      amende_dechargement: amende_dechargement ?? this.amende_dechargement,
      montant_paye: montant_paye ?? this.montant_paye,
      annonce_id: annonce_id ?? this.annonce_id,
      donneur_ordre_id: donneur_ordre_id ?? this.donneur_ordre_id,
      entite_facture_id: entite_facture_id ?? this.entite_facture_id,
      deleted: deleted ?? this.deleted,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_bon_commande': numero_bon_commande,
      'is_validated': is_validated,
      'description': description,
      'delai_chargement': delai_chargement,
      'amende_delai_chargement': amende_delai_chargement,
      'amende_dechargement': amende_dechargement,
      'montant_paye': montant_paye,
      'annonce_id': annonce_id,
      'donneur_ordre_id': donneur_ordre_id,
      'entite_facture_id': entite_facture_id,
      'deleted': deleted,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory BonCommandes.fromMap(Map<String, dynamic> map) {
    return BonCommandes(
      id: map['id'] as int,
      numero_bon_commande: map['numero_bon_commande'] as String,
      is_validated: map['is_validated'] as int,
      description:
          map['description'] != null ? map['description'] as String : null,
      delai_chargement: map['delai_chargement'] as int,
      amende_delai_chargement: map['amende_delai_chargement'] as double,
      amende_dechargement: map['amende_dechargement'] as double,
      montant_paye:
          map['montant_paye'] != null ? map['montant_paye'] as double : null,
      annonce_id: map['annonce_id'] as int,
      donneur_ordre_id: map['donneur_ordre_id'] as int,
      entite_facture_id: map['entite_facture_id'] as int,
      deleted: map['deleted'] as int,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BonCommandes.fromJson(String source) =>
      BonCommandes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BonCommandes(id: $id, numero_bon_commande: $numero_bon_commande, is_validated: $is_validated, description: $description, delai_chargement: $delai_chargement, amende_delai_chargement: $amende_delai_chargement, amende_dechargement: $amende_dechargement, montant_paye: $montant_paye, annonce_id: $annonce_id, donneur_ordre_id: $donneur_ordre_id, entite_facture_id: $entite_facture_id, deleted: $deleted, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant BonCommandes other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_bon_commande == numero_bon_commande &&
        other.is_validated == is_validated &&
        other.description == description &&
        other.delai_chargement == delai_chargement &&
        other.amende_delai_chargement == amende_delai_chargement &&
        other.amende_dechargement == amende_dechargement &&
        other.montant_paye == montant_paye &&
        other.annonce_id == annonce_id &&
        other.donneur_ordre_id == donneur_ordre_id &&
        other.entite_facture_id == entite_facture_id &&
        other.deleted == deleted &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_bon_commande.hashCode ^
        is_validated.hashCode ^
        description.hashCode ^
        delai_chargement.hashCode ^
        amende_delai_chargement.hashCode ^
        amende_dechargement.hashCode ^
        montant_paye.hashCode ^
        annonce_id.hashCode ^
        donneur_ordre_id.hashCode ^
        entite_facture_id.hashCode ^
        deleted.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
