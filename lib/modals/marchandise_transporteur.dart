import 'dart:convert';

class MarchandiseTransporteur {
  int id;
  int annonce_id;
  String nombre_tonnes;

  MarchandiseTransporteur({
    required this.id,
    required this.annonce_id,
    required this.nombre_tonnes,
  });

  MarchandiseTransporteur copyWith({
    int? id,
    int? annonce_id,
    String? nombre_tonnes,
  }) {
    return MarchandiseTransporteur(
      id: id ?? this.id,
      annonce_id: annonce_id ?? this.annonce_id,
      nombre_tonnes: nombre_tonnes ?? this.nombre_tonnes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'annonce_id': annonce_id,
      'nombre_tonnes': nombre_tonnes,
    };
  }

  factory MarchandiseTransporteur.fromMap(Map<String, dynamic> map) {
    return MarchandiseTransporteur(
      id: map['id'] is String ? int.parse(map['id']) : map['id'] as int,
      annonce_id: map['annonce_id'] is String
          ? int.parse(map['annonce_id'])
          : map['annonce_id'] as int,
      nombre_tonnes: map['nombre_tonnes'] != null
          ? map['nombre_tonnes'].toString()
          : '', // Ensuring it's always a string
    );
  }

  String toJson() => json.encode(toMap());

  factory MarchandiseTransporteur.fromJson(String source) =>
      MarchandiseTransporteur.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MarchandiseTransporteur(id: $id, annonce_id: $annonce_id, nombre_tonnes: $nombre_tonnes)';

  @override
  bool operator ==(covariant MarchandiseTransporteur other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.annonce_id == annonce_id &&
        other.nombre_tonnes == nombre_tonnes;
  }

  @override
  int get hashCode =>
      id.hashCode ^ annonce_id.hashCode ^ nombre_tonnes.hashCode;
}
