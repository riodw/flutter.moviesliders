class Review {
  Review(
    this.dateReviewed,
    this.avg,
    this.title,
    this.type,
    this.linkId,
    this.userId,
    this.userName,
    this.userReviewNumber,
  )   : avg10 = (avg.toDouble().truncate() / 10).toString(),
        movie = type == 'movie' ? null : null;

  final String dateReviewed;
  final double avg;
  final String title;
  final String type;
  final String linkId;
  final String userId;
  final String userName;
  final int userReviewNumber;
  // calculated values
  final String avg10;
  final Movie movie;

  // final Map<String, dynamic> rawData;

  factory Review.fromJson(Map<dynamic, dynamic> json) {
    return Review(
      json['date_reviewed'],
      json['avg'].toDouble(),
      json['title'],
      json['type'],
      json['link_id'],
      json['user_id'],
      json['user']['name'],
      json['user']['review_number'],
    );
  }
}

class Movie {
  Movie(
      this.dateReleased, this.imdbId, this.runTime, this.title, this.posterUrl);

  final String dateReleased;
  final String imdbId;
  final String runTime;
  final String title;
  final String posterUrl;
}
