// project
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter_moviesliders/models/trend.dart';
import 'package:flutter_moviesliders/models/rating.dart';

class NumericComboLinePointChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  NumericComboLinePointChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory NumericComboLinePointChart.withSampleData({bool animate: true}) {
    return NumericComboLinePointChart(
      _createSampleData(),
      // Disable animations for image tests.
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
      primaryMeasureAxis: charts.NumericAxisSpec(
        showAxisLine: false,
        // renderSpec: charts.NoneRenderSpec(),
      ),
      domainAxis: charts.NumericAxisSpec(
          // Make sure that we draw the domain axis line.
          showAxisLine: false,
          // But don't draw anything else.
          renderSpec: charts.NoneRenderSpec()
          //
          ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Rating, int>> _createSampleData() {
    final interestData = [
      Rating(0, 5),
      Rating(1, 80),
      Rating(2, 85),
      Rating(3, 75),
    ];
    final clicheData = [
      Rating(0, 2),
      Rating(1, 2),
      Rating(2, 10),
      Rating(3, 22),
    ];
    final dumbData = [
      Rating(0, 5),
      Rating(1, 35),
      Rating(2, 10),
      Rating(3, 5),
    ];
    final wtfData = [
      Rating(0, 2),
      Rating(1, 2),
      Rating(2, 22),
      Rating(3, 2),
    ];
    final funnyData = [
      Rating(0, 2),
      Rating(1, 2),
      Rating(2, 10),
      Rating(3, 2),
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
}

class NumericComboLinePointChartRaw extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  NumericComboLinePointChartRaw(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory NumericComboLinePointChartRaw.withSampleData({bool animate: true}) {
    return NumericComboLinePointChartRaw(
      _createSampleData(),
      // Disable animations for image tests.
      animate: animate,
    );
  }

  factory NumericComboLinePointChartRaw.withRatings(trendsList,
      {bool animate: true}) {
    List<charts.Series<Rating, int>> trendSeries = [];

    for (Trend trend in trendsList) {
      var trendSeri = charts.Series<Rating, int>(
        id: trend.rawName,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(trend.color),
        domainFn: (Rating rating, _) => rating.second,
        measureFn: (Rating rating, _) => rating.value,
        data: trend.ratings,
      );

      trendSeries.add(trendSeri);
      // break;
    }

    return NumericComboLinePointChartRaw(
      trendSeries,
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
      defaultRenderer: charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      // customSeriesRenderers: [
      //   charts.PointRendererConfig(
      //       // ID used to link series to this renderer.
      //       customRendererId: 'customPoint')
      // ],
      layoutConfig: charts.LayoutConfig(
          leftMarginSpec: charts.MarginSpec.fixedPixel(0),
          topMarginSpec: charts.MarginSpec.fixedPixel(6),
          rightMarginSpec: charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: charts.MarginSpec.fixedPixel(6)),
      primaryMeasureAxis: charts.NumericAxisSpec(
        showAxisLine: false,
        renderSpec: charts.NoneRenderSpec(),
      ),
      domainAxis: charts.NumericAxisSpec(
        // Make sure that we draw the domain axis line.
        showAxisLine: false,
        // But don't draw anything else.
        renderSpec: charts.NoneRenderSpec(),
        //
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Rating, int>> _createSampleData() {
    final interestData = [
      Rating(0, 5),
      Rating(1, 80),
      Rating(2, 85),
      Rating(3, 75),
    ];
    final clicheData = [
      Rating(0, 2),
      Rating(1, 2),
      Rating(2, 10),
      Rating(3, 22),
    ];
    final dumbData = [
      Rating(0, 5),
      Rating(1, 35),
      Rating(2, 10),
      Rating(3, 5),
    ];
    final wtfData = [
      Rating(0, 2),
      Rating(1, 2),
      Rating(2, 22),
      Rating(3, 2),
    ];
    final funnyData = [
      Rating(0, 2),
      Rating(1, 2),
      Rating(2, 10),
      Rating(3, 2),
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
}
