import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// charts
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

/* Comparison from episode to episode
https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/ 


class MovieReviewView extends StatefulWidget {
  MovieReviewView({Key key}) : super(key: key);

  @override
  _MovieReviewState createState() => _MovieReviewState();
}

class _MovieReviewState extends State<MovieReviewView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Rated Movies'),
        actions: <Widget>[
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: SafeArea(
          child: Container(
            child: NumericComboLinePointChart.withSampleData()
          )
        ),
      ),
    );
  }
}



class NumericComboLinePointChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  NumericComboLinePointChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory NumericComboLinePointChart.withSampleData() {
    return new NumericComboLinePointChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.NumericComboChart(seriesList,
        animate: animate,
        // Configure the default renderer as a line renderer. This will be used
        // for any series that does not define a rendererIdKey.
        defaultRenderer: new charts.LineRendererConfig(),
        // Custom renderer configuration for the point series.
        customSeriesRenderers: [
          new charts.PointRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customPoint')
        ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final interestData = [
      new LinearSales(0, 5),
      new LinearSales(1, 80),
      new LinearSales(2, 85),
      new LinearSales(3, 75),
    ];
    final clicheData = [
      new LinearSales(0, 2),
      new LinearSales(1, 2),
      new LinearSales(2, 10),
      new LinearSales(3, 22),
    ];
    final dumbData = [
      new LinearSales(0, 5),
      new LinearSales(1, 35),
      new LinearSales(2, 10),
      new LinearSales(3, 5),
    ];
    final wtfData = [
      new LinearSales(0, 2),
      new LinearSales(1, 2),
      new LinearSales(2, 22),
      new LinearSales(3, 2),
    ];
    final funnyData = [
      new LinearSales(0, 2),
      new LinearSales(1, 2),
      new LinearSales(2, 10),
      new LinearSales(3, 2),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Interest',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: interestData,
      ),
      charts.Series<LinearSales, int>(
        id: 'Cliche',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: clicheData,
      ),
      charts.Series<LinearSales, int>(
        id: 'Dumb',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: dumbData,
      ),
      charts.Series<LinearSales, int>(
        id: 'WTF',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: wtfData,
      ),
      charts.Series<LinearSales, int>(
        id: 'Funny',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: funnyData,
      ),
      // charts.Series<LinearSales, int>(
      //     id: 'Mobile',
      //     colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      //     domainFn: (LinearSales sales, _) => sales.year,
      //     measureFn: (LinearSales sales, _) => sales.sales,
      //     data: mobileSalesData)
        // Configure our custom point renderer for this series.
        // ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
