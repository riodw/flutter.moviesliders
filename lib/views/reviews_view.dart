import 'dart:async';
import 'dart:convert';
// Pub
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_list.dart';
// Project
import 'package:flutter_moviesliders/constants/globals.dart';
import 'package:flutter_moviesliders/services/services.dart';
import 'package:flutter_moviesliders/models/models.dart';
// Widgets
import 'package:flutter_moviesliders/widgets/chart_widget.dart';

class MyMoviesView extends StatefulWidget {
  MyMoviesView({Key key}) : super(key: key);

  @override
  _MyMoviesState createState() => _MyMoviesState();
}

class _MyMoviesState extends State<MyMoviesView> {
  static final Query _dbRef =
      dbRef.child('reviews').child('done').orderByKey().limitToLast(10);
  static List<Review> _reviews = [];
  // DatabaseError _error;
  static FirebaseList tt;

  @override
  void initState() {
    super.initState();

    tt = FirebaseList(
        query: _dbRef,
        onChildAdded: (pos, snapshot) {
          // print(-1);
          setState(() {
            _reviews.insert(pos, Review.fromJson(snapshot.value));
          });
        },
        onChildRemoved: (pos, snapshot) {
          // print(-2);
          setState(() {
            _reviews.removeAt(pos);
          });
        },
        onChildChanged: (pos, snapshot) {
          // print(-3);
          // setState(() {
          //   _reviews[pos] = Review.fromJson(snapshot.value);
          // });
        },
        onChildMoved: (oldpos, newpos, snapshot) {
          // print(-4);
        },
        onValue: (snapshot) {
          // print(-5);
        });
  }

  @override
  void dispose() {
    super.dispose();
    tt.cancelSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    final FirebaseUser userProvider = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rated Movies'),
        actions: <Widget>[
          IconButton(
            icon: themeProvider.isDarkModeOn
                ? const Icon(Icons.brightness_low)
                : const Icon(Icons.brightness_high),
            onPressed: () {
              themeProvider
                  .updateTheme(themeProvider.isDarkModeOn ? 'light' : 'dark');
              // Provider.of<ThemeProvider>(context, listen: false)
              //     .updateTheme(theme);
            },
          ),
          // action buttons
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              final actionSheet = CupertinoActionSheet(
                  // title: Text('Select Option'),
                  // message: Text('Which option?'),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: const Text('About MovieSliders'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/about');
                        // print('pressed: About MovieSliders');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: const Text('Terms of Service'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/tos');
                        // print('pressed: Terms of Service');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: const Text('Privacy'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/privacy');
                        // print('pressed: Privacy Policy');
                      },
                    ),
                    userProvider.isAnonymous
                        ? CupertinoActionSheetAction(
                            child: const Text('Sign In'),
                            onPressed: () {},
                          )
                        : CupertinoActionSheetAction(
                            child: const Text('Log Out'),
                            isDestructiveAction: true,
                            onPressed: () {
                              final AuthService _auth = AuthService();
                              setState(() {
                                _auth.signOut();
                              });
                            },
                          ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ));
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => actionSheet);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 22.0, // has the effect of softening the shadow
                    spreadRadius: 0, // has the effect of extending the shadow
                  )
                ],
              ),
              child:
                  Image.asset('assets/images/moviesliders_icon.png', width: 60),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(children: <Widget>[
              Text(
                'Movie Sliders',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text('Data Driven Movie Reviews',
                  style: Theme.of(context).textTheme.bodyText1)
            ]),
          ]),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: MaterialButton(
              height: 45.0,
              color: Theme.of(context).colorScheme.primary,
              minWidth: 320.0,
              child: const Text(
                'New Review',
              ),
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: MovieSearch(),
                );
              },
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          _reviews.length > 0
              ? Column(children: <Widget>[
                  for (Review review in _reviews.reversed)
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/movie_review',
                            arguments: review);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 170.0,
                            decoration: const BoxDecoration(
                              border: const Border(
                                top: const BorderSide(
                                    width: 1, color: Colors.grey),
                                left: const BorderSide(
                                    width: 1, color: Colors.grey),
                                right: const BorderSide(
                                    width: 1, color: Colors.grey),
                                bottom: const BorderSide(
                                    width: 1, color: Colors.grey),
                              ),
                            ),
                            child: NumericComboLinePointChart.withRatings(
                                trendsList: review.trends, animate: false),
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    review.title,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    (review.type == 'movie'
                                            ? review.movie.dateReleased.year
                                                .toString()
                                            : '9999') +
                                        ' - Rating: ' +
                                        review.avg10.toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 18.0, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(40.0))),
                                      width: 34.0,
                                      height: 34.0,
                                      child: Center(
                                          child: Text(review.userAbv,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ))),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            review.userName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Text(
                                            review.dateReviewedReadable
                                            // + ' - asdf'
                                            ,
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey),
                                          )
                                        ])
                                  ]),
                                ]),
                          ),
                          // const Divider(
                          //   color: Colors.black12,
                          //   height: 40,
                          //   thickness: 1,
                          //   indent: 15,
                          //   endIndent: 15,
                          // ),
                          const SizedBox(height: 40.0),
                        ],
                      ),
                    ),
                ])
              : const Center(
                  child: const CircularProgressIndicator(),
                )
        ],
      ),
    );
  }
}

