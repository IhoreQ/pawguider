import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceArea {
  final int _id;
  final List<LatLng> _points;

  PlaceArea(this._id, this._points);

  factory PlaceArea.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    List<dynamic> rawPoints = json['points'];

    List<LatLng> points = rawPoints.map((rawPoint) {
      double x = rawPoint['x'];
      double y = rawPoint['y'];
      return LatLng(x, y);
    }).toList();

    return PlaceArea(id, points);
  }

  List<LatLng> get points => _points;

  int get id => _id;
}