class User {

  final String _firstName;
  final String _lastName;
  final String? _photoUrl;

  User( this._firstName, this._lastName, this._photoUrl);

  String get lastName => _lastName;

  String get firstName => _firstName;

  String? get photoUrl => _photoUrl;
}