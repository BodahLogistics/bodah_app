// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Signatures {
  int id;
  String path;
  Signatures({
    required this.id,
    required this.path,
  });

  Signatures copyWith({
    int? id,
    String? path,
  }) {
    return Signatures(
      id: id ?? this.id,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
    };
  }

  factory Signatures.fromMap(Map<String, dynamic> map) {
    return Signatures(
      id: map['id'] as int,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Signatures.fromJson(String source) =>
      Signatures.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Signatures(id: $id, path: $path)';

  @override
  bool operator ==(covariant Signatures other) {
    if (identical(this, other)) return true;

    return other.id == id && other.path == path;
  }

  @override
  int get hashCode => id.hashCode ^ path.hashCode;
}
