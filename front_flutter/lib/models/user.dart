class User {

  final int _id;
  final String _firstName;
  final String _lastName;
  final String? _photoUrl;
  final int _cityId;
  final String _cityName;
  final String _gender;
  String? _phone;
  String? _email;
  int? _dogsCount;

  User(this._id, this._firstName, this._lastName, this._photoUrl, this._cityId, this._cityName, this._phone, this._email, this._gender, this._dogsCount);

  int get id => _id;

  String get lastName => _lastName;

  String get firstName => _firstName;

  String? get photoUrl => _photoUrl;

  String get cityName => _cityName;

  int get cityId => _cityId;

  String? get email => _email;

  String? get phone => _phone;

  int? get dogsCount => _dogsCount;

  String get gender => _gender;
}