class Breed {
  final int _id;
  final String _name;

  Breed(this._id, this._name);

  String get name => _name;

  int get id => _id;

  @override
  String toString() {
    return 'Breed{_id: $_id, _name: $_name}';
  }
}
