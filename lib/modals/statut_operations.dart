// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class StatutOperations {
  final int id;
  final String modele_type;
  final int modele_id;
  final DateTime date;
  final int statut_id;
  StatutOperations({
    required this.id,
    required this.modele_type,
    required this.modele_id,
    required this.date,
    required this.statut_id,
  });

  StatutOperations copyWith({
    int? id,
    String? modele_type,
    int? modele_id,
    DateTime? date,
    int? statut_id,
  }) {
    return StatutOperations(
      id: id ?? this.id,
      modele_type: modele_type ?? this.modele_type,
      modele_id: modele_id ?? this.modele_id,
      date: date ?? this.date,
      statut_id: statut_id ?? this.statut_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modele_type': modele_type,
      'modele_id': modele_id,
      'date': date.millisecondsSinceEpoch,
      'statut_id': statut_id,
    };
  }

  factory StatutOperations.fromMap(Map<String, dynamic> map) {
    return StatutOperations(
      id: map['id'] as int,
      modele_type: map['modele_type'] as String,
      modele_id: map['modele_id'] as int,
      date: DateTime.parse(map['date'] as String),
      statut_id: map['statut_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatutOperations.fromJson(String source) =>
      StatutOperations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatutOperations(id: $id, modele_type: $modele_type, modele_id: $modele_id, date: $date, statut_id: $statut_id)';
  }

  @override
  bool operator ==(covariant StatutOperations other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.modele_type == modele_type &&
        other.modele_id == modele_id &&
        other.date == date &&
        other.statut_id == statut_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        modele_type.hashCode ^
        modele_id.hashCode ^
        date.hashCode ^
        statut_id.hashCode;
  }
}
