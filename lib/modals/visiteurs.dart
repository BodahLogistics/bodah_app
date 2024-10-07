// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Visiteurs {
  int id;
  Visiteurs({
    required this.id,
  });

  Visiteurs copyWith({
    int? id,
  }) {
    return Visiteurs(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory Visiteurs.fromMap(Map<String, dynamic> map) {
    return Visiteurs(
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Visiteurs.fromJson(String source) =>
      Visiteurs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Visiteurs(id: $id)';

  @override
  bool operator ==(covariant Visiteurs other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
