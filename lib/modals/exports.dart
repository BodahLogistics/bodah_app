// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Exports {
  int id;
  String reference;
  int transport_mode_id;

  Exports({
    required this.id,
    required this.reference,
    required this.transport_mode_id,
  });

  Exports copyWith({
    int? id,
    String? reference,
    int? transport_mode_id,
  }) {
    return Exports(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      transport_mode_id: transport_mode_id ?? this.transport_mode_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reference': reference,
      'transport_mode_id': transport_mode_id,
    };
  }

  factory Exports.fromMap(Map<String, dynamic> map) {
    return Exports(
      id: map['id'] as int,
      reference: map['reference'] as String,
      transport_mode_id: map['transport_mode_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exports.fromJson(String source) =>
      Exports.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Exports(id: $id, reference: $reference, transport_mode_id: $transport_mode_id)';

  @override
  bool operator ==(covariant Exports other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.transport_mode_id == transport_mode_id;
  }

  @override
  int get hashCode =>
      id.hashCode ^ reference.hashCode ^ transport_mode_id.hashCode;
}
