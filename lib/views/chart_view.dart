import 'package:flutter/material.dart';
// project
import 'package:flutter_moviesliders/widgets/chart_widget.dart';
import 'package:flutter_moviesliders/models/models.dart';

/* Comparison from episode to episode
 * https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class ChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Review review = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Black Mirror: Season 4 Episode 5 (Metalhead)'),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Container(
            // margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: NumericComboLinePointChart.withRatings(review.trends,
                animate: false)),
      ),
    );
  }
}
