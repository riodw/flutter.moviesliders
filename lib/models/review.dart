// project
import 'package:flutter_moviesliders/constants/globals.dart';
import 'package:flutter_moviesliders/models/models.dart';

class Review {
  Review(
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
  )   : dateTimeReviewed = DateTime.parse(dateReviewed),
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
      json['date_reviewed'],
      json['avg'].toDouble(),
      json['title'],
      json['type'],
      json['link_id'],
      json['medium'],
      json['user_id'],
      json['user']['name'],
      json['user']['review_number'],
      setTrends(json['trend']),
    );
  }

  static List<Trend> setTrends(Map<dynamic, dynamic> trendJson) {
    List<Trend> trends = [];
    trendJson.forEach((key, value) {
      trends.add(Trend(
          value['name'], value['color'], value['order'], key.toString(),
          trendDatas: setTrendDatas(value['data'])));
    });
    return trends;
  }

  static List<TrendData> setTrendDatas(Map<dynamic, dynamic> trendJson) {
    List<TrendData> trendDatas = [];
    trendJson.forEach((key, value) {
      trendDatas.add(TrendData(value['s'], value['v']));
    });
    trendDatas.sort((a, b) => a.second.compareTo(b.second));
    return trendDatas;
  }
}
