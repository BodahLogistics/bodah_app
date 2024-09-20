// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class TransportLiaisons {
  int id;
  DateTime? stop_date;
  int proprietaire_id;
  int transporteur_id;
  int during;
  TransportLiaisons({
    required this.id,
    required this.stop_date,
    required this.proprietaire_id,
    required this.transporteur_id,
    required this.during,
  });

  TransportLiaisons copyWith({
    int? id,
    DateTime? stop_date,
    int? proprietaire_id,
    int? transporteur_id,
    int? during,
  }) {
    return TransportLiaisons(
      id: id ?? this.id,
      stop_date: stop_date ?? this.stop_date,
      proprietaire_id: proprietaire_id ?? this.proprietaire_id,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      during: during ?? this.during,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stop_date': stop_date?.millisecondsSinceEpoch,
      'proprietaire_id': proprietaire_id,
      'transporteur_id': transporteur_id,
      'during': during,
    };
  }

  factory TransportLiaisons.fromMap(Map<String, dynamic> map) {
    return TransportLiaisons(
      id: map['id'] as int,
      stop_date: map['stop_date'] != null
          ? DateTime.parse(map['stop_date'] as String)
          : null,
      proprietaire_id: map['proprietaire_id'] as int,
      transporteur_id: map['transporteur_id'] as int,
      during: map['during'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportLiaisons.fromJson(String source) =>
      TransportLiaisons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransportLiaisons(id: $id, stop_date: $stop_date, proprietaire_id: $proprietaire_id, transporteur_id: $transporteur_id, during: $during)';
  }

  @override
  bool operator ==(covariant TransportLiaisons other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.stop_date == stop_date &&
        other.proprietaire_id == proprietaire_id &&
        other.transporteur_id == transporteur_id &&
        other.during == during;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        stop_date.hashCode ^
        proprietaire_id.hashCode ^
        transporteur_id.hashCode ^
        during.hashCode;
  }
}
