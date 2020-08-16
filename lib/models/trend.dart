// Packages
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// Project
import 'package:flutter_moviesliders/models/models.dart';

class Trend {
  Trend(
      {@required this.rawName,
      @required this.rawColor,
      @required this.order,
      this.trendKey,
      this.ratingsRef,
      this.ratings})
      : name = Text(rawName),
        color = Color(int.parse('0xff${rawColor}'));

  static final double minRating = 2;
  static final double maxRating = 100;
  final String rawName;
  final String rawColor;
  final int order;
  final String trendKey;
  DatabaseReference ratingsRef;
  List<Rating> ratings = [];
  // calculated values
  final Text name;
  final Color color;
  double _rating = 2;

  // getters
  double get rating => _rating;
  // setters
  set rating(double value) {
    _rating = value;
    // print('Changed: ' + value.toString());
  }

  // factory Trend.fromJson(Map<dynamic, dynamic> json) {
  //   return Trend(
  //     json['name'],
  //     json['color'],
  //   );
  // }
}
