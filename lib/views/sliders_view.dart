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

// Navigator.pushNamed(context, '/sliders',
//     arguments: 'this is a test');

// List raw_ratings = [
//   {
//     'name': 'Interest',
//     'color': 'c62928',
//   },
//   {
//     'name': 'Cliche',
//     'color': '01e675',
//   },
//   {
//     'name': 'Funny',
//     'color': '2ab6f6',
//   },
//   {
//     'name': 'Dumb',
//     'color': 'bd00ff',
//   },
//   {
//     'name': 'WTF',
//     'color': 'fdff00',
//   },
// ];

class Rating {
  Rating(this.rawName, this.rawColor);

  static final double minRating = minimumRating;
  static final double maxRating = maximumRating;
  final String rawName, rawColor;
  Text _name;
  Color _color;
  double _rating = 40; // TODO change this to 2

  // getters
  Text get name => Text(this.rawName);
  Color get color => Color(int.parse('0xff${this.rawColor}'));
  double get rating => _rating;
  // setters
  set rating(double value) {
    _rating = value;
    print('Changed: ' + value.toString());
  }

  factory Rating.fromJson(Map<dynamic, dynamic> json) {
    return Rating(
      json['name'],
      json['color'],
    );
  }
}

// Future<List<Rating>> getRatings(
//     final String key, final DatabaseReference dbRef) async {
//   List<Rating> ratings = [];

//   var reviewTrendsFireReference =
//       dbRef.child('review').child(key).child('trend');

//   print(reviewTrendsFireReference);

//   final asdf = await reviewTrendsFireReference.once();

//   print(asdf);
//   // final asdf = await reviewFireReference.set(<String, Object>{});

//   for (var i = 0; i < raw_ratings.length; i++) {
//     var r = raw_ratings[i];
//     // Rating rate = ;
//     ratings.add(Rating(r['name'], r['color']));
//   }

//   return ratings;
// }

class SlidersView extends StatefulWidget {
  SlidersView({Key key, this.title: 'this'}) : super(key: key);

  final String title;

  @override
  _SlidersViewState createState() => _SlidersViewState();
}

// do away with the FutureBuilder in this case and extract all of the list processing code to initState.
// Call dbRef.child('foo_bar').once() in initState and with a .then callback, fill your elements list and call setState.

class _SlidersViewState extends State<SlidersView> {
  bool _paused = true;
  // firebase
  final DatabaseReference dbRef = FirebaseDatabase.instance.reference();

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

    var asdf = dbRef
        .child('review')
        .child('-MCt7kwueCB1EiaqO_Mw')
        .child('trend')
        .once();

    // for (var rating in snapshot.data.value) {
    //   ratings.add(Rating(rating['name'], rating['color']));
    // }
  }

  @override
  Widget build(BuildContext context) {
    // https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final OmdbModel omdb = arguments['omdb'];
    // print(arguments['review_fire_id']);

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
                            child: CircularProgressIndicator(),
                          )),
              ],
            ),
          ),
        ));
  }
}
