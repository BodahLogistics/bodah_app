// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class BonCommandes {
  int id;
  String numero_bon_commande;
  int is_validated;
  int delai_chargement;
  double amende_delai_chargement;
  double amende_dechargement;
  double montant_paye;
  int annonce_id;
  int donneur_ordre_id;
  int entite_facture_id;
  int? signature_id;
  int? type_paiement_id;

  BonCommandes({
    required this.id,
    required this.numero_bon_commande,
    required this.is_validated,
    required this.delai_chargement,
    required this.amende_delai_chargement,
    required this.amende_dechargement,
    required this.montant_paye,
    required this.annonce_id,
    required this.donneur_ordre_id,
    required this.entite_facture_id,
    this.signature_id,
    this.type_paiement_id,
  });

  BonCommandes copyWith({
    int? id,
    String? numero_bon_commande,
    int? is_validated,
    int? delai_chargement,
    double? amende_delai_chargement,
    double? amende_dechargement,
    double? montant_paye,
    int? annonce_id,
    int? donneur_ordre_id,
    int? entite_facture_id,
    int? signature_id,
    int? type_paiement_id,
  }) {
    return BonCommandes(
      id: id ?? this.id,
      numero_bon_commande: numero_bon_commande ?? this.numero_bon_commande,
      is_validated: is_validated ?? this.is_validated,
      delai_chargement: delai_chargement ?? this.delai_chargement,
      amende_delai_chargement:
          amende_delai_chargement ?? this.amende_delai_chargement,
      amende_dechargement: amende_dechargement ?? this.amende_dechargement,
      montant_paye: montant_paye ?? this.montant_paye,
      annonce_id: annonce_id ?? this.annonce_id,
      donneur_ordre_id: donneur_ordre_id ?? this.donneur_ordre_id,
      entite_facture_id: entite_facture_id ?? this.entite_facture_id,
      signature_id: signature_id ?? this.signature_id,
      type_paiement_id: type_paiement_id ?? this.type_paiement_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_bon_commande': numero_bon_commande,
      'is_validated': is_validated,
      'delai_chargement': delai_chargement,
      'amende_delai_chargement': amende_delai_chargement,
      'amende_dechargement': amende_dechargement,
      'montant_paye': montant_paye,
      'annonce_id': annonce_id,
      'donneur_ordre_id': donneur_ordre_id,
      'entite_facture_id': entite_facture_id,
      'signature_id': signature_id,
      'type_paiement_id': type_paiement_id,
    };
  }

  factory BonCommandes.fromMap(Map<String, dynamic> map) {
    return BonCommandes(
      id: map['id'] as int,
      numero_bon_commande: map['numero_bon_commande'] as String,
      is_validated: map['is_validated'] as int,
      delai_chargement: map['delai_chargement'] as int,
      amende_delai_chargement: map['amende_delai_chargement'] as double,
      amende_dechargement: map['amende_dechargement'] as double,
      montant_paye: map['montant_paye'] as double,
      annonce_id: map['annonce_id'] as int,
      donneur_ordre_id: map['donneur_ordre_id'] as int,
      entite_facture_id: map['entite_facture_id'] as int,
      signature_id:
          map['signature_id'] != null ? map['signature_id'] as int : null,
      type_paiement_id: map['type_paiement_id'] != null
          ? map['type_paiement_id'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BonCommandes.fromJson(String source) =>
      BonCommandes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BonCommandes(id: $id, numero_bon_commande: $numero_bon_commande, is_validated: $is_validated, delai_chargement: $delai_chargement, amende_delai_chargement: $amende_delai_chargement, amende_dechargement: $amende_dechargement, montant_paye: $montant_paye, annonce_id: $annonce_id, donneur_ordre_id: $donneur_ordre_id, entite_facture_id: $entite_facture_id, signature_id: $signature_id, type_paiement_id: $type_paiement_id)';
  }

  @override
  bool operator ==(covariant BonCommandes other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_bon_commande == numero_bon_commande &&
        other.is_validated == is_validated &&
        other.delai_chargement == delai_chargement &&
        other.amende_delai_chargement == amende_delai_chargement &&
        other.amende_dechargement == amende_dechargement &&
        other.montant_paye == montant_paye &&
        other.annonce_id == annonce_id &&
        other.donneur_ordre_id == donneur_ordre_id &&
        other.entite_facture_id == entite_facture_id &&
        other.signature_id == signature_id &&
        other.type_paiement_id == type_paiement_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_bon_commande.hashCode ^
        is_validated.hashCode ^
        delai_chargement.hashCode ^
        amende_delai_chargement.hashCode ^
        amende_dechargement.hashCode ^
        montant_paye.hashCode ^
        annonce_id.hashCode ^
        donneur_ordre_id.hashCode ^
        entite_facture_id.hashCode ^
        signature_id.hashCode ^
        type_paiement_id.hashCode;
  }
}
