import 'package:flutter/cupertino.dart';

import 'behavior.dart';

class Dog {
  final String _id;
  String _name;
  String _breed;
  bool _gender;
  int _age;
  final String _photoUrl;
  final String _size;
  final String _description;
  int _likes;
  final List<Behavior> _exampleBehaviors;
  final int _ownerId;

  Dog(this._id, this._name, this._breed, this._gender, this._age,
      this._photoUrl, this._size, this._description, this._likes, this._exampleBehaviors,
      this._ownerId);

  String get id => _id;

  String get size => _size;

  String get description => _description;

  int get likes => _likes;

  set likes(int value) {
    _likes = value;
  }

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

  List<Behavior> get exampleBehaviors => _exampleBehaviors;

  int get ownerId => _ownerId;
}
