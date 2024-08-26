// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Lta {
  final int id;
  final String path;
  final int modele_id;
  final String modele_type;
  final int deleted;
  final String reference;
  final String? ref;
  final DateTime created_at;
  final DateTime updated_at;
  Lta({
    required this.id,
    required this.path,
    required this.modele_id,
    required this.modele_type,
    required this.deleted,
    required this.reference,
    this.ref,
    required this.created_at,
    required this.updated_at,
  });

  Lta copyWith({
    int? id,
    String? path,
    int? modele_id,
    String? modele_type,
    int? deleted,
    String? reference,
    String? ref,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Lta(
      id: id ?? this.id,
      path: path ?? this.path,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      deleted: deleted ?? this.deleted,
      reference: reference ?? this.reference,
      ref: ref ?? this.ref,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'deleted': deleted,
      'reference': reference,
      'ref': ref,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Lta.fromMap(Map<String, dynamic> map) {
    return Lta(
      id: map['id'] as int,
      path: map['path'] as String,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      deleted: map['deleted'] as int,
      reference: map['reference'] as String,
      ref: map['ref'] != null ? map['ref'] as String : null,
      created_at: DateTime.parse(map['created_at'] as String),
      updated_at: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lta.fromJson(String source) =>
      Lta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Lta(id: $id, path: $path, modele_id: $modele_id, modele_type: $modele_type, deleted: $deleted, reference: $reference, ref: $ref, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant Lta other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.deleted == deleted &&
        other.reference == reference &&
        other.ref == ref &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        deleted.hashCode ^
        reference.hashCode ^
        ref.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
