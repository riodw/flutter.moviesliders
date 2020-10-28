import 'package:flutter/material.dart';
import 'package:flutter_moviesliders/views/views.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiating this object
  static const String signin = '/signin';
  // static const String myMovies = '/my_movies';
  static const String reviewSelected = '/review_selected';
  static const String chart = '/chart';
  // static const String sliders = '/sliders';
  static const String about = '/about';
  static const String movieInfo = '/movie_info';
  static const String tos = '/tos';
  static const String privacy = '/privacy';
  // static const String settings = '/settings';

  static final routes = <String, WidgetBuilder>{
    signin: (context) => SignInView(),
    // myMovies: (context) => ReviewsView(),
    reviewSelected: (context) => ReviewSelectedView(),
    chart: (context) => ChartView(),
    // sliders: (context) => SlidersView(),
    movieInfo: (context) => MovieInfoView(),
    about: (context) => AboutView(),
    tos: (context) => TermsOfServiceView(),
    privacy: (context) => PrivacyView(),
    // settings: ( context) => SettingsUI(),
  };
}
