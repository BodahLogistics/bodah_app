// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class CargaisonClient {
  final int id;
  final int client_id;
  final int cargaison_id;
  final int quantite;
  final int deleted;
  CargaisonClient({
    required this.id,
    required this.client_id,
    required this.cargaison_id,
    required this.quantite,
    required this.deleted,
  });

  CargaisonClient copyWith({
    int? id,
    int? client_id,
    int? cargaison_id,
    int? quantite,
    int? deleted,
  }) {
    return CargaisonClient(
      id: id ?? this.id,
      client_id: client_id ?? this.client_id,
      cargaison_id: cargaison_id ?? this.cargaison_id,
      quantite: quantite ?? this.quantite,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'client_id': client_id,
      'cargaison_id': cargaison_id,
      'quantite': quantite,
      'deleted': deleted,
    };
  }

  factory CargaisonClient.fromMap(Map<String, dynamic> map) {
    return CargaisonClient(
      id: map['id'] as int,
      client_id: map['client_id'] as int,
      cargaison_id: map['cargaison_id'] as int,
      quantite: map['quantite'] as int,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CargaisonClient.fromJson(String source) =>
      CargaisonClient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CargaisonClient(id: $id, client_id: $client_id, cargaison_id: $cargaison_id, quantite: $quantite, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant CargaisonClient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.client_id == client_id &&
        other.cargaison_id == cargaison_id &&
        other.quantite == quantite &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        client_id.hashCode ^
        cargaison_id.hashCode ^
        quantite.hashCode ^
        deleted.hashCode;
  }
}
