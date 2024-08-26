// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Exports {
  final int id;
  final String reference;
  final int transport_mode_id;
  final int expediteur_id;
  final int deleted;
  Exports({
    required this.id,
    required this.reference,
    required this.transport_mode_id,
    required this.expediteur_id,
    required this.deleted,
  });

  Exports copyWith({
    int? id,
    String? reference,
    int? transport_mode_id,
    int? expediteur_id,
    int? deleted,
  }) {
    return Exports(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      transport_mode_id: transport_mode_id ?? this.transport_mode_id,
      expediteur_id: expediteur_id ?? this.expediteur_id,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'transport_mode_id': transport_mode_id,
      'expediteur_id': expediteur_id,
      'deleted': deleted,
    };
  }

  factory Exports.fromMap(Map<String, dynamic> map) {
    return Exports(
      id: map['id'] as int,
      reference: map['reference'] as String,
      transport_mode_id: map['transport_mode_id'] as int,
      expediteur_id: map['expediteur_id'] as int,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exports.fromJson(String source) =>
      Exports.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Exports(id: $id, reference: $reference, transport_mode_id: $transport_mode_id, expediteur_id: $expediteur_id, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Exports other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.transport_mode_id == transport_mode_id &&
        other.expediteur_id == expediteur_id &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        transport_mode_id.hashCode ^
        expediteur_id.hashCode ^
        deleted.hashCode;
  }
}
