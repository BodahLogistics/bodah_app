// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Recus {
  int id;
  String path;
  String reference;
  int modele_id;
  String modele_type;
  String? doc_id;

  Recus({
    required this.id,
    required this.path,
    required this.reference,
    required this.modele_id,
    required this.modele_type,
    this.doc_id,
  });

  Recus copyWith({
    int? id,
    String? path,
    String? reference,
    int? modele_id,
    String? modele_type,
    String? doc_id,
  }) {
    return Recus(
      id: id ?? this.id,
      path: path ?? this.path,
      reference: reference ?? this.reference,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      doc_id: doc_id ?? this.doc_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'reference': reference,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'doc_id': doc_id,
    };
  }

  factory Recus.fromMap(Map<String, dynamic> map) {
    return Recus(
      id: map['id'] as int,
      path: map['path'] as String,
      reference: map['reference'] as String,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      doc_id: map['doc_id'] != null ? map['doc_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recus.fromJson(String source) =>
      Recus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recus(id: $id, path: $path, reference: $reference, modele_id: $modele_id, modele_type: $modele_type, doc_id: $doc_id)';
  }

  @override
  bool operator ==(covariant Recus other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.reference == reference &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.doc_id == doc_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        reference.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        doc_id.hashCode;
  }
}
