import 'package:front_flutter/models/place.dart';

class Walk {

  final int _id;
  final Place _place;
  final String _startTime;

  Walk(this._id, this._startTime, this._place);

  int get id => _id;
  Place get place => _place;
  String get startTime => _startTime;

}