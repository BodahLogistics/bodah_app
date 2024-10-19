// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Entreprises {
  int id;
  String name;
  String? ifu;
  String numero_entreprise;
  String entrepriseable_type;
  int entrepriseable_id;
  Entreprises({
    required this.id,
    required this.name,
    this.ifu,
    required this.numero_entreprise,
    required this.entrepriseable_type,
    required this.entrepriseable_id,
  });

  Entreprises copyWith({
    int? id,
    String? name,
    String? ifu,
    String? numero_entreprise,
    String? entrepriseable_type,
    int? entrepriseable_id,
  }) {
    return Entreprises(
      id: id ?? this.id,
      name: name ?? this.name,
      ifu: ifu ?? this.ifu,
      numero_entreprise: numero_entreprise ?? this.numero_entreprise,
      entrepriseable_type: entrepriseable_type ?? this.entrepriseable_type,
      entrepriseable_id: entrepriseable_id ?? this.entrepriseable_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'ifu': ifu,
      'numero_entreprise': numero_entreprise,
      'entrepriseable_type': entrepriseable_type,
      'entrepriseable_id': entrepriseable_id,
    };
  }

  factory Entreprises.fromMap(Map<String, dynamic> map) {
    return Entreprises(
      id: map['id'] as int,
      name: map['name'] as String,
      ifu: map['ifu'] != null ? map['ifu'] as String : null,
      numero_entreprise: map['numero_entreprise'] as String,
      entrepriseable_type: map['entrepriseable_type'] as String,
      entrepriseable_id: map['entrepriseable_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Entreprises.fromJson(String source) =>
      Entreprises.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Entreprises(id: $id, name: $name, ifu: $ifu, numero_entreprise: $numero_entreprise, entrepriseable_type: $entrepriseable_type, entrepriseable_id: $entrepriseable_id)';
  }

  @override
  bool operator ==(covariant Entreprises other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.ifu == ifu &&
        other.numero_entreprise == numero_entreprise &&
        other.entrepriseable_type == entrepriseable_type &&
        other.entrepriseable_id == entrepriseable_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        ifu.hashCode ^
        numero_entreprise.hashCode ^
        entrepriseable_type.hashCode ^
        entrepriseable_id.hashCode;
  }
}
