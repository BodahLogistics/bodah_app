// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:intl/intl.dart';

class Chargement {
  int id;
  int modele_id;
  String modele_type;
  DateTime debut;
  DateTime? fin;
  Chargement({
    required this.id,
    required this.modele_id,
    required this.modele_type,
    required this.debut,
    this.fin,
  });

  Chargement copyWith({
    int? id,
    int? modele_id,
    String? modele_type,
    DateTime? debut,
    DateTime? fin,
  }) {
    return Chargement(
      id: id ?? this.id,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      debut: debut ?? this.debut,
      fin: fin ?? this.fin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'debut': debut.millisecondsSinceEpoch,
      'fin': fin?.millisecondsSinceEpoch,
    };
  }

  factory Chargement.fromMap(Map<String, dynamic> map) {
    final dateFormatDDMMYY = DateFormat('dd/MM/yy'); // Format pour "18/10/18"
    final dateFormatYYYYMMDD =
        DateFormat('yyyy-MM-dd'); // Format pour "2024-10-18"

    // Utilisation de try-catch pour tenter les deux formats
    DateTime parseDate(String date) {
      try {
        return dateFormatYYYYMMDD
            .parse(date); // Essayer avec le format "yyyy-MM-dd"
      } catch (e) {
        return dateFormatDDMMYY
            .parse(date); // Si échec, essayer avec le format "dd/MM/yy"
      }
    }

    return Chargement(
      id: map['id'] as int,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      debut: parseDate(map['debut'] as String), // Convertir la date de début
      fin: map['fin'] != null
          ? parseDate(map['fin'] as String)
          : null, // Convertir la date de fin, si elle existe
    );
  }

  String toJson() => json.encode(toMap());

  factory Chargement.fromJson(String source) =>
      Chargement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chargement(id: $id, modele_id: $modele_id, modele_type: $modele_type, debut: $debut, fin: $fin)';
  }

  @override
  bool operator ==(covariant Chargement other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.debut == debut &&
        other.fin == fin;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        debut.hashCode ^
        fin.hashCode;
  }
}
