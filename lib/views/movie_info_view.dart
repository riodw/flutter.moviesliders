import 'dart:convert';
// packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// firebase
import 'package:firebase_database/firebase_database.dart';

// project
// - auth
// import 'package:flutter_moviesliders/services/auth_service.dart';
import 'package:flutter_moviesliders/services/services.dart';
import 'package:flutter_moviesliders/models/models.dart';

/**
https://www.omdbapi.com/?apikey=cf1629a0&v=1&plot=full&i=tt3896198
 */

final String omdbUrl = 'https://www.omdbapi.com/?apikey=cf1629a0&v=1&plot=full';

// OmdbModel
Future<OmdbModel> _fetchOmdb(String imbdId) async {
  final String url = omdbUrl + '&i=' + imbdId;
  final response = await http.get(url);
  if (response.statusCode != 200) return null;

  var omdbJson = response.body;
  // print(omdbJson);
  // OmdbModel omdb_imdb = OmdbModel.fromJson(json.decode(omdbJson));

  // return Text(omdb_imdb.title);
  return OmdbModel.fromJson(json.decode(omdbJson));
}

class MovieInfoView extends StatelessWidget {
  // firebase
  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ImdbModel imdb = ModalRoute.of(context).settings.arguments;

    var contents = FutureBuilder<OmdbModel>(
      future: _fetchOmdb(imdb.id),
      builder: (BuildContext context, AsyncSnapshot<OmdbModel> snapshot) {
        OmdbModel omdb;
        // print(snapshot.data);

        if (snapshot.hasError)
          return Center(
            child: Text('Error', style: Theme.of(context).textTheme.headline4),
          );
        else if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        // if (snapshot.hasData) {
        //   textChild = snapshot;
        // }
        omdb = snapshot.data;

        return Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Container(
                  height: 260,
                  child: Image.network(
                    omdb.poster,
                    fit: BoxFit.fill,
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      omdb.year.toString(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Chip(
                      label: Text(omdb.rated),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      omdb.runtime,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: ButtonTheme(
                    // minWidth: 330.0,
                    height: 50.0,
                    child: RaisedButton(
                      // textColor: Colors.white,
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Container(
                        child: Text(
                          'Start Review',
                          style: Theme.of(context).textTheme.button,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () async {
                        // TODO: Add ImdbModel to a 'Movies' list with a counter
                        DatabaseReference reviewFireReference =
                            dbRef.child('review').push();

                        await reviewFireReference.set(<String, Object>{
                          'date_reviewed': DateTime.now().toString(),
                          'rating_avg': 69.236465,
                          'link_id': omdb.imdbID,
                          'type': omdb.type,
                          'title': imdb.title,
                          'user_id': 'asdf',
                          'user': {
                            'name': 'asdf asdf',
                            'review_number': 0,
                          },
                          'movie': {
                            'movie_id': omdb.imdbID,
                            'title': omdb.title,
                            'runtime': omdb.runtime,
                            'date_released':
                                omdb.released, // TODO convert to date time
                            'media': imdb.media,
                          },
                          // the review data
                          'trend': [],
                        }).then((onValue) {
                          DatabaseReference trends = dbRef
                              .child('review')
                              .child(reviewFireReference.key)
                              .child('trend');

                          var _trends = [
                            {
                              'name': 'Interest',
                              'color': 'c62928',
                            },
                            {
                              'name': 'Cliche',
                              'color': '01e675',
                            },
                            {
                              'name': 'Funny',
                              'color': '2ab6f6',
                            },
                            {
                              'name': 'Dumb',
                              'color': 'bd00ff',
                            },
                            {
                              'name': 'WTF',
                              'color': 'fdff00',
                            },
                          ];

                          _trends.forEach((element) {
                            DatabaseReference _trend = trends.push();
                            _trend.set(element).then((asdf) {
                              DatabaseReference _trend_data =
                                  trends.child(_trend.key).child('data').push();
                              _trend_data.set(
                                {
                                  "s": 0,
                                  "v": 2,
                                },
                              );
                            });
                          });
                          // change page
                          Navigator.pushNamed(context, '/sliders', arguments: {
                            'title': imdb.title,
                            'review_fire_id': reviewFireReference.key,
                            'omdb': omdb
                          });
                        }).catchError((onError) {
                          print(onError.toString());
                          return false;
                        });
                        // https://medium.com/firebase-tips-tricks/how-to-use-firebase-queries-in-flutter-361f21005467
                        // https://pub.dev/packages/firebase_database/example#-example-tab-
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  omdb.plot,
                  maxLines: 19,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ));
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(imdb.title),
          actions: <Widget>[],
        ),
        body: SafeArea(
          child: contents,
        ));
  }
}
