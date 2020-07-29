import 'dart:async';
// packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// firebase
import 'package:firebase_database/firebase_database.dart';
// project
import 'package:flutter_moviesliders/models/models.dart';
import 'package:flutter_moviesliders/services/services.dart';

class SlidersView extends StatefulWidget {
  SlidersView(this.title, this.reviewKey, this.omdb);

  final String title;
  final String reviewKey;
  final OmdbModel omdb;

  @override
  _SlidersViewState createState() => _SlidersViewState();
}

class _SlidersViewState extends State<SlidersView> {
  static final DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  Timer timer;
  bool _paused = true;
  List<Rating> ratings = [];
  DatabaseReference review_trends;
  int seconds = 0;
  int time_spent = 0;

  @override
  void initState() {
    super.initState();
    print(widget.title);
    /*
      do away with the FutureBuilder in this case and extract all of the list 
      processing code to initState.
      Call dbRef.child('foo_bar').once() in initState and with a .then callback, 
      fill your elements list and call setState.
    */
    review_trends = dbRef.child('review').child(widget.reviewKey);

    review_trends.child('trend').once().then((DataSnapshot snapshot) {
      setState(() {
        snapshot.value.forEach((key, value) {
          ratings.add(Rating(
              value['name'],
              value['color'],
              value['order'],
              review_trends
                  .child('trend')
                  .child(key.toString())
                  .child('data')));
        });
        ratings.sort((a, b) => a.order.compareTo(b.order));
      });
    });

    // every 2 seconds update
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => _updateTrends(t));
  }

  @override
  void dispose() {
    timer?.cancel();
    print('here');
    // delete
    if (seconds == 0) {
      review_trends.remove();
      super.dispose();
    }
  }

  void _pause() {
    setState(() {
      _paused = !_paused;
    });
  }

  void _updateTrends(Timer t) {
    // print(t.tick); // how many times t has been updated
    if (_paused || ratings.length == 0) return;
    seconds = seconds + 2;
    ratings.forEach((Rating rating) {
      DatabaseReference ratingRef = rating.trend.push();
      ratingRef.set(
        {
          's': seconds,
          'v': rating.rating.round(),
        },
      );
    });
    setState(() {
      time_spent = (seconds.toDouble() / 60).truncate();
    });
  }

  @override
  Widget build(BuildContext context) {
    // https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final Map arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            // action buttons
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
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 10.0
                // , bottom: 10.0
                ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Chip(
                      label: Text(widget.omdb.runtime),
                    ),
                    Container(
                      width: 180,
                      child: CupertinoButton(
                        child: _paused ? Text('Play') : Text('Pause'),
                        color: _paused
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        onPressed: _pause,
                      ),
                    ),
                    Chip(
                      label: Text(time_spent.toString() + ' min'),
                    ),
                  ],
                ),
                Expanded(
                    // SLIDERS
                    child: ratings.length > 0
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                for (Rating rating in ratings)
                                  Column(children: <Widget>[
                                    Expanded(
                                        child: RotatedBox(
                                      quarterTurns: -1,
                                      child: CupertinoSlider(
                                          value: rating.rating,
                                          activeColor: _paused
                                              ? Colors.grey
                                              : rating.color,
                                          min: Rating.minRating,
                                          max: Rating.maxRating,
                                          onChanged: (newRating) {
                                            setState(() =>
                                                rating.rating = newRating);
                                          }),
                                    )),
                                    _paused
                                        ? rating.name
                                        : Text(
                                            rating.rating.round().toString(),
                                          ),
                                  ]),
                              ])
                        : Center(
                            child: const CircularProgressIndicator(),
                          )),
              ],
            ),
          ),
        ));
  }
}
