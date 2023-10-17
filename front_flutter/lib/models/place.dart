
class Place {
  final int _id;
  final String _name;
  final String _street;
  String? _houseNumber;
  String? _zipCode;
  String? _city;
  String? _description;
  int? _dogsCount;
  double? _averageScore;
  final String _photoUrl;
  bool? _likedByUser;
  bool? _ratedByUser;
  double? _scoreByUser;

  Place.basicInfo(this._id, this._name, this._street, this._houseNumber, this._dogsCount,
      this._averageScore, this._photoUrl);

  Place.favouriteInfo(this._id, this._name, this._street, this._city, this._photoUrl);

  Place(this._id, this._name, this._street, this._houseNumber, this._zipCode, this._city,
      this._description, this._averageScore, this._photoUrl, this._likedByUser, this._ratedByUser, this._scoreByUser);

  int get id => _id;

  String get photoUrl => _photoUrl;

  double? get averageScore => _averageScore;

  int? get dogsCount => _dogsCount;

  String? get description => _description;

  String? get city => _city;

  String? get zipCode => _zipCode;

  String get street => _street;

  String get name => _name;

  String? get houseNumber => _houseNumber;

  bool? get likedByUser => _likedByUser;

  double? get scoreByUser => _scoreByUser;

  bool? get ratedByUser => _ratedByUser;
}
