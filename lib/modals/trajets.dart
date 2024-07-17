// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Trajets {
  final int id;
  final String reference;
  final int transporteur_id;
  final int voiture_id;
  final DateTime date_depart;
  final int pay_dep_id;
  final int pay_dest_id;
  final int dep_depart_id;
  final int dep_dest_id;
  final int com_dep_id;
  final int com_dest_id;
  final int arrond_dep_id;
  final int arrond_dest_id;
  final int quart_dep_id;
  final int quart_dest_id;
  final DateTime created_at;
  final DateTime updated_at;
  Trajets({
    required this.id,
    required this.reference,
    required this.transporteur_id,
    required this.voiture_id,
    required this.date_depart,
    required this.pay_dep_id,
    required this.pay_dest_id,
    required this.dep_depart_id,
    required this.dep_dest_id,
    required this.com_dep_id,
    required this.com_dest_id,
    required this.arrond_dep_id,
    required this.arrond_dest_id,
    required this.quart_dep_id,
    required this.quart_dest_id,
    required this.created_at,
    required this.updated_at,
  });

  Trajets copyWith({
    int? id,
    String? reference,
    int? transporteur_id,
    int? voiture_id,
    DateTime? date_depart,
    int? pay_dep_id,
    int? pay_dest_id,
    int? dep_depart_id,
    int? dep_dest_id,
    int? com_dep_id,
    int? com_dest_id,
    int? arrond_dep_id,
    int? arrond_dest_id,
    int? quart_dep_id,
    int? quart_dest_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Trajets(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      voiture_id: voiture_id ?? this.voiture_id,
      date_depart: date_depart ?? this.date_depart,
      pay_dep_id: pay_dep_id ?? this.pay_dep_id,
      pay_dest_id: pay_dest_id ?? this.pay_dest_id,
      dep_depart_id: dep_depart_id ?? this.dep_depart_id,
      dep_dest_id: dep_dest_id ?? this.dep_dest_id,
      com_dep_id: com_dep_id ?? this.com_dep_id,
      com_dest_id: com_dest_id ?? this.com_dest_id,
      arrond_dep_id: arrond_dep_id ?? this.arrond_dep_id,
      arrond_dest_id: arrond_dest_id ?? this.arrond_dest_id,
      quart_dep_id: quart_dep_id ?? this.quart_dep_id,
      quart_dest_id: quart_dest_id ?? this.quart_dest_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'transporteur_id': transporteur_id,
      'voiture_id': voiture_id,
      'date_depart': date_depart.millisecondsSinceEpoch,
      'pay_dep_id': pay_dep_id,
      'pay_dest_id': pay_dest_id,
      'dep_depart_id': dep_depart_id,
      'dep_dest_id': dep_dest_id,
      'com_dep_id': com_dep_id,
      'com_dest_id': com_dest_id,
      'arrond_dep_id': arrond_dep_id,
      'arrond_dest_id': arrond_dest_id,
      'quart_dep_id': quart_dep_id,
      'quart_dest_id': quart_dest_id,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Trajets.fromMap(Map<String, dynamic> map) {
    return Trajets(
      id: map['id'] as int,
      reference: map['reference'] as String,
      transporteur_id: map['transporteur_id'] as int,
      voiture_id: map['voiture_id'] as int,
      date_depart: DateTime.parse(map['date_depart'] as String),
      pay_dep_id: map['pay_dep_id'] as int,
      pay_dest_id: map['pay_dest_id'] as int,
      dep_depart_id: map['dep_depart_id'] as int,
      dep_dest_id: map['dep_dest_id'] as int,
      com_dep_id: map['com_dep_id'] as int,
      com_dest_id: map['com_dest_id'] as int,
      arrond_dep_id: map['arrond_dep_id'] as int,
      arrond_dest_id: map['arrond_dest_id'] as int,
      quart_dep_id: map['quart_dep_id'] as int,
      quart_dest_id: map['quart_dest_id'] as int,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Trajets.fromJson(String source) =>
      Trajets.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Trajets(id: $id, reference: $reference, transporteur_id: $transporteur_id, voiture_id: $voiture_id, date_depart: $date_depart, pay_dep_id: $pay_dep_id, pay_dest_id: $pay_dest_id, dep_depart_id: $dep_depart_id, dep_dest_id: $dep_dest_id, com_dep_id: $com_dep_id, com_dest_id: $com_dest_id, arrond_dep_id: $arrond_dep_id, arrond_dest_id: $arrond_dest_id, quart_dep_id: $quart_dep_id, quart_dest_id: $quart_dest_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Trajets other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.transporteur_id == transporteur_id &&
        other.voiture_id == voiture_id &&
        other.date_depart == date_depart &&
        other.pay_dep_id == pay_dep_id &&
        other.pay_dest_id == pay_dest_id &&
        other.dep_depart_id == dep_depart_id &&
        other.dep_dest_id == dep_dest_id &&
        other.com_dep_id == com_dep_id &&
        other.com_dest_id == com_dest_id &&
        other.arrond_dep_id == arrond_dep_id &&
        other.arrond_dest_id == arrond_dest_id &&
        other.quart_dep_id == quart_dep_id &&
        other.quart_dest_id == quart_dest_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        transporteur_id.hashCode ^
        voiture_id.hashCode ^
        date_depart.hashCode ^
        pay_dep_id.hashCode ^
        pay_dest_id.hashCode ^
        dep_depart_id.hashCode ^
        dep_dest_id.hashCode ^
        com_dep_id.hashCode ^
        com_dest_id.hashCode ^
        arrond_dep_id.hashCode ^
        arrond_dest_id.hashCode ^
        quart_dep_id.hashCode ^
        quart_dest_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
