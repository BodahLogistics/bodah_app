// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class LogoEntreprises {
  int id;
  String path;
  int entreprise_id;
  LogoEntreprises({
    required this.id,
    required this.path,
    required this.entreprise_id,
  });

  LogoEntreprises copyWith({
    int? id,
    String? path,
    int? entreprise_id,
  }) {
    return LogoEntreprises(
      id: id ?? this.id,
      path: path ?? this.path,
      entreprise_id: entreprise_id ?? this.entreprise_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'entreprise_id': entreprise_id,
    };
  }

  factory LogoEntreprises.fromMap(Map<String, dynamic> map) {
    return LogoEntreprises(
      id: map['id'] as int,
      path: map['path'] as String,
      entreprise_id: map['entreprise_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoEntreprises.fromJson(String source) =>
      LogoEntreprises.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LogoEntreprises(id: $id, path: $path, entreprise_id: $entreprise_id)';

  @override
  bool operator ==(covariant LogoEntreprises other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.entreprise_id == entreprise_id;
  }

  @override
  int get hashCode => id.hashCode ^ path.hashCode ^ entreprise_id.hashCode;
}
