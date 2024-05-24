// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class TrajetTonnages {
  final int id;
  final int annonce_id;
  final String? nombre_tonnes;
  final String? numero_marchandise;
  TrajetTonnages({
    required this.id,
    required this.annonce_id,
    this.nombre_tonnes,
    this.numero_marchandise,
  });

  TrajetTonnages copyWith({
    int? id,
    int? annonce_id,
    String? nombre_tonnes,
    String? numero_marchandise,
  }) {
    return TrajetTonnages(
      id: id ?? this.id,
      annonce_id: annonce_id ?? this.annonce_id,
      nombre_tonnes: nombre_tonnes ?? this.nombre_tonnes,
      numero_marchandise: numero_marchandise ?? this.numero_marchandise,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'annonce_id': annonce_id,
      'nombre_tonnes': nombre_tonnes,
      'numero_marchandise': numero_marchandise,
    };
  }

  factory TrajetTonnages.fromMap(Map<String, dynamic> map) {
    return TrajetTonnages(
      id: map['id'] as int,
      annonce_id: map['annonce_id'] as int,
      nombre_tonnes:
          map['nombre_tonnes'] != null ? map['nombre_tonnes'] as String : null,
      numero_marchandise: map['numero_marchandise'] != null
          ? map['numero_marchandise'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrajetTonnages.fromJson(String source) =>
      TrajetTonnages.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TrajetTonnages(id: $id, annonce_id: $annonce_id, nombre_tonnes: $nombre_tonnes, numero_marchandise: $numero_marchandise)';
  }

  @override
  bool operator ==(covariant TrajetTonnages other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.annonce_id == annonce_id &&
        other.nombre_tonnes == nombre_tonnes &&
        other.numero_marchandise == numero_marchandise;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        annonce_id.hashCode ^
        nombre_tonnes.hashCode ^
        numero_marchandise.hashCode;
  }
}
