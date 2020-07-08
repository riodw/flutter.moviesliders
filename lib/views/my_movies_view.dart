import 'dart:convert';
// packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// project
// - auth
import 'package:flutter_moviesliders/services/auth_service.dart';
import 'package:flutter_moviesliders/services/services.dart';

/* Comparison from episode to episode
https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class MyMoviesView extends StatefulWidget {
  MyMoviesView({Key key}) : super(key: key);

  @override
  _MyMoviesState createState() => _MyMoviesState();
}

class _MyMoviesState extends State<MyMoviesView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                        print('pressed: About MovieSliders');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Terms of Service'),
                      onPressed: () {
                        print('pressed: Terms of Service');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Privacy'),
                      onPressed: () {
                        print('pressed: Privacy Policy');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Log Out'),
                      onPressed: () {
                        AuthService _auth = AuthService();
                        _auth.signOut();
                        Navigator.of(context).pushNamed('/signin');
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
      body: SafeArea(
          child: ListView(children: <Widget>[
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
          margin: EdgeInsets.only(top: 0.0, right: 30.0, bottom: 0, left: 30.0),
          child: ButtonTheme(
            minWidth: 320.0,
            height: 40.0,
            child: RaisedButton(
              // textColor: Colors.white,
              color: Colors.blueAccent,
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
                // Navigator.pushNamed(context, '/search_movies');
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
        Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        color: Colors.grey[400],
                        height: 170.0,
                      ),
                      Text(
                        'Altered Carbon: Season 1 Episode 5 (The Wrong Man)',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '2017 - Rating 6.9',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 10.0),
                      Row(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                          width: 34.0,
                          height: 34.0,
                          margin: EdgeInsets.only(right: 10.0),
                          child: Center(
                              child: Text('RW',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ))),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Rio Weber',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                '22 Mar 2018 - asdf',
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ])
                      ]),
                      Divider(
                        color: Colors.grey[300],
                        height: 35,
                        thickness: 1,
                        indent: 15,
                        endIndent: 15,
                      ),
                    ],
                  )),
              onTap: () {
                Navigator.pushNamed(context, '/movie_review');
              },
            )
          ],
        ),
      ])),
    );
  }
}

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

  static final String imdbUrl = "https://sg.media-imdb.com/suggests/";

  Future<List<Suggestion>> _fetchAlbum(String query) async {
    List<Suggestion> suggestions = [];

    final urlSearch = imdbUrl + query.substring(0, 1) + "/" + query + ".json";
    final response = await http.get(urlSearch);

    if (response.statusCode != 200) return suggestions;

    var imdbJson = response.body;

    imdbJson =
        imdbJson.substring(imdbJson.indexOf("(") + 1, imdbJson.length - 1);
    var imdb = json.decode(imdbJson);

    for (var word in imdb['d']) {
      if (word['q'] != null &&
          word['q'] == "feature" &&
          word['i'] != null &&
          word['i'][0] != null) {
        suggestions.add(Suggestion.fromJson(word));
      }
    }

    return suggestions;
  }

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
              "Search Movies",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Enter at least three letters"),
          ],
        ),
      ));
    }

    // https://stackoverflow.com/questions/57250986/the-argument-type-futurewidget-cant-be-assigned-to-the-parameter-type-widg
    // https://stackoverflow.com/questions/49781657/adjust-gridview-child-height-according-to-the-dynamic-content-in-flutter
    var suggestions = FutureBuilder<List<Suggestion>>(
        future: _fetchAlbum(query),
        builder: (context, AsyncSnapshot<List<Suggestion>> snapshot) {
          if (snapshot.hasError || snapshot.data == null)
            return Center(
              child: Text('Error'),
            );
          if (snapshot.data == null || snapshot.data.length == 0)
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "No Movies To Show",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Try entering more search characters."),
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
              for (Suggestion suggestion in snapshot.data)
                GestureDetector(
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
                  onTap: () {
                    print(suggestion.id);
                  },
                ),
            ],
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
