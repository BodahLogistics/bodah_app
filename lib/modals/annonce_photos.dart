// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, unnecessary_cast, prefer_interpolation_to_compose_strings
import 'dart:convert';

class AnnoncePhotos {
  int id;
  String image_path;
  int marchandise_id;

  AnnoncePhotos({
    required this.id,
    required this.image_path,
    required this.marchandise_id,
  });

  AnnoncePhotos copyWith({
    int? id,
    String? image_path,
    int? marchandise_id,
  }) {
    return AnnoncePhotos(
      id: id ?? this.id,
      image_path: image_path ?? this.image_path,
      marchandise_id: marchandise_id ?? this.marchandise_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_path': image_path,
      'marchandise_id': marchandise_id,
    };
  }

  factory AnnoncePhotos.fromMap(Map<String, dynamic> map) {
    return AnnoncePhotos(
      id: map['id'] != null
          ? map['id'] as int
          : 0, // valeur par défaut 0 si null
      image_path: map['image_path'] != null
          ? "https://test.bodah.bj/storage/" + (map['image_path'] as String)
          : "", // chaîne vide si null
      marchandise_id: map['marchandise_id'] != null
          ? map['marchandise_id'] as int
          : 0, // valeur par défaut 0 si null
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnoncePhotos.fromJson(String source) =>
      AnnoncePhotos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AnnoncePhotos(id: $id, image_path: $image_path, marchandise_id: $marchandise_id)';

  @override
  bool operator ==(covariant AnnoncePhotos other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image_path == image_path &&
        other.marchandise_id == marchandise_id;
  }

  @override
  int get hashCode =>
      id.hashCode ^ image_path.hashCode ^ marchandise_id.hashCode;
}
