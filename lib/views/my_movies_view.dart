import 'dart:convert';
// packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// project
import 'package:flutter_moviesliders/services/auth_service.dart';
import 'package:flutter_moviesliders/services/services.dart';
import 'package:flutter_moviesliders/models/models.dart';
// widgets
import 'package:flutter_moviesliders/widgets/chart_widget.dart';

class MyMoviesView extends StatefulWidget {
  MyMoviesView({Key key}) : super(key: key);

  @override
  _MyMoviesState createState() => _MyMoviesState();
}

class _MyMoviesState extends State<MyMoviesView> {
  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final FirebaseUser userProvider = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Rated Movies'),
        actions: <Widget>[
          IconButton(
            icon: themeProvider.isDarkModeOn
                ? Icon(Icons.brightness_low)
                : Icon(Icons.brightness_high),
            onPressed: () {
              var theme = themeProvider.isDarkModeOn ? 'light' : 'dark';
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(theme);
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
                      child: Text('About MovieSliders'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/about');
                        // print('pressed: About MovieSliders');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Terms of Service'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/tos');
                        // print('pressed: Terms of Service');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Privacy'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/privacy');
                        // print('pressed: Privacy Policy');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Log Out'),
                      onPressed: () {
                        final AuthService _auth = AuthService();
                        _auth.signOut();
                      },
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text('Cancel'),
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
          Container(
              margin: EdgeInsets.only(
                  top: 20.0, left: 25.0, right: 20.0, bottom: 10.0),
              child: Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius:
                              22.0, // has the effect of softening the shadow
                          spreadRadius:
                              0, // has the effect of extending the shadow
                          // offset: Offset(
                          // 10.0, // horizontal, move right 10
                          // 10.0, // vertical, move down 10
                          // ),
                        )
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius:
                                0, // has the effect of softening the shadow
                            spreadRadius:
                                0, // has the effect of extending the shadow
                          )
                        ],
                      ),
                      child: Image.asset('assets/images/moviesliders_icon.png',
                          width: 60),
                    )),
                Column(children: <Widget>[
                  Text(
                    'Movie Sliders',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text('Data Driven Movie Reviews',
                      style: Theme.of(context).textTheme.bodyText1)
                ])
              ])),
          Divider(
            color: Colors.grey[300],
            height: 25,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Container(
            margin:
                EdgeInsets.only(top: 0.0, right: 30.0, bottom: 0, left: 30.0),
            child: ButtonTheme(
              minWidth: 320.0,
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  child: Text(
                    'New Review',
                    style: Theme.of(context).textTheme.button,
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MovieSearch(),
                  );
                },
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 25,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          FutureBuilder<DataSnapshot>(
              future: dbRef.child('reviews').once(),
              builder:
                  (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error');
                } else if (snapshot.hasData && snapshot.data != null) {
                  // No Reviews found
                  if (snapshot.data.value == null)
                    return Center(
                      child: Text('No Reviews to show'),
                    );
                  List<Review> reviews = [];
                  snapshot.data.value.forEach((key, value) {
                    reviews.add(Review.fromJson(value));
                  });
                  reviews.sort((a, b) =>
                      b.dateTimeReviewed.compareTo(a.dateTimeReviewed));

                  return Column(children: <Widget>[
                    for (Review review in reviews)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/movie_review',
                              arguments: review);
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 170.0,
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1, color: Colors.grey[350]),
                                      left: BorderSide(
                                          width: 1, color: Colors.grey[350]),
                                      right: BorderSide(
                                          width: 1, color: Colors.grey[350]),
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey[350]),
                                    ),
                                    // color: Color(0xFFBFBFBF),
                                  ),
                                  child:
                                      NumericComboLinePointChartRaw.withRatings(
                                          review.trends,
                                          animate: false),
                                ),
                                Text(
                                  review.title,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  (review.type == 'movie'
                                          ? review.movie.dateReleased.year
                                              .toString()
                                          : '9999') +
                                      ' - Rating: ' +
                                      review.avg10.toString(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                SizedBox(height: 8.0),
                                Row(children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0))),
                                    width: 34.0,
                                    height: 34.0,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: Center(
                                        child: Text(review.userAbv,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ))),
                                  ),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ])
                                ]),
                                Divider(
                                  color: Colors.grey[300],
                                  height: 40,
                                  thickness: 1,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                              ],
                            )),
                      ),
                  ]);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }
}

final String imdbUrl = 'https://sg.media-imdb.com/suggests/';

Future<List<ImdbModel>> _fetchImdb(String query) async {
  List<ImdbModel> suggestions = [];

  final String urlSearch =
      imdbUrl + query.substring(0, 1) + '/' + query + '.json';
  final response = await http.get(urlSearch);

  if (response.statusCode != 200) return suggestions;

  var imdbJson = response.body;

  imdbJson = imdbJson.substring(imdbJson.indexOf('(') + 1, imdbJson.length - 1);
  var imdb = json.decode(imdbJson);

  for (var word in imdb['d']) {
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
   * https://sg.media-imdb.com/suggests/a/aa.json
   * http://www.omdbapi.com/?i=tt3896198&apikey=cf1629a0
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
            SizedBox(
              height: 10,
            ),
            Text('Enter at least three letters'),
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
              child:
                  Text('Error', style: Theme.of(context).textTheme.headline4),
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
                    SizedBox(
                      height: 10,
                    ),
                    Text('Try entering more search characters.'),
                  ],
                ),
              );
            return GridView.count(
              primary: true,
              // padding: const EdgeInsets.only(b: 20),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: 3,
              childAspectRatio: .52,
              children: <Widget>[
                for (ImdbModel suggestion in snapshot.data)
                  GestureDetector(
                    onTap: () {
                      // print(suggestion.id);
                      Navigator.pushNamed(context, '/movie_info',
                          arguments: suggestion);
                    },
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                              // color: Colors.yellow,
                              image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.topCenter,
                            image: NetworkImage(
                              suggestion.media[0],
                            ),
                          )),
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
            return Center(
              child: CircularProgressIndicator(),
            );
        });

    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Text(
            'Movies',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline6,
          ),
          Flexible(child: suggestions),
        ]));
  }
}
