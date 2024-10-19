// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Import {
  int id;
  String reference;
  int transport_mode_id;

  Import({
    required this.id,
    required this.reference,
    required this.transport_mode_id,
  });

  Import copyWith({
    int? id,
    String? reference,
    int? transport_mode_id,
  }) {
    return Import(
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

  factory Import.fromMap(Map<String, dynamic> map) {
    return Import(
      id: map['id'] as int,
      reference: map['reference'] as String,
      transport_mode_id: map['transport_mode_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Import.fromJson(String source) =>
      Import.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Import(id: $id, reference: $reference, transport_mode_id: $transport_mode_id)';

  @override
  bool operator ==(covariant Import other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.reference == reference &&
        other.transport_mode_id == transport_mode_id;
  }

  @override
  int get hashCode =>
      id.hashCode ^ reference.hashCode ^ transport_mode_id.hashCode;
}
