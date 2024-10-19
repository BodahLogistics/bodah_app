// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class VoiturePhotos {
  int id;
  int voiture_id;
  String path;
  VoiturePhotos({
    required this.id,
    required this.voiture_id,
    required this.path,
  });

  VoiturePhotos copyWith({
    int? id,
    int? voiture_id,
    String? path,
  }) {
    return VoiturePhotos(
      id: id ?? this.id,
      voiture_id: voiture_id ?? this.voiture_id,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'voiture_id': voiture_id,
      'path': path,
    };
  }

  factory VoiturePhotos.fromMap(Map<String, dynamic> map) {
    return VoiturePhotos(
      id: map['id'] as int,
      voiture_id: map['voiture_id'] as int,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VoiturePhotos.fromJson(String source) =>
      VoiturePhotos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VoiturePhotos(id: $id, voiture_id: $voiture_id, path: $path)';

  @override
  bool operator ==(covariant VoiturePhotos other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.voiture_id == voiture_id &&
        other.path == path;
  }

  @override
  int get hashCode => id.hashCode ^ voiture_id.hashCode ^ path.hashCode;
}
