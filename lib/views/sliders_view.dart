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
  SlidersView(
      {Key key,
      @required this.title,
      @required this.reviewKey,
      @required this.omdb})
      : assert(title != null && omdb != null),
        super(key: key);

  final String title;
  final String reviewKey;
  final OmdbModel omdb;

  @override
  _SlidersViewState createState() => _SlidersViewState();
}

class _SlidersViewState extends State<SlidersView> {
  static final DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  bool _paused = true;
  Timer _timer;
  List<Rating> _ratings = [];
  DatabaseReference _reviewRef;
  int _seconds = 0;
  int _timeSpent = 0;
  bool _reviewFinished = false;
  int _updates = 1;
  double _avg = 2;

  @override
  void initState() {
    super.initState();
    /*
      do away with the FutureBuilder in this case and extract all of the list 
      processing code to initState.
      Call dbRef.child('foo_bar').once() in initState and with a .then callback, 
      fill your elements list and call setState.
    */
    _reviewRef = dbRef.child('review').child(widget.reviewKey);

    _reviewRef.child('trend').once().then((DataSnapshot snapshot) {
      setState(() {
        snapshot.value.forEach((key, value) {
          _ratings.add(Rating(value['name'], value['color'], value['order'],
              _reviewRef.child('trend').child(key.toString()).child('data')));
        });
        _ratings.sort((a, b) => a.order.compareTo(b.order));
      });
    });

    // every 2 _seconds update
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) => _updateTrends());
  }

  @override
  void dispose() {
    _timer?.cancel();
    // delete unstarted review
    if (_seconds == 0) _reviewRef?.remove();
    super.dispose();
  }

  void setAverage() {
    _reviewFinished = true;
    _paused = true;
    _timer?.cancel();
    double average = _avg / _updates;
    _reviewRef.child('rating_avg').set(average);
  }

  void _updateTrends() {
    if (_paused || _ratings.length == 0) return;
    _seconds = _seconds + 2;
    setState(() {
      _timeSpent = (_seconds.toDouble() / 60).truncate();
      if (_timeSpent >= widget.omdb.runtimeNum) {
        // if (_seconds >= 12) {
        setAverage();
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Movie Review Done!'),
            content: Text(
              'See your finished review and rating.',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Show me!'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/movie_review', ModalRoute.withName('/'));
                },
              ),
            ],
          ),
        );
        return;
      }
    });

    _ratings.forEach((Rating _rating) {
      // update average
      if (_rating.rawName == 'Interest') {
        _avg = _avg + _rating.rating.round();
      }
      // post updated
      DatabaseReference ratingRef = _rating.trend.push();
      ratingRef.set(
        {
          's': _seconds,
          'v': _rating.rating.round(),
        },
      );
    });
    // how many times has been called
    _updates++;
  }

  Future<bool> _onWillPop() async {
    if (_seconds == 0) {
      _reviewRef?.remove();
      Navigator.pop(context);
      return false;
    }
    // TEST IF REVIEW IS CLOSE ENOUGH TO DONE
    if ((_timeSpent + 5) >= widget.omdb.runtimeNum) {
      // if (_seconds > 4) {
      setAverage();
      // GO TO SEE REVIEW RESULTS
      Navigator.pushNamedAndRemoveUntil(
          context, '/movie_review', ModalRoute.withName('/'));
      return false;
    }
    return (await showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Your review will be deleted if you\ngo back before finishing.' +
                  '\n\nYou have ' +
                  (widget.omdb.runtimeNum - _timeSpent).toString() +
                  ' minutes left.',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  _timer?.cancel();
                  _reviewRef?.remove();
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                          child: _reviewFinished
                              ? CupertinoButton(
                                  child: Text('DONE'),
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () {
                                    // GO TO SEE REVIEW RESULTS
                                  },
                                )
                              : CupertinoButton(
                                  child: _paused ? Text('Play') : Text('Pause'),
                                  color: _paused
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.secondary,
                                  onPressed: () {
                                    setState(() {
                                      _paused = !_paused;
                                    });
                                  },
                                ),
                        ),
                        Chip(
                          label: Text(_timeSpent.toString() + ' min'),
                        ),
                      ],
                    ),
                    Expanded(
                        // SLIDERS
                        child: _ratings.length > 0
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                    for (Rating rating in _ratings)
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
                                                rating.rating
                                                    .round()
                                                    .toString(),
                                              ),
                                      ]),
                                  ])
                            : Center(
                                child: const CircularProgressIndicator(),
                              )),
                  ],
                ),
              ),
            )));
  }
}
