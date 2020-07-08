// import 'dart:convert';

class Suggestion {
  final String title;
  final String id;
  final String staring;
  final int year;
  final String type;
  final media;

  Suggestion(
      {this.title, this.id, this.staring, this.year, this.type, this.media});

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      title: json['l'],
      id: json['id'],
      staring: json['s'],
      year: json['y'],
      type: json['q'],
      media: json['i'],
    );
  }
}
