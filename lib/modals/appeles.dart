// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Appeles {
  final int id;
  final String path;
  final int expedition_id;
  final int deleted;
  final String? commentaire;
  final String reference;
  final String? doc_id;
  final DateTime created_at;
  final DateTime updated_at;
  Appeles({
    required this.id,
    required this.path,
    required this.expedition_id,
    required this.deleted,
    required this.commentaire,
    required this.reference,
    this.doc_id,
    required this.created_at,
    required this.updated_at,
  });

  Appeles copyWith({
    int? id,
    String? path,
    int? expedition_id,
    int? deleted,
    String? commentaire,
    String? reference,
    String? doc_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Appeles(
      id: id ?? this.id,
      path: path ?? this.path,
      expedition_id: expedition_id ?? this.expedition_id,
      deleted: deleted ?? this.deleted,
      commentaire: commentaire ?? this.commentaire,
      reference: reference ?? this.reference,
      doc_id: doc_id ?? this.doc_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'expedition_id': expedition_id,
      'deleted': deleted,
      'commentaire': commentaire,
      'reference': reference,
      'doc_id': doc_id,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Appeles.fromMap(Map<String, dynamic> map) {
    return Appeles(
      id: map['id'] as int,
      path: map['path'] as String,
      expedition_id: map['expedition_id'] as int,
      deleted: map['deleted'] as int,
      commentaire:
          map['commentaire'] != null ? map['commentaire'] as String : null,
      reference: map['reference'] as String,
      doc_id: map['doc_id'] != null ? map['doc_id'] as String : null,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Appeles.fromJson(String source) =>
      Appeles.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Appeles(id: $id, path: $path, expedition_id: $expedition_id, deleted: $deleted, commentaire: $commentaire, reference: $reference, doc_id: $doc_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Appeles other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.expedition_id == expedition_id &&
        other.deleted == deleted &&
        other.commentaire == commentaire &&
        other.reference == reference &&
        other.doc_id == doc_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        expedition_id.hashCode ^
        deleted.hashCode ^
        commentaire.hashCode ^
        reference.hashCode ^
        doc_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
