// Pub
import 'package:flutter/material.dart';
// Project
import 'package:flutter_moviesliders/widgets/chart_widget.dart';
import 'package:flutter_moviesliders/models/models.dart';

/* Comparison from episode to episode
 * https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class ChartView extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final Review review = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(review.title),
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 1.5,
                      padding: EdgeInsets.only(left: 3, bottom: 9),
                      child: NumericComboLinePointChart.withRatings(
                        trendsList: review.trends,
                        // animate: true
                      )))),
        ],
      )),
    );
  }
}
