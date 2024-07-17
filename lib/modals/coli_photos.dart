// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class ColiPhotos {
  final int id;
  final String path;
  final int voiture_id;
  ColiPhotos({
    required this.id,
    required this.path,
    required this.voiture_id,
  });

  ColiPhotos copyWith({
    int? id,
    String? path,
    int? voiture_id,
  }) {
    return ColiPhotos(
      id: id ?? this.id,
      path: path ?? this.path,
      voiture_id: voiture_id ?? this.voiture_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'voiture_id': voiture_id,
    };
  }

  factory ColiPhotos.fromMap(Map<String, dynamic> map) {
    return ColiPhotos(
      id: map['id'] as int,
      path: map['path'] as String,
      voiture_id: map['voiture_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColiPhotos.fromJson(String source) =>
      ColiPhotos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ColiPhotos(id: $id, path: $path, voiture_id: $voiture_id)';

  @override
  bool operator ==(covariant ColiPhotos other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.voiture_id == voiture_id;
  }

  @override
  int get hashCode => id.hashCode ^ path.hashCode ^ voiture_id.hashCode;
}
