class User {

  final int _id;
  final String _firstName;
  final String _lastName;
  final String? _photoUrl;

  User(this._id, this._firstName, this._lastName, this._photoUrl);

  int get id => _id;

  String get lastName => _lastName;

  String get firstName => _firstName;

  String? get photoUrl => _photoUrl;
}