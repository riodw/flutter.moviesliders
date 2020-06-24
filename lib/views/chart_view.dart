import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// charts
import 'package:flutter_moviesliders/widgets/chart_widget.dart';

/* Comparison from episode to episode
https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class ChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Black Mirror: Season 4 Episode 5 (Metalhead)'),
        actions: <Widget>[],
      ),
      body: Container(
        // margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: SafeArea(
            child: NumericComboLinePointChart.withSampleData(animate: false)),
      ),
    );
  }
}
