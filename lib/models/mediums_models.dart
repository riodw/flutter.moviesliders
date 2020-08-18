class Movie {
  Movie({
    this.dateReleased,
    this.imdbId,
    this.runTime,
    this.title,
    this.posterUrl,
  });

  final DateTime dateReleased;
  final String imdbId;
  final String runTime;
  final String title;
  final String posterUrl;

  factory Movie.fromJson(Map<dynamic, dynamic> json) {
    return Movie(
      dateReleased: DateTime.parse(json['date_released']),
      imdbId: json['imdb_id'],
      runTime: json['runtime'],
      title: json['title'],
      posterUrl: json['media'][0],
    );
  }
}
