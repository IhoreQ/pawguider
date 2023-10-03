import '../behavior.dart';

class Dog {
  final int _id;
  String _name;
  String _breed;
  String _gender;
  int _age;
  String _photoUrl;
  String? _size;
  String? _description;
  int? _likes;
  List<Behavior>? _behaviors;
  int? _ownerId;
  bool? _likedByUser;

  Dog.clone(Dog dog) : this(dog.id, dog.name, dog.breed, dog.gender, dog.age,
      dog.photoUrl, dog.size, dog.description, dog.likes, dog.behaviors!.map((e) => Behavior(e.id, e.name)).toList(), dog.ownerId, dog.likedByUser);

  Dog.basic(this._id, this._name, this._breed, this._gender, this._age, this._photoUrl);

  Dog(this._id, this._name, this._breed, this._gender, this._age,
      this._photoUrl, this._size, this._description, this._likes, this._behaviors, this._ownerId, this._likedByUser);

  int get id => _id;

  String? get size => _size;

  String? get description => _description;

  int? get likes => _likes;

  int get age => _age;

  String get gender => _gender;

  String get breed => _breed;

  String get name => _name;

  String get photoUrl => _photoUrl;

  List<Behavior>? get behaviors => _behaviors;

  int? get ownerId => _ownerId;

  bool? get likedByUser => _likedByUser;


  void addLike() {
    _likes = _likes! + 1;
  }

  void subtractLike() {
    _likes = _likes! - 1;
    if (_likes != null && _likes! < 0) {
      _likes = 0;
    }
  }
}
