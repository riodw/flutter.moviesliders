import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// - auth
import 'package:flutter_moviesliders/services/auth_service.dart';
import 'package:flutter_moviesliders/widgets/provider_widget.dart';
// Project
import 'package:flutter_moviesliders/views/log_in.dart';
import 'package:flutter_moviesliders/views/my_movies.dart';
import 'package:flutter_moviesliders/views/movie_review.dart';
import 'package:flutter_moviesliders/views/sliders.dart';

// https://flutter.dev/docs/development/ui/interactive#managing-state

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blueAccent,
      primaryColorDark: Colors.blueGrey[400],
      accentColor: Colors.indigo,
      buttonColor: Colors.blueAccent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // text
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline2: TextStyle(
            fontSize: 40.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia'),
        headline4:
            TextStyle(fontSize: 30.0, color: Colors.black, fontFamily: 'Hind'),
        headline5: TextStyle(
            fontSize: 24.0, color: Colors.grey[700], fontFamily: 'Hind'),
        headline6: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );

    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey[900],
      primaryColorDark: Colors.grey[900],
      accentColor: Colors.indigo[900],
      buttonColor: Colors.blueGrey[900],
      scaffoldBackgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // text
      // textTheme: TextTheme(
      //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      // ),
    );

    return Provider(
      auth: AuthService(),
      child: MaterialApp(
          title: 'MovieSliders',
          theme: lightTheme,
          initialRoute: '/my_movies',
          routes: <String, WidgetBuilder>{
            '/log_in': (BuildContext context) => LogInView(),
            '/my_movies': (BuildContext context) => HomeController(),
            '/movie_review': (BuildContext context) => MovieReviewView(),
            '/sliders': (BuildContext context) => SlidersView(title: 'Movies'),
          }),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? MyMoviesView() : LogInView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
