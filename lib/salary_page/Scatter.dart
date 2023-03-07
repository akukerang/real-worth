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
  List<userData> males = [
    userData(1, 32000, "Male"),
    userData(2, 42000, "Male"),
    userData(4, 38000, "Male"),
    userData(10, 41000, "Male"),
  ];

  List<userData> females = [
    userData(2, 40000, "Female"),
    userData(6, 34000, "Female"),
    userData(6, 34000, "Female"),
    userData(5, 60000, "Female"),
  ];

  List<userData> other = [
    userData(1, 40000, "Other"),
  ];

  @override
  void initState() {
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
        legend: Legend(isVisible: true),
        primaryXAxis: NumericAxis(minimum: 1, maximum: 15),
        primaryYAxis: NumericAxis(
          minimum: 10000,
          labelFormat: '\${value}',
        ),
        zoomPanBehavior: _zoomPanBehavior,
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          // Renders scatter chart
          ScatterSeries<userData, int>(
            name: 'Male',
            dataSource: males,
            markerSettings: MarkerSettings(height: 10, width: 10),
            enableTooltip: true,
            xValueMapper: (userData data, _) => data.years,
            yValueMapper: (userData data, _) => data.salary,
          ),
          ScatterSeries<userData, int>(
            name: 'Female',
            dataSource: females,
            markerSettings: MarkerSettings(height: 12, width: 12),
            enableTooltip: true,
            xValueMapper: (userData data, _) => data.years,
            yValueMapper: (userData data, _) => data.salary,
          ),
          ScatterSeries<userData, int>(
            name: 'Other',
            dataSource: other,
            markerSettings: MarkerSettings(height: 12, width: 12),
            enableTooltip: true,
            xValueMapper: (userData data, _) => data.years,
            yValueMapper: (userData data, _) => data.salary,
          )
        ],
      ),
    );
  }
}
