class OmdbModel {
  OmdbModel(
      this.title,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.ratings,
      this.metascore,
      this.imdbRating,
      this.imdbVotes,
      this.imdbID,
      this.type,
      this.dvd,
      this.boxOffice,
      this.production,
      this.website,
      this.response)
      : runtimeNum = int.parse(runtime.substring(0, runtime.indexOf(" ")));

  static final String url =
      'https://www.omdbapi.com/?apikey=cf1629a0&v=1&plot=full';

  final String title;
  final int year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;
  final String response;
  // calculated values
  final int runtimeNum;

  factory OmdbModel.fromJson(Map<String, dynamic> json) {
    // String temp = json['Runtime'].substring(0, json['Runtime'].indexOf(" "))
    return OmdbModel(
      json['Title'],
      int.parse(json['Year']),
      json['Rated'],
      json['Released'],
      json['Runtime'],
      json['Genre'],
      json['Director'],
      json['Writer'],
      json['Actors'],
      json['Plot'],
      json['Language'],
      json['Country'],
      json['Awards'],
      json['Poster'],
      json['Ratings'],
      json['Metascore'],
      json['imdbRating'],
      json['imdbVotes'],
      json['imdbID'],
      json['Type'],
      json['DVD'],
      json['BoxOffice'],
      json['Production'],
      json['Website'],
      json['Response'],
    );
  }
}
