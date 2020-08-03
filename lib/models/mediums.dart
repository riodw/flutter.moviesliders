class Movie {
  Movie(
      this.dateReleased, this.imdbId, this.runTime, this.title, this.posterUrl);

  final DateTime dateReleased;
  final String imdbId;
  final String runTime;
  final String title;
  final String posterUrl;

  factory Movie.fromJson(Map<dynamic, dynamic> json) {
    return Movie(
      DateTime.parse(json['date_released']),
      json['imdb_id'],
      json['runtime'],
      json['title'],
      json['media'][0],
    );
  }
}
