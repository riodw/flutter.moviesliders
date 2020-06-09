import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
// https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_auth/firebase_auth/example
import 'package:google_sign_in/google_sign_in.dart';

// https://flutter.dev/docs/development/ui/interactive#managing-state

// Auth
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

//
final double minimumRating = 2;
final double maximumRating = 100;

// Auth Function
Future<FirebaseUser> _handleSignInWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.displayName);
  return user;
}

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MovieSliders',
        theme: lightTheme,
        initialRoute: '/',
        routes: {
          // '/': (BuildContext context) => MyHomePage(title: 'MovieSliders'),
          '/': (BuildContext context) => HomePage(),
          // '/signup': (BuildContext context) => SignUp(),
          // '/signup_step_through': (BuildContext context) => SignUpStepThrough(),
        }
        // home: MyHomePage(title: 'MovieSliders'),
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

class HomePage extends StatelessWidget {
  Color gradientStart = Colors.transparent;
  Color gradientEnd = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [gradientStart, gradientEnd],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height - 20));
          },
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.redAccent,
              // gradient: LinearGradient(
              //     colors: [gradientStart, gradientEnd],
              //     begin: FractionalOffset(0, 0),
              //     end: FractionalOffset(0, 1),
              //     stops: [0.0, 1.0],
              //     tileMode: TileMode.clamp),
              image: DecorationImage(
                image: ExactAssetImage('assets/images/home-2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: Container(
                child: Align(
                  alignment: FractionalOffset(0.5, 0.0),
                  child: Container(
                      margin: EdgeInsets.only(top: 100.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius:
                                22.0, // has the effect of softening the shadow
                            spreadRadius:
                                1, // has the effect of extending the shadow
                            // offset: Offset(
                            // 10.0, // horizontal, move right 10
                            // 10.0, // vertical, move down 10
                            // ),
                          )
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius:
                                  0, // has the effect of softening the shadow
                              spreadRadius:
                                  0, // has the effect of extending the shadow
                            )
                          ],
                        ),
                        child: Image.asset(
                            'assets/images/moviesliders_icon.png',
                            width: 70),
                      )),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'MovieSliders',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
              flex: 0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 28.0),
                child: Text(
                  'We do all the best for your future endeavors by providing the connections you need during your job seeking process.',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.symmetric(vertical: 18.0),
                constraints: BoxConstraints(
                  maxWidth: 330.0,
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: ButtonTheme(
                minWidth: 320.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  textColor: Colors.blueAccent,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    child: Text(
                      'Continue with Apple',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ButtonTheme(
                  minWidth: 320.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () async {
                      _handleSignInWithGoogle()
                          .then((FirebaseUser user) => print(user))
                          .catchError((e) => print(e));
                    },
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    textColor: Colors.white,
                    child: Container(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
          ],
        ),
      ]),
    );
  }
}
