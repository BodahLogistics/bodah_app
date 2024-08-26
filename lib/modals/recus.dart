// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Recus {
  final int id;
  final String path;
  final String reference;
  final int modele_id;
  final String modele_type;
  final int deleted;
  final String? doc_id;
  final DateTime created_at;
  final DateTime updated_at;
  Recus({
    required this.id,
    required this.path,
    required this.reference,
    required this.modele_id,
    required this.modele_type,
    required this.deleted,
    this.doc_id,
    required this.created_at,
    required this.updated_at,
  });

  Recus copyWith({
    int? id,
    String? path,
    String? reference,
    int? modele_id,
    String? modele_type,
    int? deleted,
    String? doc_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Recus(
      id: id ?? this.id,
      path: path ?? this.path,
      reference: reference ?? this.reference,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      deleted: deleted ?? this.deleted,
      doc_id: doc_id ?? this.doc_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'reference': reference,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'deleted': deleted,
      'doc_id': doc_id,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Recus.fromMap(Map<String, dynamic> map) {
    return Recus(
      id: map['id'] as int,
      path: map['path'] as String,
      reference: map['reference'] as String,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      deleted: map['deleted'] as int,
      doc_id: map['doc_id'] != null ? map['doc_id'] as String : null,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recus.fromJson(String source) =>
      Recus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recus(id: $id, path: $path, reference: $reference, modele_id: $modele_id, modele_type: $modele_type, deleted: $deleted, doc_id: $doc_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Recus other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.reference == reference &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.deleted == deleted &&
        other.doc_id == doc_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        reference.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        deleted.hashCode ^
        doc_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
