import 'dart:convert';
// packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    // final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final FirebaseUser userProvider = Provider.of<FirebaseUser>(context);
    final ImdbModel imdb = ModalRoute.of(context).settings.arguments;

    var contents = FutureBuilder<OmdbModel>(
      future: _fetchOmdb(imdb.id),
      builder: (BuildContext context, AsyncSnapshot<OmdbModel> snapshot) {
        OmdbModel omdb;
        if (snapshot.hasError)
          return const Center(
            child: Text('Error'),
          );
        else if (snapshot.data == null)
          return const Center(
            child: CircularProgressIndicator(),
          );
        omdb = snapshot.data;

        return Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 260,
              child: Image.network(
                omdb.poster,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  omdb.year.toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  width: 20,
                ),
                Chip(
                  label: Text(omdb.rated),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  omdb.runtime,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              minWidth: 320.0,
              height: 50.0,
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              child: const Text(
                'Start Review',
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
                  'user_id': userProvider.uid,
                  'user': {
                    'name': userProvider.isAnonymous
                        ? 'Anonymous'
                        : userProvider.displayName,
                    'review_number': 0,
                  },
                  'medium': {
                    'imdb_id': omdb.imdbID,
                    'title': omdb.title,
                    'runtime': omdb.runtime,
                    'date_released': (() {
                      final List<String> dateParsed = omdb.released.split(' ');
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
                  final DatabaseReference trendsRef = dbRef
                      .child('reviews')
                      .child(reviewFireReference.key)
                      .child('trends');

                  final List trends = [
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

                  trends.forEach((element) {
                    DatabaseReference trend = trendsRef.push();
                    trend.set(element).then((asdf) {
                      DatabaseReference _ratings =
                          trendsRef.child(trend.key).child('ratings').push();
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    omdb.plot,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )))
          ],
        );
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
