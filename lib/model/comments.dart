// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class Comments {
  String? name;
  String? email;
  String? body;
  Comments({
    this.name,
    this.email,
    this.body,
  });

  Comments copyWith({
    String? name,
    String? email,
    String? body,
  }) {
    return Comments(
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  @override
  String toString() {
    return 'Comments( name: $name, email: $email, body: $body)';
  }

  @override
  bool operator ==(covariant Comments other) {
    if (identical(this, other)) return true;

    return other.name == name && other.email == email && other.body == body;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ body.hashCode;
  }
}
