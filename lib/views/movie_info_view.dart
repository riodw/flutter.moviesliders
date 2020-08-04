import 'dart:convert';
// packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
// project
import 'package:flutter_moviesliders/constants/globals.dart';
import 'package:flutter_moviesliders/services/services.dart';
import 'package:flutter_moviesliders/views/views.dart';
import 'package:flutter_moviesliders/models/models.dart';

/**
https://www.omdbapi.com/?apikey=cf1629a0&v=1&plot=full&i=tt3896198
 */

// OmdbModel
Future<OmdbModel> _fetchOmdb(String imbdId) async {
  final String url = OmdbModel.url + '&i=' + imbdId;
  final response = await http.get(url);
  if (response.statusCode != 200) return null;

  var omdbJson = response.body;
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
        if (snapshot.hasError)
          return Center(
            child: Text('Error', style: Theme.of(context).textTheme.headline4),
          );
        else if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(),
          );
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
                        DatabaseReference reviewFireReference =
                            dbRef.child('reviews').push();

                        await reviewFireReference.set(<String, Object>{
                          'date_reviewed': DateTime.now().toString(),
                          'avg': 2,
                          'title': imdb.title,
                          'type': omdb.type,
                          'link_id': omdb.imdbID,
                          'user_id': 'asdf',
                          'user': {
                            'name': 'asdf asdf',
                            'review_number': 0,
                          },
                          'medium': {
                            'imdb_id': omdb.imdbID,
                            'title': omdb.title,
                            'runtime': omdb.runtime,
                            'date_released': (() {
                              final List<String> dateParsed =
                                  omdb.released.split(' ');
                              final int day = int.parse(dateParsed[0]);
                              final int year = int.parse(dateParsed[2]);
                              int month = interpretMonthString(dateParsed[1]);
                              return DateTime.utc(year, month, day);
                            })()
                                .toString(),
                            'media': imdb.media,
                          },
                          // the review data
                          'trends': [],
                        }).then((onValue) {
                          final DatabaseReference trends = dbRef
                              .child('reviews')
                              .child(reviewFireReference.key)
                              .child('trends');

                          final List _trends = [
                            {
                              'name': 'Interest',
                              'color': 'c62928',
                              'order': 1,
                            },
                            {
                              'name': 'Cliche',
                              'color': '01e675',
                              'order': 2,
                            },
                            {
                              'name': 'Funny',
                              'color': '2ab6f6',
                              'order': 3,
                            },
                            {
                              'name': 'Dumb',
                              'color': 'bd00ff',
                              'order': 4,
                            },
                            {
                              'name': 'WTF',
                              'color': 'fdff00',
                              'order': 5,
                            },
                          ];

                          _trends.forEach((element) {
                            DatabaseReference _trend = trends.push();
                            _trend.set(element).then((asdf) {
                              DatabaseReference _ratings = trends
                                  .child(_trend.key)
                                  .child('ratings')
                                  .push();
                              _ratings.set(
                                {
                                  's': 0,
                                  'v': 2,
                                },
                              );
                            });
                          });
                          // change page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SlidersView(
                                    title: imdb.title,
                                    reviewKey: reviewFireReference.key,
                                    omdb: omdb)),
                          );
                          // Navigator.pushNamed(context, '/sliders', arguments: {
                          //   'title': imdb.title,
                          //   'review_fire_id': reviewFireReference.key,
                          //   'omdb': omdb
                          // });
                        }).catchError((onError) {
                          print(onError.toString());
                          return null;
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
