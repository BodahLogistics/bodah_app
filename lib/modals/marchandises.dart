// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Marchandises {
  int id;
  String nom;
  int annonce_id;
  String numero_marchandise;
  String quantite;
  int? type_chargement_id;
  String poids;
  int? destinataire_id;
  int nombre_camions;
  DateTime? date_chargement;
  int? devise_id;

  Marchandises({
    required this.id,
    required this.nom,
    required this.annonce_id,
    required this.numero_marchandise,
    required this.quantite,
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
    int? annonce_id,
    String? numero_marchandise,
    String? quantite,
    int? type_chargement_id,
    String? poids,
    int? destinataire_id,
    int? nombre_camions,
    DateTime? date_chargement,
    int? devise_id,
  }) {
    return Marchandises(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      annonce_id: annonce_id ?? this.annonce_id,
      numero_marchandise: numero_marchandise ?? this.numero_marchandise,
      quantite: quantite ?? this.quantite,
      type_chargement_id: type_chargement_id ?? this.type_chargement_id,
      poids: poids ?? this.poids,
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
      'annonce_id': annonce_id,
      'numero_marchandise': numero_marchandise,
      'quantite': quantite,
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
      id: int.tryParse(map['id'].toString()) ??
          0, // Vérification du type et conversion
      nom: map['nom'] as String,
      annonce_id: int.tryParse(map['annonce_id'].toString()) ??
          0, // Conversion en int si nécessaire
      numero_marchandise: map['numero_marchandise'] as String,
      quantite:
          map['quantite'].toString(), // Assurez-vous que c'est bien une chaîne
      type_chargement_id: map['type_chargement_id'] != null
          ? int.tryParse(map['type_chargement_id'].toString())
          : null,
      poids: map['poids'].toString(), // Assurez-vous que c'est bien une chaîne
      destinataire_id: map['destinataire_id'] != null
          ? int.tryParse(map['destinataire_id'].toString())
          : null,
      nombre_camions: int.tryParse(map['nombre_camions'].toString()) ??
          0, // Conversion en int
      date_chargement: map['date_chargement'] != null
          ? DateTime.tryParse(map['date_chargement'].toString())
          : null,
      devise_id: map['devise_id'] != null
          ? int.tryParse(map['devise_id'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Marchandises.fromJson(String source) =>
      Marchandises.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Marchandises(id: $id, nom: $nom, annonce_id: $annonce_id, numero_marchandise: $numero_marchandise, quantite: $quantite, type_chargement_id: $type_chargement_id, poids: $poids, destinataire_id: $destinataire_id, nombre_camions: $nombre_camions, date_chargement: $date_chargement, devise_id: $devise_id)';
  }

  @override
  bool operator ==(covariant Marchandises other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nom == nom &&
        other.annonce_id == annonce_id &&
        other.numero_marchandise == numero_marchandise &&
        other.quantite == quantite &&
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
        annonce_id.hashCode ^
        numero_marchandise.hashCode ^
        quantite.hashCode ^
        type_chargement_id.hashCode ^
        poids.hashCode ^
        destinataire_id.hashCode ^
        nombre_camions.hashCode ^
        date_chargement.hashCode ^
        devise_id.hashCode;
  }
}
