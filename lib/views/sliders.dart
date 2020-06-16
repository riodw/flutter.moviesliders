import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart';

final double minimumRating = 2;
final double maximumRating = 100;

List raw_ratings = [
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

class Rating {
  Rating(this.rawName, this.rawColor);

  static final double minRating = minimumRating;
  static final double maxRating = maximumRating;
  final String rawName, rawColor;
  Text _name;
  Color _color;
  double _rating = 40;

  // getters
  Text get name => Text(this.rawName);
  Color get color => Color(int.parse("0xff${this.rawColor}"));
  double get rating => _rating;
  // setters
  set rating(double value) {
    _rating = value;
    // print('Changed');
  }
}

List getRatings() {
  List<Rating> ratings = [];

  for (var i = 0; i < raw_ratings.length; i++) {
    var r = raw_ratings[i];
    // Rating rate = ;
    ratings.add(Rating(r['name'], r['color']));
  }

  return ratings;
}

class SlidersView extends StatefulWidget {
  SlidersView({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _SlidersViewState createState() => _SlidersViewState();
}

class _SlidersViewState extends State<SlidersView> {
  bool _darkMode = false;
  bool _paused = true;
  // ratings
  final List ratings = getRatings();

  @override
  void initState() {
    super.initState();
    _loadDarkMode();
  }

  // darkMode - Loading darkMode value on start
  _loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = (prefs.getBool('darkMode') ?? false);
    });
  }

  // darkMode - Incrementing counter after click
  _flipDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = !(prefs.getBool('darkMode') ?? false);
      prefs.setBool('darkMode', _darkMode);
    });
  }

  void _pause() {
    setState(() {
      _paused = !_paused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // action buttons
          IconButton(
            icon: _darkMode
                ? Icon(Icons.brightness_low)
                : Icon(Icons.brightness_high),
            onPressed: _flipDarkMode,
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Container(
                margin:
                    const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CupertinoButton(
                      child: _paused ? Text('Play') : Text('Pause'),
                      color: _paused
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColorDark,
                      onPressed: _pause,
                    ),
                  ],
                )),
            Expanded(
              child: Row(
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
                              activeColor: _paused ? Colors.grey : rating.color,
                              min: Rating.minRating,
                              max: Rating.maxRating,
                              onChanged: (newRating) {
                                setState(() {
                                  rating.rating = newRating;
                                });
                              }),
                        )),
                        Text(
                          rating.rating.round().toString(),
                        ),
                      ]),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
