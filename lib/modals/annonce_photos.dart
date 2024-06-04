// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, unnecessary_cast, prefer_interpolation_to_compose_strings
import 'dart:convert';


class AnnoncePhotos {
  final int id;
  final String image_path;
  final int marchandise_id;
  final int deleted;
  AnnoncePhotos({
    required this.id,
    required this.image_path,
    required this.marchandise_id,
    required this.deleted,
  });

  AnnoncePhotos copyWith({
    int? id,
    String? image_path,
    int? marchandise_id,
    int? deleted,
  }) {
    return AnnoncePhotos(
      id: id ?? this.id,
      image_path: image_path ?? this.image_path,
      marchandise_id: marchandise_id ?? this.marchandise_id,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_path': image_path,
      'marchandise_id': marchandise_id,
      'deleted': deleted,
    };
  }

  factory AnnoncePhotos.fromMap(Map<String, dynamic> map) {
    return AnnoncePhotos(
      id: map['id'] as int,
      image_path: "https://test.bodah.bj/storage/" + map['image_path'] as String,
      marchandise_id: map['marchandise_id'] as int,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnoncePhotos.fromJson(String source) =>
      AnnoncePhotos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnnoncePhotos(id: $id, image_path: $image_path, marchandise_id: $marchandise_id, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant AnnoncePhotos other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image_path == image_path &&
        other.marchandise_id == marchandise_id &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image_path.hashCode ^
        marchandise_id.hashCode ^
        deleted.hashCode;
  }
}
