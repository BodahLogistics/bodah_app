// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Signatures {
  final int id;
  final String path;
  final String signable_type;
  final int signable_id;
  Signatures({
    required this.id,
    required this.path,
    required this.signable_type,
    required this.signable_id,
  });

  Signatures copyWith({
    int? id,
    String? path,
    String? signable_type,
    int? signable_id,
  }) {
    return Signatures(
      id: id ?? this.id,
      path: path ?? this.path,
      signable_type: signable_type ?? this.signable_type,
      signable_id: signable_id ?? this.signable_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'signable_type': signable_type,
      'signable_id': signable_id,
    };
  }

  factory Signatures.fromMap(Map<String, dynamic> map) {
    return Signatures(
      id: map['id'] as int,
      path: map['path'] as String,
      signable_type: map['signable_type'] as String,
      signable_id: map['signable_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Signatures.fromJson(String source) =>
      Signatures.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Signatures(id: $id, path: $path, signable_type: $signable_type, signable_id: $signable_id)';
  }

  @override
  bool operator ==(covariant Signatures other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.signable_type == signable_type &&
        other.signable_id == signable_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        signable_type.hashCode ^
        signable_id.hashCode;
  }
}
