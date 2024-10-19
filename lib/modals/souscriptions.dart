// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Souscriptions {
  int id;
  String numero_souscription;
  int transporteur_id;
  int marchandise_id;
  DateTime created_at;

  Souscriptions({
    required this.id,
    required this.numero_souscription,
    required this.transporteur_id,
    required this.marchandise_id,
    required this.created_at,
  });

  Souscriptions copyWith({
    int? id,
    String? numero_souscription,
    int? transporteur_id,
    int? marchandise_id,
    DateTime? created_at,
  }) {
    return Souscriptions(
      id: id ?? this.id,
      numero_souscription: numero_souscription ?? this.numero_souscription,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      marchandise_id: marchandise_id ?? this.marchandise_id,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_souscription': numero_souscription,
      'transporteur_id': transporteur_id,
      'marchandise_id': marchandise_id,
      'created_at': created_at.millisecondsSinceEpoch,
    };
  }

  factory Souscriptions.fromMap(Map<String, dynamic> map) {
    return Souscriptions(
      id: map['id'] as int,
      numero_souscription: map['numero_souscription'] as String,
      transporteur_id: map['transporteur_id'] is String
          ? int.parse(map['transporteur_id'])
          : map['transporteur_id'] as int,
      marchandise_id: map['marchandise_id'] is String
          ? int.parse(map['marchandise_id'])
          : map['marchandise_id'] as int,
      created_at: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Souscriptions.fromJson(String source) =>
      Souscriptions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Souscriptions(id: $id, numero_souscription: $numero_souscription, transporteur_id: $transporteur_id, marchandise_id: $marchandise_id, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant Souscriptions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_souscription == numero_souscription &&
        other.transporteur_id == transporteur_id &&
        other.marchandise_id == marchandise_id &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_souscription.hashCode ^
        transporteur_id.hashCode ^
        marchandise_id.hashCode ^
        created_at.hashCode;
  }
}
