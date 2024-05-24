// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Camions {
  final int id;
  final String? num_immatriculation;
  final String? name;
  final int type_vehicule_id;
  final int? transporteur_id;
  final int deleted;
  final String? face_avant_image;
  final String? partie_arriere_image;
  final String? profil_image;
  Camions({
    required this.id,
    this.num_immatriculation,
    this.name,
    required this.type_vehicule_id,
    this.transporteur_id,
    required this.deleted,
    this.face_avant_image,
    this.partie_arriere_image,
    this.profil_image,
  });

  Camions copyWith({
    int? id,
    String? num_immatriculation,
    String? name,
    int? type_vehicule_id,
    int? transporteur_id,
    int? deleted,
    String? face_avant_image,
    String? partie_arriere_image,
    String? profil_image,
  }) {
    return Camions(
      id: id ?? this.id,
      num_immatriculation: num_immatriculation ?? this.num_immatriculation,
      name: name ?? this.name,
      type_vehicule_id: type_vehicule_id ?? this.type_vehicule_id,
      transporteur_id: transporteur_id ?? this.transporteur_id,
      deleted: deleted ?? this.deleted,
      face_avant_image: face_avant_image ?? this.face_avant_image,
      partie_arriere_image: partie_arriere_image ?? this.partie_arriere_image,
      profil_image: profil_image ?? this.profil_image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'num_immatriculation': num_immatriculation,
      'name': name,
      'type_vehicule_id': type_vehicule_id,
      'transporteur_id': transporteur_id,
      'deleted': deleted,
      'face_avant_image': face_avant_image,
      'partie_arriere_image': partie_arriere_image,
      'profil_image': profil_image,
    };
  }

  factory Camions.fromMap(Map<String, dynamic> map) {
    return Camions(
      id: map['id'] as int,
      num_immatriculation: map['num_immatriculation'] != null ? map['num_immatriculation'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      type_vehicule_id: map['type_vehicule_id'] as int,
      transporteur_id: map['transporteur_id'] != null ? map['transporteur_id'] as int : null,
      deleted: map['deleted'] as int,
      face_avant_image: map['face_avant_image'] != null ? map['face_avant_image'] as String : null,
      partie_arriere_image: map['partie_arriere_image'] != null ? map['partie_arriere_image'] as String : null,
      profil_image: map['profil_image'] != null ? map['profil_image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Camions.fromJson(String source) => Camions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Camions(id: $id, num_immatriculation: $num_immatriculation, name: $name, type_vehicule_id: $type_vehicule_id, transporteur_id: $transporteur_id, deleted: $deleted, face_avant_image: $face_avant_image, partie_arriere_image: $partie_arriere_image, profil_image: $profil_image)';
  }

  @override
  bool operator ==(covariant Camions other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.num_immatriculation == num_immatriculation &&
      other.name == name &&
      other.type_vehicule_id == type_vehicule_id &&
      other.transporteur_id == transporteur_id &&
      other.deleted == deleted &&
      other.face_avant_image == face_avant_image &&
      other.partie_arriere_image == partie_arriere_image &&
      other.profil_image == profil_image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      num_immatriculation.hashCode ^
      name.hashCode ^
      type_vehicule_id.hashCode ^
      transporteur_id.hashCode ^
      deleted.hashCode ^
      face_avant_image.hashCode ^
      partie_arriere_image.hashCode ^
      profil_image.hashCode;
  }
}
