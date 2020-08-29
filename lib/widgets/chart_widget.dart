// project
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter_moviesliders/models/trend_models.dart';
import 'package:flutter_moviesliders/models/rating_models.dart';

class NumericComboLinePointChart extends StatelessWidget {
  NumericComboLinePointChart(
      {@required this.seriesList, @required this.animate});

  final List<charts.Series> seriesList;
  final bool animate;

  /// Creates a [LineChart] with sample data and no transition.
  /*
  factory NumericComboLinePointChart.withSampleData({bool animate: true}) {
    return NumericComboLinePointChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: animate,
    );
  }
  */

  factory NumericComboLinePointChart.withRatings({
    @required final dynamic trendsList,
    final bool animate: true,
  }) {
    List<charts.Series<Rating, int>> trendSeries = [];

    for (final Trend trend in trendsList) {
      final charts.Series<Rating, int> trendSeri = charts.Series<Rating, int>(
        id: trend.rawName,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(trend.color),
        domainFn: (Rating rating, _) => rating.second,
        measureFn: (Rating rating, _) => rating.value,
        data: trend.ratings,
      );

      trendSeries.add(trendSeri);
      // break;
    }

    return NumericComboLinePointChart(
      seriesList: trendSeries,
      animate: animate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      seriesList,
      animate: animate,
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      // defaultRenderer: charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      // customSeriesRenderers: [
      //   charts.PointRendererConfig(
      //       // ID used to link series to this renderer.
      //       customRendererId: 'customPoint')
      // ],
      layoutConfig: charts.LayoutConfig(
          leftMarginSpec: charts.MarginSpec.fixedPixel(animate ? 23 : 0),
          topMarginSpec: charts.MarginSpec.fixedPixel(animate ? 14 : 6),
          rightMarginSpec: charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: charts.MarginSpec.fixedPixel(0)),
      // Y
      primaryMeasureAxis: charts.NumericAxisSpec(
        // domain axis line.
        showAxisLine: animate ? true : false,
        renderSpec: animate ? null : charts.NoneRenderSpec(),
      ),
      // X
      domainAxis: charts.NumericAxisSpec(
          // domain axis line.
          showAxisLine: animate ? true : false,
          // But don't draw anything else.
          renderSpec: charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  /*
  static List<charts.Series<Rating, int>> _createSampleData() {
    final interestData = [
      Rating(second: 0, value: 5),
      Rating(second: 1, value: 80),
      Rating(second: 2, value: 85),
      Rating(second: 3, value: 75),
    ];
    final clicheData = [
      Rating(second: 0, value: 2),
      Rating(second: 1, value: 2),
      Rating(second: 2, value: 10),
      Rating(second: 3, value: 22),
    ];
    final dumbData = [
      Rating(second: 0, value: 5),
      Rating(second: 1, value: 35),
      Rating(second: 2, value: 10),
      Rating(second: 3, value: 5),
    ];
    final wtfData = [
      Rating(second: 0, value: 2),
      Rating(second: 1, value: 2),
      Rating(second: 2, value: 22),
      Rating(second: 3, value: 2),
    ];
    final funnyData = [
      Rating(second: 0, value: 2),
      Rating(second: 1, value: 2),
      Rating(second: 2, value: 10),
      Rating(second: 3, value: 2),
    ];

    return [
      charts.Series<Rating, int>(
        id: 'Interest',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Rating rating, _) => rating.second,
        measureFn: (Rating rating, _) => rating.value,
        data: interestData,
      ),
      charts.Series<Rating, int>(
        id: 'Cliche',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Rating rating, _) => rating.second,
        measureFn: (Rating rating, _) => rating.value,
        data: clicheData,
      ),
      charts.Series<Rating, int>(
        id: 'Dumb',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (Rating rating, _) => rating.second,
        measureFn: (Rating rating, _) => rating.value,
        data: dumbData,
      ),
      charts.Series<Rating, int>(
        id: 'WTF',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (Rating rating, _) => rating.second,
        measureFn: (Rating rating, _) => rating.value,
        data: wtfData,
      ),
      charts.Series<Rating, int>(
        id: 'Funny',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Rating rating, _) => rating.second,
        measureFn: (Rating rating, _) => rating.value,
        data: funnyData,
      ),
      // charts.Series<Rating, int>(
      //     id: 'Mobile',
      //     colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      //     domainFn: (Rating sales, _) => sales.year,
      //     measureFn: (Rating sales, _) => sales.sales,
      //     data: mobileSalesData)
      // Configure our custom point renderer for this series.
      // ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
  */
}
