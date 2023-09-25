import 'dog/dog.dart';

class Place {
  final int _id;
  final String _name;
  final String _street;
  String? _zipCode;
  String? _city;
  String? _description;
  final int _dogsCount;
  double _averageScore;
  final String _photoUrl;

  Place.basicInfo(this._id, this._name, this._street, this._dogsCount,
      this._averageScore, this._photoUrl);

  Place(this._id, this._name, this._street, this._zipCode, this._city,
      this._description, this._dogsCount, this._averageScore, this._photoUrl);

  int get id => _id;

  String get photoUrl => _photoUrl;

  double get averageScore => _averageScore;

  int get dogsCount => _dogsCount;

  String? get description => _description;

  String? get city => _city;

  String? get zipCode => _zipCode;

  String get street => _street;

  String get name => _name;

  set averageScore(double value) {
    _averageScore = value;
  }
}
