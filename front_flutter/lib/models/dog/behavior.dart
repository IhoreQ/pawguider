class Behavior {
  final int _id;
  final String _name;

  Behavior(this._id, this._name);

  int get id => _id;
  String get name => _name;

  @override
  String toString() {
    return 'Behavior{$_id: $_name}';
  }
}