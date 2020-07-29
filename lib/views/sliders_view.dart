import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// firebase
import 'package:firebase_database/firebase_database.dart';
// project
import 'package:flutter_moviesliders/models/models.dart';
import 'package:flutter_moviesliders/services/services.dart';

final double minimumRating = 2;
final double maximumRating = 100;

class Rating {
  Rating(this.rawName, this.rawColor, this.trend);
  // Rating(
  //   this.rawName,
  //   this.rawColor,
  // );

  static final double minRating = minimumRating;
  static final double maxRating = maximumRating;
  final String rawName, rawColor;
  Text _name;
  Color _color;
  double _rating = 40; // TODO change this to 2
  DatabaseReference trend;

  // getters
  Text get name => Text(this.rawName);
  Color get color => Color(int.parse('0xff${this.rawColor}'));
  double get rating => _rating;
  // setters
  set rating(double value) {
    _rating = value;
    // print('Changed: ' + value.toString());
  }

  // factory Rating.fromJson(Map<dynamic, dynamic> json) {
  //   return Rating(
  //     json['name'],
  //     json['color'],
  //   );
  // }
}

class SlidersView extends StatefulWidget {
  SlidersView({Key key, this.title: 'this'}) : super(key: key);

  final String title;

  @override
  _SlidersViewState createState() => _SlidersViewState();
}

class _SlidersViewState extends State<SlidersView> {
  bool _paused = true;
  final DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  DatabaseReference trends;
  Timer timer;

  // List<DatabaseReference> review_trends;
  List<Rating> ratings = [];

  void _pause() {
    setState(() {
      _paused = !_paused;
    });
  }

  // updateSlider(Rating rating, double newRating) {
  //   setState(() {
  //     rating.rating = newRating;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    /*
      do away with the FutureBuilder in this case and extract all of the list 
      processing code to initState.
      Call dbRef.child('foo_bar').once() in initState and with a .then callback, 
      fill your elements list and call setState.
    */
    DatabaseReference review_trends =
        dbRef.child('review').child('-MDMuzY0Cgm2oDLCLAL2').child('trend');

    review_trends.once().then((DataSnapshot snapshot) {
      setState(() {
        snapshot.value.forEach((key, value) {
          // print(key.toString() + ' : ' + value.toString());
          ratings.add(Rating(value['name'], value['color'],
              review_trends.child(key.toString())));
        });
      });
    });

    //
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => updateTrends());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void updateTrends() {
    if (!_paused) print(ratings.length);
  }

  @override
  Widget build(BuildContext context) {
    // https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final OmdbModel omdb = arguments['omdb'];

    return Scaffold(
        appBar: AppBar(
          title: Text(arguments['title']),
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
                      label: Text(omdb.runtime),
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
                      label: Text('160 min'),
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
