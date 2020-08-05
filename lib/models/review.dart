// project
import 'package:flutter_moviesliders/constants/globals.dart';
import 'package:flutter_moviesliders/models/models.dart';

class Review {
  Review({
    this.dateReviewed,
    this.avg,
    this.title,
    this.type,
    this.linkId,
    this.medium,
    this.userId,
    this.userName,
    this.userReviewNumber,
    this.trends,
  })  : dateTimeReviewed = DateTime.parse(dateReviewed),
        avg10 = (avg.toDouble().truncate() / 10).toString(),
        movie = type == 'movie' ? Movie.fromJson(medium) : null,
        dateReviewedReadable = (() {
          DateTime date = DateTime.parse(dateReviewed);
          return date.day.toString() +
              ' ' +
              interpretMonthInt(date.month).toString() +
              ' ' +
              date.year.toString();
        })();

  final String dateReviewed;
  final double avg;
  final String title;
  final String type;
  final String linkId;
  final Map<dynamic, dynamic> medium;
  final String userId;
  final String userName;
  final int userReviewNumber;
  final List<Trend> trends;
  // calculated values
  final DateTime dateTimeReviewed;
  final String dateReviewedReadable;
  final String avg10;
  final Movie movie;

  factory Review.fromJson(Map<dynamic, dynamic> json) {
    return Review(
      dateReviewed: json['date_reviewed'],
      avg: json['avg'].toDouble(),
      title: json['title'],
      type: json['type'],
      linkId: json['link_id'],
      medium: json['medium'],
      userId: json['user_id'],
      userName: json['user']['name'],
      userReviewNumber: json['user']['review_number'],
      trends: setTrends(json['trends']),
    );
  }

  static List<Trend> setTrends(Map<dynamic, dynamic> trendJson) {
    List<Trend> trends = [];
    trendJson.forEach((key, value) {
      trends.add(Trend(
          value['name'], value['color'], value['order'], key.toString(),
          ratings: setRatings(value['ratings'])));
    });
    return trends;
  }

  static List<Rating> setRatings(Map<dynamic, dynamic> trendJson) {
    List<Rating> ratings = [];
    trendJson.forEach((key, value) {
      ratings.add(Rating(second: value['s'], value: value['v']));
    });
    ratings.sort((a, b) => a.second.compareTo(b.second));
    return ratings;
  }
}
