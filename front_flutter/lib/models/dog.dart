class Dog {
  final String _id;
  String _name;
  String _breed;
  bool _gender;
  int _age;
  final String _photoUrl;

  Dog(this._id, this._name, this._breed, this._gender, this._age,
      this._photoUrl);

  String get id => _id;

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  set gender(bool value) {
    _gender = value;
  }

  bool get gender => _gender;

  String get breed => _breed;

  set breed(String value) {
    _breed = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get photoUrl => _photoUrl;
}
