// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Marchandises {
  final int id;
  final String nom;
  final String? description;
  final String? autres_details;
  final int annonce_id;
  final String numero_marchandise;
  final int deleted;
  final int quantite;
  final int unite_id;
  final int? type_chargement_id;
  final double poids;
  final int? destinataire_id;
  final int nombre_camions;
  final DateTime? date_chargement;
  final int? devise_id;

  Marchandises({
    required this.id,
    required this.nom,
    this.description,
    this.autres_details,
    required this.annonce_id,
    required this.numero_marchandise,
    required this.deleted,
    required this.quantite,
    required this.unite_id,
    this.type_chargement_id,
    required this.poids,
    this.destinataire_id,
    required this.nombre_camions,
    this.date_chargement,
    this.devise_id,
  });

  Marchandises copyWith({
    int? id,
    String? nom,
    String? description,
    String? autres_details,
    int? annonce_id,
    String? numero_marchandise,
    int? deleted,
    int? quantite,
    int? unite_id,
    int? type_chargement_id,
    int? poids,
    int? destinataire_id,
    int? nombre_camions,
    DateTime? date_chargement,
    int? devise_id,
  }) {
    return Marchandises(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      description: description ?? this.description,
      autres_details: autres_details ?? this.autres_details,
      annonce_id: annonce_id ?? this.annonce_id,
      numero_marchandise: numero_marchandise ?? this.numero_marchandise,
      deleted: deleted ?? this.deleted,
      quantite: quantite ?? this.quantite,
      unite_id: unite_id ?? this.unite_id,
      type_chargement_id: type_chargement_id ?? this.type_chargement_id,
      poids: this.poids,
      destinataire_id: destinataire_id ?? this.destinataire_id,
      nombre_camions: nombre_camions ?? this.nombre_camions,
      date_chargement: date_chargement ?? this.date_chargement,
      devise_id: devise_id ?? this.devise_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nom': nom,
      'description': description,
      'autres_details': autres_details,
      'annonce_id': annonce_id,
      'numero_marchandise': numero_marchandise,
      'deleted': deleted,
      'quantite': quantite,
      'unite_id': unite_id,
      'type_chargement_id': type_chargement_id,
      'poids': poids,
      'destinataire_id': destinataire_id,
      'nombre_camions': nombre_camions,
      'date_chargement': date_chargement?.millisecondsSinceEpoch,
      'devise_id': devise_id,
    };
  }

  factory Marchandises.fromMap(Map<String, dynamic> map) {
    return Marchandises(
      id: map['id'] as int,
      nom: map['nom'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      autres_details: map['autres_details'] != null
          ? map['autres_details'] as String
          : null,
      annonce_id: map['annonce_id'] as int,
      numero_marchandise: map['numero_marchandise'] as String,
      deleted: map['deleted'] as int,
      quantite: map['quantite'] as int,
      unite_id: map['unite_id'] as int,
      type_chargement_id: map['type_chargement_id'] != null
          ? map['type_chargement_id'] as int
          : null,
      poids: map['poids'] as double,
      destinataire_id:
          map['destinataire_id'] != null ? map['destinataire_id'] as int : null,
      nombre_camions: map['nombre_camions'] as int,
      date_chargement: map['date_chargement'] != null
          ? DateTime.parse(map['date_chargement'] as String)
          : null,
      devise_id: map['devise_id'] != null ? map['devise_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Marchandises.fromJson(String source) =>
      Marchandises.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Marchandises(id: $id, nom: $nom, description: $description, autres_details: $autres_details, annonce_id: $annonce_id, numero_marchandise: $numero_marchandise, deleted: $deleted, quantite: $quantite, unite_id: $unite_id, type_chargement_id: $type_chargement_id, poids: $poids, destinataire_id: $destinataire_id, nombre_camions: $nombre_camions, date_chargement: $date_chargement, devise_id: $devise_id)';
  }

  @override
  bool operator ==(covariant Marchandises other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nom == nom &&
        other.description == description &&
        other.autres_details == autres_details &&
        other.annonce_id == annonce_id &&
        other.numero_marchandise == numero_marchandise &&
        other.deleted == deleted &&
        other.quantite == quantite &&
        other.unite_id == unite_id &&
        other.type_chargement_id == type_chargement_id &&
        other.poids == poids &&
        other.destinataire_id == destinataire_id &&
        other.nombre_camions == nombre_camions &&
        other.date_chargement == date_chargement &&
        other.devise_id == devise_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        description.hashCode ^
        autres_details.hashCode ^
        annonce_id.hashCode ^
        numero_marchandise.hashCode ^
        deleted.hashCode ^
        quantite.hashCode ^
        unite_id.hashCode ^
        type_chargement_id.hashCode ^
        poids.hashCode ^
        destinataire_id.hashCode ^
        nombre_camions.hashCode ^
        date_chargement.hashCode ^
        devise_id.hashCode;
  }
}
