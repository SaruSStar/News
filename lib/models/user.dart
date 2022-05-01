import 'dart:convert';

class User {
  String? _name;
  String? _username;
  String? _password;

  User(
    this._name,
    this._username,
    this._password,
  );

  String? get name => _name;
  String? get username => _username;
  // Not getting password out

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'username': _username,
      'password': _password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['name'],
      map['username'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
