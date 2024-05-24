// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Transporteurs {
  final int id;
  final String numero_transporteur;
  final int user_id;
  final String? num_permis;
  final String? photo_url;
  final int deleted;
  Transporteurs({
    required this.id,
    required this.numero_transporteur,
    required this.user_id,
    this.num_permis,
    this.photo_url,
    required this.deleted,
  });

  Transporteurs copyWith({
    int? id,
    String? numero_transporteur,
    int? user_id,
    String? num_permis,
    String? photo_url,
    int? deleted,
  }) {
    return Transporteurs(
      id: id ?? this.id,
      numero_transporteur: numero_transporteur ?? this.numero_transporteur,
      user_id: user_id ?? this.user_id,
      num_permis: num_permis ?? this.num_permis,
      photo_url: photo_url ?? this.photo_url,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero_transporteur': numero_transporteur,
      'user_id': user_id,
      'num_permis': num_permis,
      'photo_url': photo_url,
      'deleted': deleted,
    };
  }

  factory Transporteurs.fromMap(Map<String, dynamic> map) {
    return Transporteurs(
      id: map['id'] as int,
      numero_transporteur: map['numero_transporteur'] as String,
      user_id: map['user_id'] as int,
      num_permis:
          map['num_permis'] != null ? map['num_permis'] as String : null,
      photo_url: map['photo_url'] != null ? map['photo_url'] as String : null,
      deleted: map['deleted'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transporteurs.fromJson(String source) =>
      Transporteurs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transporteurs(id: $id, numero_transporteur: $numero_transporteur, user_id: $user_id, num_permis: $num_permis, photo_url: $photo_url, deleted: $deleted)';
  }

  @override
  bool operator ==(covariant Transporteurs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero_transporteur == numero_transporteur &&
        other.user_id == user_id &&
        other.num_permis == num_permis &&
        other.photo_url == photo_url &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero_transporteur.hashCode ^
        user_id.hashCode ^
        num_permis.hashCode ^
        photo_url.hashCode ^
        deleted.hashCode;
  }
}
