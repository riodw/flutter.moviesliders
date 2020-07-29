import 'package:flutter/material.dart';
// firebase
import 'package:firebase_database/firebase_database.dart';

class Rating {
  Rating(this.rawName, this.rawColor, this.order, this.trend);

  static final double minRating = 2;
  static final double maxRating = 100;
  final String rawName, rawColor;
  final int order;
  double _rating = 40; // TODO change this to 2
  Text _name;
  Color _color;
  DatabaseReference trend;

  // getters
  Text get name => Text(this.rawName);
  Color get color => Color(int.parse('0xff${this.rawColor}'));
  double get rating => _rating;
  // setters
  set rating(double value) {
    _rating = value;
    // print('Changed: ' + value.toString());
  }

  // factory Rating.fromJson(Map<dynamic, dynamic> json) {
  //   return Rating(
  //     json['name'],
  //     json['color'],
  //   );
  // }
}
