// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Chargement {
  final int id;
  final int modele_id;
  final String modele_type;
  final DateTime debut;
  final DateTime? fin;
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
    return Chargement(
      id: map['id'] as int,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      debut: DateTime.parse(map['debut'] as String),
      fin: map['fin'] != null ? DateTime.parse(map['fin'] as String) : null,
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
