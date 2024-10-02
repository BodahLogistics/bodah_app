// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Actualites {
  int id;
  String title;
  String sub_desc;
  String path;
  Actualites({
    required this.id,
    required this.title,
    required this.sub_desc,
    required this.path,
  });

  Actualites copyWith({
    int? id,
    String? title,
    String? sub_desc,
    String? path,
  }) {
    return Actualites(
      id: id ?? this.id,
      title: title ?? this.title,
      sub_desc: sub_desc ?? this.sub_desc,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'sub_desc': sub_desc,
      'path': path,
    };
  }

  factory Actualites.fromMap(Map<String, dynamic> map) {
    return Actualites(
      id: map['id'] as int,
      title: map['title'] as String,
      sub_desc: map['sub_desc'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Actualites.fromJson(String source) =>
      Actualites.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Actualites(id: $id, title: $title, sub_desc: $sub_desc, path: $path)';
  }

  @override
  bool operator ==(covariant Actualites other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.sub_desc == sub_desc &&
        other.path == path;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ sub_desc.hashCode ^ path.hashCode;
  }
}
