/*
https://www.omdbapi.com/?apikey=cf1629a0&v=1&plot=full&i=tt3896198
*/
class OmdbModel {
  static final String url =
      'https://www.omdbapi.com/?apikey=cf1629a0&v=1&r=json';
}

// class OmdbSearchModel extends OmdbModel {
//   static final String urlSearch = OmdbModel.url + '&type=movie&s=';

//   final String title;
//   final int year;
//   final String id;
//   final String type;
//   final String poster;

//   OmdbSearchModel({this.title, this.year, this.id, this.type, this.poster});

//   factory OmdbSearchModel.fromJson(Map<String, dynamic> json) {
//     return OmdbSearchModel(
//       title: json['Title'],
//       year: int.parse(json['Year']),
//       id: json['imdbID'],
//       type: json['Type'],
//       poster: json['Poster'],
//     );
//   }
// }

class OmdbIdModel extends OmdbModel {
  OmdbIdModel(
      {this.title,
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
      this.response})
      : runtimeNum = int.parse(runtime.substring(0, runtime.indexOf(' ')));

  static final String urlId = OmdbModel.url + '&plot=full';

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
  final List ratings;
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

  factory OmdbIdModel.fromJson(Map<String, dynamic> json) {
    // String temp = json['Runtime'].substring(0, json['Runtime'].indexOf(' '))
    return OmdbIdModel(
      title: json['Title'],
      year: int.parse(json['Year']),
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      poster: json['Poster'],
      ratings: json['Ratings'],
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbID: json['imdbID'],
      type: json['Type'],
      dvd: json['DVD'],
      boxOffice: json['BoxOffice'],
      production: json['Production'],
      website: json['Website'],
      response: json['Response'],
    );
  }
}
