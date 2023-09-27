import 'package:front_flutter/models/place.dart';

class Walk {

  final int _id;
  final Place _place;
  int _timer = 0;

  Walk(this._id, this._place, this._timer);

  int get id => _id;
  Place get place => _place;
  int get timer => _timer;

  void incrementTimer() {
    _timer++;
  }

  String getTime() {
    int hours, minutes, seconds;

    hours = _timer ~/ 3600;

    minutes = ((_timer - hours * 3600)) ~/ 60;

    seconds = _timer - (hours * 3600) - (minutes * 60);


    final formattedHours = hours > 10 ? hours.toString().padLeft(2, '0') : hours;
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');

    String result = "$formattedHours:$formattedMinutes:$formattedSeconds";

    return result;
  }
}