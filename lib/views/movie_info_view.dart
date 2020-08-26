import 'dart:convert';
// Pub
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Project
import 'package:flutter_moviesliders/constants/globals.dart';
import 'package:flutter_moviesliders/views/sliders_view.dart';
import 'package:flutter_moviesliders/models/models.dart';

final DatabaseReference reviewRef = dbRef.child('reviews');
final DatabaseReference reviewNotDoneRef = reviewRef.child('not_done').push();
/**
https://www.omdbapi.com/?apikey=cf1629a0&v=1&plot=full&i=tt3896198
 */

// OmdbIdModel
Future<OmdbIdModel> _fetchOmdb(String imbdId) async {
  final String url = OmdbIdModel.urlId + '&i=' + imbdId;
  final response = await http.get(url);
  if (response.statusCode != 200) return null;

  return OmdbIdModel.fromJson(json.decode(response.body));
}

class MovieInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final FirebaseUser userProvider = Provider.of<FirebaseUser>(context);
    final ImdbModel imdb = ModalRoute.of(context).settings.arguments;

    FutureBuilder<OmdbIdModel> contents = FutureBuilder<OmdbIdModel>(
      future: _fetchOmdb(imdb.id),
      builder: (BuildContext context, AsyncSnapshot<OmdbIdModel> snapshot) {
        OmdbIdModel omdb;
        if (snapshot.hasError)
          return const Center(
            child: Text('Error'),
          );
        else if (snapshot.data == null)
          return const Center(
            child: const CircularProgressIndicator(),
          );
        omdb = snapshot.data;

        return Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 261,
              child: Image.network(
                omdb.poster,
                height: 260,
                loadingBuilder: (BuildContext context, Object child, progress) {
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
              height: 45.0,
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              child: const Text(
                'Start Review',
              ),
              onPressed: () async {
                await reviewNotDoneRef.set(<String, Object>{
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
                      final int month = interpretMonthString(dateParsed[1]);
                      return DateTime.utc(year, month, day);
                    })()
                        .toString(),
                    'media': imdb.media,
                  },
                  // the review data
                  'trends': [],
                }).then((onValue) {
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

                  trends.forEach((trend) {
                    final DatabaseReference trendRef =
                        reviewNotDoneRef.child('trends').push();
                    trendRef.set(trend).then((asdf) {
                      trendRef.child('ratings').push().set(
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
                            reviewRef: reviewRef,
                            reviewNotDoneRef: reviewNotDoneRef,
                            omdb: omdb)),
                  );
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
