// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class CargaisonClient {
  int id;
  int client_id;
  int cargaison_id;
  int quantite;

  CargaisonClient({
    required this.id,
    required this.client_id,
    required this.cargaison_id,
    required this.quantite,
  });

  CargaisonClient copyWith({
    int? id,
    int? client_id,
    int? cargaison_id,
    int? quantite,
  }) {
    return CargaisonClient(
      id: id ?? this.id,
      client_id: client_id ?? this.client_id,
      cargaison_id: cargaison_id ?? this.cargaison_id,
      quantite: quantite ?? this.quantite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'client_id': client_id,
      'cargaison_id': cargaison_id,
      'quantite': quantite,
    };
  }

  factory CargaisonClient.fromMap(Map<String, dynamic> map) {
    return CargaisonClient(
      id: map['id'] != null
          ? (map['id'] is String ? int.parse(map['id']) : map['id'] as int)
          : 0, // Valeur par défaut si null
      client_id: map['client_id'] != null
          ? (map['client_id'] is String
              ? int.parse(map['client_id'])
              : map['client_id'] as int)
          : 0, // Valeur par défaut si null
      cargaison_id: map['cargaison_id'] != null
          ? (map['cargaison_id'] is String
              ? int.parse(map['cargaison_id'])
              : map['cargaison_id'] as int)
          : 0, // Valeur par défaut si null
      quantite: map['quantite'] != null
          ? (map['quantite'] is String
              ? int.parse(map['quantite'])
              : map['quantite'] as int)
          : 0, // Valeur par défaut si null
    );
  }

  String toJson() => json.encode(toMap());

  factory CargaisonClient.fromJson(String source) =>
      CargaisonClient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CargaisonClient(id: $id, client_id: $client_id, cargaison_id: $cargaison_id, quantite: $quantite)';
  }

  @override
  bool operator ==(covariant CargaisonClient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.client_id == client_id &&
        other.cargaison_id == cargaison_id &&
        other.quantite == quantite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        client_id.hashCode ^
        cargaison_id.hashCode ^
        quantite.hashCode;
  }
}
