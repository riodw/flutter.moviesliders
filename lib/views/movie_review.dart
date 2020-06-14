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
        title: Text('Review'),
        actions: <Widget>[],
      ),
      body: Container(
        // margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: SafeArea(
            child: ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 15, right: 15),
            child: Text(
              'Black Mirror: Season 4 Episode 5 (Metalhead)',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15, right: 15),
            child: Text(
              '2017 - Rating: 6.9',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 7,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: NumericComboLinePointChart.withSampleData()),
          Container(
            // margin: EdgeInsets.only(bottom: 20.0),
            child: ButtonTheme(
              // minWidth: 200.0,
              height: 50.0,
              child: FlatButton(
                // textColor: Colors.white,
                child: Container(
                  child: Text(
                    'View Full Graph',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, '/signup');
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, left: 15, right: 15),
            child: Text(
              'Received a rating of 69/100',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: 6.0, bottom: 10.0, left: 15, right: 15),
            child: Text(
              'Exact rating: 69.0658333',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 35,
            thickness: 2,
            indent: 30,
            endIndent: 30,
          ),
          Container(
              margin:
                  EdgeInsets.only(top: 6.0, bottom: 10.0, left: 15, right: 15),
              child: Text(
                'Review',
                style: Theme.of(context).textTheme.headline2,
              )),
          Container(
              margin: EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
              child: Image.network(
                'https://m.media-amazon.com/images/M/MV5BYTM3YWVhMDMtNjczMy00NGEyLWJhZDctYjNhMTRkNDE0ZTI1XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SX1000.jpg',
              ))
        ])),
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
    return NumericComboLinePointChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      seriesList,
      animate: true,
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      defaultRenderer: charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      // customSeriesRenderers: [
      //   charts.PointRendererConfig(
      //       // ID used to link series to this renderer.
      //       customRendererId: 'customPoint')
      // ],
      layoutConfig: charts.LayoutConfig(
          leftMarginSpec: charts.MarginSpec.fixedPixel(23),
          topMarginSpec: charts.MarginSpec.fixedPixel(10),
          rightMarginSpec: charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: charts.MarginSpec.fixedPixel(10)),
      domainAxis: charts.NumericAxisSpec(
          // Make sure that we draw the domain axis line.
          showAxisLine: false,
          // But don't draw anything else.
          renderSpec: charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final interestData = [
      LinearSales(0, 5),
      LinearSales(1, 80),
      LinearSales(2, 85),
      LinearSales(3, 75),
    ];
    final clicheData = [
      LinearSales(0, 2),
      LinearSales(1, 2),
      LinearSales(2, 10),
      LinearSales(3, 22),
    ];
    final dumbData = [
      LinearSales(0, 5),
      LinearSales(1, 35),
      LinearSales(2, 10),
      LinearSales(3, 5),
    ];
    final wtfData = [
      LinearSales(0, 2),
      LinearSales(1, 2),
      LinearSales(2, 22),
      LinearSales(3, 2),
    ];
    final funnyData = [
      LinearSales(0, 2),
      LinearSales(1, 2),
      LinearSales(2, 10),
      LinearSales(3, 2),
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
