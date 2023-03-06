import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class userData {
  userData(this.years, this.salary, this.test);
  final String test;
  final int years;
  final int salary;
}

class Scatterplot extends StatefulWidget {
  Scatterplot({Key? key}) : super(key: key);

  @override
  State<Scatterplot> createState() => _ScatterplotState();
}

class _ScatterplotState extends State<Scatterplot> {
  late List<userData> chartData;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      maximumZoomLevel: 0.6,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: NumericAxis(),
        primaryYAxis: NumericAxis(
          labelFormat: '\${value}',
        ),
        zoomPanBehavior: _zoomPanBehavior,
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          // Renders scatter chart
          ScatterSeries<userData, int>(
              dataSource: chartData,
              markerSettings: MarkerSettings(height: 13, width: 13),
              enableTooltip: true,
              xValueMapper: (userData data, _) => data.years,
              yValueMapper: (userData data, _) => data.salary),
        ],
      ),
    );
  }

  List<userData> getChartData() {
    final List<userData> chartData = [
      userData(1, 32000, "Hello World"),
      userData(2, 40000, "Hello World"),
      userData(6, 34000, "Hello World"),
      userData(1, 52000, "Hello World"),
      userData(2, 42000, "Hello World"),
      userData(4, 38000, "Hello World"),
      userData(10, 41000, "Hello World"),
      userData(5, 60000, "Hello World"),
    ];
    return chartData;
  }
}
