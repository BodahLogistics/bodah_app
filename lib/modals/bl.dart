// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Bl {
  int id;
  String? path;
  int modele_id;
  String modele_type;
  String reference;
  String? ref;

  Bl({
    required this.id,
    required this.path,
    required this.modele_id,
    required this.modele_type,
    required this.reference,
    this.ref,
  });

  Bl copyWith({
    int? id,
    String? path,
    int? modele_id,
    String? modele_type,
    String? reference,
    String? ref,
  }) {
    return Bl(
      id: id ?? this.id,
      path: path ?? this.path,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      reference: reference ?? this.reference,
      ref: ref ?? this.ref,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'reference': reference,
      'ref': ref,
    };
  }

  factory Bl.fromMap(Map<String, dynamic> map) {
    return Bl(
      id: map['id'] as int,
      path: map['path'] != null ? map['path'] as String : null,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      reference: map['reference'] as String,
      ref: map['ref'] != null ? map['ref'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bl.fromJson(String source) =>
      Bl.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Bl(id: $id, path: $path, modele_id: $modele_id, modele_type: $modele_type, reference: $reference, ref: $ref)';
  }

  @override
  bool operator ==(covariant Bl other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.reference == reference &&
        other.ref == ref;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        reference.hashCode ^
        ref.hashCode;
  }
}
