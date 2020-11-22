import 'dart:async';
// Pub
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
// Project
import 'package:flutter_moviesliders/constants/globals.dart';
import 'package:flutter_moviesliders/models/models.dart';
import 'package:flutter_moviesliders/services/services.dart';

class SlidersView extends StatefulWidget {
  SlidersView(
      {Key key,
      @required this.title,
      @required this.reviewNotDoneRef,
      @required this.reviewRef,
      @required this.omdb})
      : assert(title != null && omdb != null),
        super(key: key);

  final String title;
  final DatabaseReference reviewNotDoneRef;
  final DatabaseReference reviewRef;
  final OmdbIdModel omdb;

  @override
  _SlidersViewState createState() => _SlidersViewState();
}

class _SlidersViewState extends State<SlidersView> {
  bool _paused = true;
  Timer _timer;
  List<Trend> _trends = [];
  int _seconds = 0;
  int _timeSpent = 0;
  bool _reviewFinished = false;
  int _updates = 1;
  int _total = 2;
  // Review - to be passed to review_selected_view on complete
  Review review;

  // reference to scaffold
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  double _avg() {
    return _total / _updates;
  }

  @override
  void initState() {
    super.initState();
    /*
      do away with the FutureBuilder in this case and extract all of the list 
      processing code to initState.
      Call dbRef.child('foo_bar').once() in initState and with a .then callback, 
      fill your elements list and call setState.
    */

    widget.reviewNotDoneRef.child('trends').once().then(
      (final DataSnapshot snapshot) {
        setState(
          () {
            snapshot.value.forEach(
              (key, value) {
                _trends.add(Trend(
                    rawName: value['name'],
                    rawColor: value['color'],
                    order: value['order'],
                    trendKey: key.toString(),
                    ratingsRef: widget.reviewNotDoneRef
                        .child('trends')
                        .child(key.toString())
                        .child('ratings')));
              },
            );
            _trends.sort((a, b) => a.order.compareTo(b.order));
          },
        );
      },
    );

    // every 2 _seconds update
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) => _updateTrends());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _finishReview(bool save) async {
    if (save) {
      _timer?.cancel();

      setState(() {
        _reviewFinished = true;
        _paused = true;
      });

      // Set average (avg)
      await widget.reviewNotDoneRef.child('avg').set(_avg());
      // get all data once to pass to review_selected_view
      final DataSnapshot reviewSnapshot = await widget.reviewNotDoneRef.once();
      // get Review instance from JSON
      review = Review.fromJson(reviewSnapshot.value);
      // move review to 'done'
      await widget.reviewRef.child('done').push().set(reviewSnapshot.value);
      // remove original
      await widget.reviewNotDoneRef.remove();
    }

    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Movie Review Done!'),
        content: const Text(
          'See your finished review and rating.',
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Show me!'),
            // GO TO SEE REVIEW RESULTS
            onPressed: () async {
              await testConnection();
              if (!iNet) return;
              // GO TO SEE REVIEW RESULTS
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/review_selected',
                ModalRoute.withName('/'),
                arguments: review,
              );
            },
          ),
        ],
      ),
    );
  }

  // Post Updates
  void _updateTrends() {
    if (!iNet) return;
    if (_paused || _trends.length == 0) return;
    _seconds = _seconds + 2;
    setState(() {
      _timeSpent = (_seconds.toDouble() / 60).truncate();

      // check if max time hit; and return out;
      if (_timeSpent >= widget.omdb.runtimeNum) {
        // if (_timeSpent >= 1) {
        _finishReview(true);
        return;
      }
    });

    _trends.forEach((final Trend trend) {
      if (trend.rawName == 'Interest') {
        // update average
        _total = _total + trend.rating.round();
        // how many times has been called
        _updates++;
      }
      // post updated
      trend.ratingsRef.push().set(
        {
          's': _seconds,
          'v': trend.rating.round(),
        },
      );
    });
  }

  Future<bool> _onWillPop() async {
    // Cancel
    if (_seconds == 0) {
      widget.reviewNotDoneRef.remove();
      Navigator.pop(context);
      return false;
    }

    // click if the review is already finished
    else if (_reviewFinished == true) {
      // if (_seconds > 4) {
      await testConnection();
      if (!iNet) return false;
      // show finished modal
      _finishReview(false);
      return false;
    }

    // TEST IF REVIEW IS CLOSE ENOUGH TO DONE
    else if ((_timeSpent) >= widget.omdb.runtimeNum) {
      // if (_seconds > 4) {
      _finishReview(true);
      return false;
    }

    return await showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Are you sure?'),
            content: Text(
              'Your review will be deleted if you go back before finishing.' +
                  '\n\nYou have ' +
                  (widget.omdb.runtimeNum - _timeSpent).toString() +
                  ' minutes left.',
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                child: const Text('Yes'),
                onPressed: () {
                  _timer?.cancel();
                  widget.reviewNotDoneRef
                      .remove()
                      .catchError((onError) => print(onError));
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(final BuildContext context) {
    // providers
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final ConnectivityStatus connectionStatus =
        Provider.of<ConnectivityStatus>(context, listen: true);

    // Check iNet
    displayInet(connectionStatus, _scaffoldKey.currentState);

    if (!iNet) _paused = true;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            // action buttons
            IconButton(
              icon: themeProvider.isDarkModeOn
                  ? Icon(Icons.brightness_low)
                  : Icon(Icons.brightness_high),
              onPressed: () {
                themeProvider
                    .updateTheme(themeProvider.isDarkModeOn ? 'light' : 'dark');
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 3.0),
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
                      height: 45,
                      child: _reviewFinished
                          ? MaterialButton(
                              color: Theme.of(context).colorScheme.primary,
                              child: const Text('DONE'),
                              onPressed: () async {
                                await testConnection();
                                if (!iNet) return;
                                // show finished modal
                                _finishReview(false);
                              },
                            )
                          : MaterialButton(
                              color: _paused
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                              onPressed: () {
                                if (!iNet) {
                                  _paused = true;
                                  return;
                                }
                                setState(() {
                                  _paused = !_paused;
                                });
                              },
                              child: _paused
                                  ? const Text(
                                      'Play',
                                    )
                                  : const Text(
                                      'Pause',
                                    ),
                            ),
                    ),
                    _paused
                        ? Chip(
                            label: Text(_timeSpent.toString() + ' min'),
                          )
                        : Chip(
                            backgroundColor: Colors.green,
                            label: Text(_timeSpent.toString() + ' min'),
                          ),
                  ],
                ),
                Expanded(
                  // SLIDERS
                  child: _trends.length > 0
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (final Trend _trend in _trends)
                              Column(
                                children: <Widget>[
                                  Expanded(
                                      child: RotatedBox(
                                    quarterTurns: -1,
                                    child: CupertinoSlider(
                                        value: _trend.rating,
                                        activeColor: _paused
                                            ? Colors.grey
                                            : _trend.color,
                                        min: Trend.minRating,
                                        max: Trend.maxRating,
                                        onChanged: (newRating) {
                                          setState(() {
                                            _trend.rating = newRating;
                                          });
                                        }),
                                  )),
                                  _paused
                                      ? _trend.name
                                      : Text(
                                          _trend.rating.round().toString(),
                                        ),
                                ],
                              ),
                          ],
                        )
                      : const Center(
                          child: const CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
