// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Interchanges {
  int id;
  String path;
  int modele_id;
  String modele_type;
  String reference;
  String? doc_id;

  Interchanges({
    required this.id,
    required this.path,
    required this.modele_id,
    required this.modele_type,
    required this.reference,
    this.doc_id,
  });

  Interchanges copyWith({
    int? id,
    String? path,
    int? modele_id,
    String? modele_type,
    String? reference,
    String? doc_id,
  }) {
    return Interchanges(
      id: id ?? this.id,
      path: path ?? this.path,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      reference: reference ?? this.reference,
      doc_id: doc_id ?? this.doc_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'reference': reference,
      'doc_id': doc_id,
    };
  }

  factory Interchanges.fromMap(Map<String, dynamic> map) {
    return Interchanges(
      id: map['id'] as int,
      path: map['path'] as String,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      reference: map['reference'] as String,
      doc_id: map['doc_id'] != null ? map['doc_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Interchanges.fromJson(String source) =>
      Interchanges.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Interchanges(id: $id, path: $path, modele_id: $modele_id, modele_type: $modele_type, reference: $reference, doc_id: $doc_id)';
  }

  @override
  bool operator ==(covariant Interchanges other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.reference == reference &&
        other.doc_id == doc_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        reference.hashCode ^
        doc_id.hashCode;
  }
}
