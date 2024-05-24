// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Tdos {
  final int id;
  final String path;
  final int expedition_id;
  final int deleted;
  final String reference;
  final String? doc_id;
  final String? commentaire;
  final DateTime created_at;
  final DateTime updated_at;
  Tdos({
    required this.id,
    required this.path,
    required this.expedition_id,
    required this.deleted,
    required this.reference,
    this.doc_id,
    this.commentaire,
    required this.created_at,
    required this.updated_at,
  });

  Tdos copyWith({
    int? id,
    String? path,
    int? expedition_id,
    int? deleted,
    String? reference,
    String? doc_id,
    String? commentaire,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Tdos(
      id: id ?? this.id,
      path: path ?? this.path,
      expedition_id: expedition_id ?? this.expedition_id,
      deleted: deleted ?? this.deleted,
      reference: reference ?? this.reference,
      doc_id: doc_id ?? this.doc_id,
      commentaire: commentaire ?? this.commentaire,
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
      'reference': reference,
      'doc_id': doc_id,
      'commentaire': commentaire,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Tdos.fromMap(Map<String, dynamic> map) {
    return Tdos(
      id: map['id'] as int,
      path: map['path'] as String,
      expedition_id: map['expedition_id'] as int,
      deleted: map['deleted'] as int,
      reference: map['reference'] as String,
      doc_id: map['doc_id'] != null ? map['doc_id'] as String : null,
      commentaire:
          map['commentaire'] != null ? map['commentaire'] as String : null,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tdos.fromJson(String source) =>
      Tdos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tdos(id: $id, path: $path, expedition_id: $expedition_id, deleted: $deleted, reference: $reference, doc_id: $doc_id, commentaire: $commentaire, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Tdos other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.expedition_id == expedition_id &&
        other.deleted == deleted &&
        other.reference == reference &&
        other.doc_id == doc_id &&
        other.commentaire == commentaire &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        expedition_id.hashCode ^
        deleted.hashCode ^
        reference.hashCode ^
        doc_id.hashCode ^
        commentaire.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
