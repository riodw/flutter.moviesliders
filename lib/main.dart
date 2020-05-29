import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// https://flutter.dev/docs/development/ui/interactive#managing-state

final double minimumRating = 2;
final double maximumRating = 100;

void main() {
  runApp(MyApp());
}

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

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blueAccent,
  primaryColorDark: Colors.blueGrey[400],
  accentColor: Colors.indigo,
  buttonColor: Colors.blueAccent,
  // scalling
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey[900],
  primaryColorDark: Colors.grey[900],
  accentColor: Colors.indigo[900],
  buttonColor: Colors.blueGrey[900],
  scaffoldBackgroundColor: Colors.black,
  // scalling
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieSliders',
      theme: lightTheme,
      home: MyHomePage(title: 'MovieSliders'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// class RatingWidget extends State {
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Expanded(
//           child: RotatedBox(
//         quarterTurns: -1,
//         child: CupertinoSlider(
//             value: 0.0,
//             activeColor: Colors.red,
//             min: Rating.minRating,
//             max: Rating.maxRating,
//             onChanged: (new_rating) {
//               print(new_rating);
//               setState(() {
//                 // rating.rating = new_rating;
//                 // rating_interest = new_rating;
//               });
//             }),
//       )),
//       // Text(
//       //   rating.rating.round().toString(),
//       // ),
//     ]);
//   }
// }

class _MyHomePageState extends State<MyHomePage> {
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
          // action button
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
                              onChanged: (new_rating) {
                                setState(() {
                                  rating.rating = new_rating;
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
