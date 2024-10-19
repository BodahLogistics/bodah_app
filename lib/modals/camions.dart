import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

class Camions {
  int id;
  String num_immatriculation;
  int? type_vehicule_id;
  int? modele_id;
  String modele_type;
  String? face_avant_image;
  String? partie_arriere_image;
  String? profil_image;
  Camions({
    required this.id,
    required this.num_immatriculation,
    this.type_vehicule_id,
    this.modele_id,
    required this.modele_type,
    this.face_avant_image,
    this.partie_arriere_image,
    this.profil_image,
  });

  Camions copyWith({
    int? id,
    String? num_immatriculation,
    int? type_vehicule_id,
    int? modele_id,
    String? modele_type,
    String? face_avant_image,
    String? partie_arriere_image,
    String? profil_image,
  }) {
    return Camions(
      id: id ?? this.id,
      num_immatriculation: num_immatriculation ?? this.num_immatriculation,
      type_vehicule_id: type_vehicule_id ?? this.type_vehicule_id,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      face_avant_image: face_avant_image ?? this.face_avant_image,
      partie_arriere_image: partie_arriere_image ?? this.partie_arriere_image,
      profil_image: profil_image ?? this.profil_image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'num_immatriculation': num_immatriculation,
      'type_vehicule_id': type_vehicule_id,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'face_avant_image': face_avant_image,
      'partie_arriere_image': partie_arriere_image,
      'profil_image': profil_image,
    };
  }

  factory Camions.fromMap(Map<String, dynamic> map) {
    return Camions(
      id: map['id'] as int,
      num_immatriculation: map['num_immatriculation'] as String,
      type_vehicule_id: map['type_vehicule_id'] != null
          ? map['type_vehicule_id'] is String
              ? int.parse(map['type_vehicule_id'])
              : map['type_vehicule_id'] as int
          : null,
      modele_id: map['modele_id'] != null
          ? map['modele_id'] is String
              ? int.parse(map['modele_id'])
              : map['modele_id'] as int
          : null,
      modele_type: map['modele_type'] as String,
      face_avant_image: map['face_avant_image'] != null
          ? map['face_avant_image'] as String
          : null,
      partie_arriere_image: map['partie_arriere_image'] != null
          ? map['partie_arriere_image'] as String
          : null,
      profil_image:
          map['profil_image'] != null ? map['profil_image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Camions.fromJson(String source) =>
      Camions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Camions(id: $id, num_immatriculation: $num_immatriculation, type_vehicule_id: $type_vehicule_id, modele_id: $modele_id, modele_type: $modele_type, face_avant_image: $face_avant_image, partie_arriere_image: $partie_arriere_image, profil_image: $profil_image)';
  }

  @override
  bool operator ==(covariant Camions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.num_immatriculation == num_immatriculation &&
        other.type_vehicule_id == type_vehicule_id &&
        other.modele_id == modele_id &&
        other.modele_type == modele_type &&
        other.face_avant_image == face_avant_image &&
        other.partie_arriere_image == partie_arriere_image &&
        other.profil_image == profil_image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        num_immatriculation.hashCode ^
        type_vehicule_id.hashCode ^
        modele_id.hashCode ^
        modele_type.hashCode ^
        face_avant_image.hashCode ^
        partie_arriere_image.hashCode ^
        profil_image.hashCode;
  }
}
