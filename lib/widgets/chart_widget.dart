import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
