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
    );

    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey[900],
      primaryColorDark: Colors.grey[900],
      accentColor: Colors.indigo[900],
      buttonColor: Colors.blueGrey[900],
      scaffoldBackgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return Provider(
      auth: AuthService(),
      child: MaterialApp(
          title: 'MovieSliders',
          theme: lightTheme,
          initialRoute: '/movie_review',
          routes: <String, WidgetBuilder>{
            '/log_in': (BuildContext context) => LogInView(),
            '/my_movies': (BuildContext context) => MyMoviesView(),
            '/movie_review': (BuildContext context) => MovieReviewView(),
            '/sliders': (BuildContext context) => HomeController(),
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
          print(snapshot.hasData);
          final bool signedIn = snapshot.hasData;
          return signedIn ? SlidersView(title: 'Movies') : LogInView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