/**
 * OmdbSearchModel
 * OmdbSearchModel
 * OmdbSearchModel
 * 
    List<OmdbSearchModel> suggestions = [];

    Future<List<OmdbSearchModel>> _fetchOmbdSearch(final String query) async {
      String urlSearch = OmdbSearchModel.urlSearch + query;

      final response = await http.get(urlSearch);

      if (response.statusCode != 200) return suggestions;

      var omdbSearchJson = json.decode(response.body);
      print(omdbSearchResult);

      imdbJson = imdbJson.substring(imdbJson.indexOf('(') + 1, imdbJson.length - 1);
      var omdbSearchJson = json.decode(omdbSearchResult);
      if (omdbSearchJson.containsKey('Search')) {
        for (var word in omdbSearchJson['Search']) {
          if (word['Poster'] != 'N/A') {
            suggestions.add(OmdbSearchModel.fromJson(word));
          }
        }
      }
      return suggestions;
    }
 */

final String imdbUrl = 'https://sg.media-imdb.com/suggests/';

Future<List<ImdbModel>> _fetchImdb(String query) async {
  List<ImdbModel> suggestions = [];

  final String urlSearch =
      imdbUrl + query.substring(0, 1) + '/' + query + '.json';
  final response = await http.get(urlSearch);

  if (response.statusCode != 200) return suggestions;

  String imdbJson = response.body;

  imdbJson = imdbJson.substring(imdbJson.indexOf('(') + 1, imdbJson.length - 1);

  for (dynamic word in json.decode(imdbJson)['d']) {
    if (word['q'] != null &&
        word['q'] == 'feature' &&
        word['i'] != null &&
        word['i'][0] != null) {
      suggestions.add(ImdbModel.fromJson(word));
    }
  }

  return suggestions;
}

class MovieSearch extends SearchDelegate {
  // FIND MOVIES
  /*
   * https://www.omdbapi.com/
   * https://www.themoviedb.org/?language=en-US
   * https://stackoverflow.com/questions/1966503/does-imdb-provide-an-api
   * 
   * Get movie details
   * https://sg.media-imdb.com/suggests/a/altered.json
   * https://www.omdbapi.com/?apikey=cf1629a0&i=tt3896198
   */

  @override
  String get searchFieldLabel => 'Search Movies';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('build Results');
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 4) {
      return SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Search Movies',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Enter at least three letters'),
          ],
        ),
      ));
    }

    // https://stackoverflow.com/questions/57250986/the-argument-type-futurewidget-cant-be-assigned-to-the-parameter-type-widg
    // https://stackoverflow.com/questions/49781657/adjust-gridview-child-height-according-to-the-dynamic-content-in-flutter
    var suggestions = FutureBuilder<List<ImdbModel>>(
        future: _fetchImdb(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<ImdbModel>> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: const Text('Error'),
            );
          else if (snapshot.hasData) {
            if (snapshot.data.length == 0)
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'No Movies To Show',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Try entering more search characters.'),
                  ],
                ),
              );
            return GridView.count(
              primary: true,
              // padding: const EdgeInsets.only(b: 20),
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              crossAxisCount: 3,
              childAspectRatio: .48,
              children: <Widget>[
                for (final ImdbModel suggestion in snapshot.data)
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/movie_info',
                          arguments: suggestion);
                    },
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(
                          suggestion.media[0],
                          height: 180,
                          loadingBuilder:
                              (BuildContext context, Object child, progress) {
                            return progress == null
                                ? child
                                : const CircularProgressIndicator();
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return const Center(child: Text('Image Not Found'));
                          },
                          fit: BoxFit.fill,
                        ),
                        Text(
                          suggestion.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          suggestion.year.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    )),
                  ),
              ],
            );
          } else
            return const Center(
              child: const CircularProgressIndicator(),
            );
        });

    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Text(
            'Movies',
            style: Theme.of(context).textTheme.headline6,
          ),
          Flexible(child: suggestions),
        ]));
  }
}