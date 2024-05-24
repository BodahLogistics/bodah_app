// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Souscriptions {
  final int id;
  final String numero_souscription;
  final int transporteur_id;
  final int deleted;
  final int marchandise_id;
  final DateTime created_at;
  final DateTime updated_at;
  Souscriptions({
    required this.id,
    required this.numero_souscription,
    required this.transporteur_id,
    required this.deleted,
    required this.marchandise_id,
    required this.created_at,
    required this.updated_at,
  });

  Souscriptions copyWith({
    int? id,
    String? numero_souscription,
    int? transporteur_id,
    int? deleted,
    int? marchandise_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Souscriptions(
      id: id ?? this.id,
      numero_souscription: numero_souscription ?? this.numero_souscription,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      deleted: deleted ?? this.deleted,
      marchandise_id: marchandise_id ?? this.marchandise_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_souscription': numero_souscription,
      'transporteur_id': transporteur_id,
      'deleted': deleted,
      'marchandise_id': marchandise_id,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Souscriptions.fromMap(Map<String, dynamic> map) {
    return Souscriptions(
      id: map['id'] as int,
      numero_souscription: map['numero_souscription'] as String,
      transporteur_id: map['transporteur_id'] as int,
      deleted: map['deleted'] as int,
      marchandise_id: map['marchandise_id'] as int,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Souscriptions.fromJson(String source) =>
      Souscriptions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Souscriptions(id: $id, numero_souscription: $numero_souscription, transporteur_id: $transporteur_id, deleted: $deleted, marchandise_id: $marchandise_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Souscriptions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_souscription == numero_souscription &&
        other.transporteur_id == transporteur_id &&
        other.deleted == deleted &&
        other.marchandise_id == marchandise_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_souscription.hashCode ^
        transporteur_id.hashCode ^
        deleted.hashCode ^
        marchandise_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
