import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// charts
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

/* Comparison from episode to episode
https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class MyMoviesView extends StatefulWidget {
  MyMoviesView({Key key}) : super(key: key);

  @override
  _MyMoviesState createState() => _MyMoviesState();
}

class _MyMoviesState extends State<MyMoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rated Movies'),
        actions: <Widget>[],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: SafeArea(child: Container()),
      ),
    );
  }
}
