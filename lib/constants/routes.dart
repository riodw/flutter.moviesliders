import 'package:flutter/material.dart';
import 'package:flutter_moviesliders/views/views.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiating this object
  static const String signin = '/signin';
  static const String myMovies = '/my_movies';
  static const String movieReview = '/movie_review';
  static const String chart = '/chart';
  static const String sliders = '/sliders';
  // static const String settings = '/settings';

  static final routes = <String, WidgetBuilder>{
    signin: (context) => SignInView(),
    myMovies: (context) => MyMoviesView(),
    movieReview: (context) => MovieReviewView(),
    chart: (context) => ChartView(),
    sliders: (context) => SlidersView(),
    // settings: ( context) => SettingsUI(),
  };
}
