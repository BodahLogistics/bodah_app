// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Recus {
  final int id;
  final String path;
  final String reference;
  final int expedition_id;
  final int deleted;
  final String? commentaire;
  final String? doc_id;
  final DateTime created_at;
  final DateTime updated_at;
  Recus({
    required this.id,
    required this.path,
    required this.reference,
    required this.expedition_id,
    required this.deleted,
    this.commentaire,
    this.doc_id,
    required this.created_at,
    required this.updated_at,
  });

  Recus copyWith({
    int? id,
    String? path,
    String? reference,
    int? expedition_id,
    int? deleted,
    String? commentaire,
    String? doc_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Recus(
      id: id ?? this.id,
      path: path ?? this.path,
      reference: reference ?? this.reference,
      expedition_id: expedition_id ?? this.expedition_id,
      deleted: deleted ?? this.deleted,
      commentaire: commentaire ?? this.commentaire,
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
      'expedition_id': expedition_id,
      'deleted': deleted,
      'commentaire': commentaire,
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
      expedition_id: map['expedition_id'] as int,
      deleted: map['deleted'] as int,
      commentaire:
          map['commentaire'] != null ? map['commentaire'] as String : null,
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
    return 'Recus(id: $id, path: $path, reference: $reference, expedition_id: $expedition_id, deleted: $deleted, commentaire: $commentaire, doc_id: $doc_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Recus other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.reference == reference &&
        other.expedition_id == expedition_id &&
        other.deleted == deleted &&
        other.commentaire == commentaire &&
        other.doc_id == doc_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        reference.hashCode ^
        expedition_id.hashCode ^
        deleted.hashCode ^
        commentaire.hashCode ^
        doc_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
