// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class OrdreTransport {
  int id;
  int modele_id;
  String modele_type;
  String reference;
  String? nom;
  String path;

  OrdreTransport({
    required this.id,
    required this.modele_id,
    required this.modele_type,
    required this.reference,
    this.nom,
    required this.path,
  });

  OrdreTransport copyWith({
    int? id,
    int? modele_id,
    String? modele_type,
    String? reference,
    String? nom,
    String? path,
  }) {
    return OrdreTransport(
      id: id ?? this.id,
      modele_id: modele_id ?? this.modele_id,
      modele_type: modele_type ?? this.modele_type,
      reference: reference ?? this.reference,
      nom: nom ?? this.nom,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modele_id': modele_id,
      'modele_type': modele_type,
      'reference': reference,
      'nom': nom,
      'path': path,
    };
  }

  factory OrdreTransport.fromMap(Map<String, dynamic> map) {
    return OrdreTransport(
      id: map['id'] as int,
      modele_id: map['modele_id'] as int,
      modele_type: map['modele_type'] as String,
      reference: map['reference'] as String,
      nom: map['nom'] != null ? map['nom'] as String : null,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdreTransport.fromJson(String source) =>
      OrdreTransport.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdreTransport(id: $id, modele_id: $modele_id, modele_type: $modele_type, reference: $reference, nom: $nom, path: $path)';
  }

  @override
  bool operator ==(covariant OrdreTransport other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.modele_id == modele_id &&
      other.modele_type == modele_type &&
      other.reference == reference &&
      other.nom == nom &&
      other.path == path;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      modele_id.hashCode ^
      modele_type.hashCode ^
      reference.hashCode ^
      nom.hashCode ^
      path.hashCode;
  }
}
