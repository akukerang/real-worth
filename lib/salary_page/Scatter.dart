import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/userData.dart';
import 'dart:math';

Future<List<userData>> getCurrentSalaryData(String current) async {
  CollectionReference db = FirebaseFirestore.instance.collection('users');
  QuerySnapshot snap =
      await db.where(FieldPath.documentId, isEqualTo: current).get();
  final List<userData> allData = snap.docs
      .map((doc) => userData(doc['job']['years'], doc['job']['salary']))
      .toList();
  return allData;
}

Future<List<userData>> getSalaryData(
    String companyId, String current, String parameter, dynamic equalTo) async {
  CollectionReference db = FirebaseFirestore.instance.collection('users');
  QuerySnapshot snap = await db
      .where("job.company_id", isEqualTo: companyId)
      .where(FieldPath.documentId, isNotEqualTo: current)
      .where(parameter, isEqualTo: equalTo)
      .get();
  final List<userData> allData = snap.docs
      .map((doc) => userData(doc['job']['years'], doc['job']['salary']))
      .toList();
  return allData;
}

Future<List<userData>> getAllData(String companyId) async {
  CollectionReference db = FirebaseFirestore.instance.collection('users');
  QuerySnapshot snap =
      await db.where("job.company_id", isEqualTo: companyId).get();
  final List<userData> allData = snap.docs
      .map((doc) => userData(doc['job']['years'], doc['job']['salary']))
      .toList();
  return allData;
}

class Scatterplot extends StatefulWidget {
  final String category;
  final String company;
  final String current;
  const Scatterplot(
      {Key? key,
      required this.category,
      required this.company,
      required this.current})
      : super(key: key);

  @override
  State<Scatterplot> createState() => _ScatterplotState();
}

class _ScatterplotState extends State<Scatterplot> {
  late List<userData> chartData;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

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
    switch (widget.category) {
      case "gender":
        {
          return FutureBuilder<List<List<userData>>>(
            future: Future.wait([
              getSalaryData(widget.company, widget.current, "gender", "male"),
              getSalaryData(widget.company, widget.current, "gender", "female"),
              getSalaryData(widget.company, widget.current, "gender", "other"),
              getCurrentSalaryData(widget.current),
              getAllData(widget.company),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<List<userData>> data = snapshot.data!;
                return Container(
                  child: SfCartesianChart(
                    legend: Legend(isVisible: true),
                    primaryXAxis: NumericAxis(
                      minimum: data[data.length - 1]
                          .map((user) => user.years)
                          .reduce(min)
                          .toDouble(),
                      maximum: data[data.length - 1]
                              .map((user) => user.years)
                              .reduce(max) +
                          5,
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: data[data.length - 1]
                              .map((user) => user.salary)
                              .reduce(min) -
                          10000,
                      maximum: data[data.length - 1]
                              .map((user) => user.salary)
                              .reduce(max) +
                          10000,
                      numberFormat: NumberFormat.compactSimpleCurrency(),
                    ),
                    zoomPanBehavior: _zoomPanBehavior,
                    tooltipBehavior: _tooltipBehavior,
                    series: <ChartSeries>[
                      ScatterSeries<userData, int>(
                        name: 'Male',
                        color: Colors.blue,
                        dataSource: data[0],
                        markerSettings:
                            const MarkerSettings(height: 10, width: 10),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Female',
                        color: Colors.pink,
                        dataSource: data[1],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Other',
                        color: Colors.purple,
                        dataSource: data[2],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Me',
                        color: Colors.green,
                        dataSource: data[3],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      )
                    ],
                  ),
                );
              }
            },
          );
        }
      case "education":
        {
          return FutureBuilder<List<List<userData>>>(
            future: Future.wait([
              getSalaryData(
                  widget.company, widget.current, "education", "none"),
              getSalaryData(
                  widget.company, widget.current, "education", "highschool"),
              getSalaryData(
                  widget.company, widget.current, "education", "associate"),
              getSalaryData(
                  widget.company, widget.current, "education", "bachelor"),
              getSalaryData(
                  widget.company, widget.current, "education", "master"),
              getSalaryData(widget.company, widget.current, "education", "phd"),
              getCurrentSalaryData(widget.current),
              getAllData(widget.company),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<List<userData>> data = snapshot.data!;
                return Container(
                  child: SfCartesianChart(
                    legend: Legend(isVisible: true),
                    primaryXAxis: NumericAxis(
                      minimum: data[data.length - 1]
                          .map((user) => user.years)
                          .reduce(min)
                          .toDouble(),
                      maximum: data[data.length - 1]
                              .map((user) => user.years)
                              .reduce(max) +
                          5,
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: data[data.length - 1]
                              .map((user) => user.salary)
                              .reduce(min) -
                          10000,
                      maximum: data[data.length - 1]
                              .map((user) => user.salary)
                              .reduce(max) +
                          10000,
                      numberFormat: NumberFormat.compactSimpleCurrency(),
                    ),
                    zoomPanBehavior: _zoomPanBehavior,
                    tooltipBehavior: _tooltipBehavior,
                    series: <ChartSeries>[
                      ScatterSeries<userData, int>(
                        name: 'None',
                        color: Colors.blue,
                        dataSource: data[0],
                        markerSettings:
                            const MarkerSettings(height: 10, width: 10),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'High School',
                        color: Colors.pink,
                        dataSource: data[1],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Associates',
                        color: Colors.purple,
                        dataSource: data[2],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Bachelor',
                        color: Colors.deepPurple,
                        dataSource: data[3],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Master',
                        color: Colors.amber,
                        dataSource: data[4],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'PHD',
                        color: Colors.teal,
                        dataSource: data[5],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Me',
                        color: Colors.green,
                        dataSource: data[6],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      )
                    ],
                  ),
                );
              }
            },
          );
        }
      case "race":
        {
          return FutureBuilder<List<List<userData>>>(
            future: Future.wait([
              getSalaryData(widget.company, widget.current, "race", "white"),
              getSalaryData(widget.company, widget.current, "race", "black"),
              getSalaryData(widget.company, widget.current, "race", "asian"),
              getSalaryData(widget.company, widget.current, "race", "hispanic"),
              getSalaryData(widget.company, widget.current, "race", "other"),
              getCurrentSalaryData(widget.current),
              getAllData(widget.company),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<List<userData>> data = snapshot.data!;
                return Container(
                  child: SfCartesianChart(
                    legend: Legend(isVisible: true),
                    primaryXAxis: NumericAxis(
                      minimum: data[data.length - 1]
                          .map((user) => user.years)
                          .reduce(min)
                          .toDouble(),
                      maximum: data[data.length - 1]
                              .map((user) => user.years)
                              .reduce(max) +
                          5,
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: data[data.length - 1]
                              .map((user) => user.salary)
                              .reduce(min) -
                          10000,
                      maximum: data[data.length - 1]
                              .map((user) => user.salary)
                              .reduce(max) +
                          10000,
                      numberFormat: NumberFormat.compactSimpleCurrency(),
                    ),
                    zoomPanBehavior: _zoomPanBehavior,
                    tooltipBehavior: _tooltipBehavior,
                    series: <ChartSeries>[
                      ScatterSeries<userData, int>(
                        name: 'White',
                        color: Colors.blue,
                        dataSource: data[0],
                        markerSettings:
                            const MarkerSettings(height: 10, width: 10),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Black',
                        color: Colors.pink,
                        dataSource: data[1],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Asian',
                        color: Colors.purple,
                        dataSource: data[2],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Hispanic',
                        color: Colors.deepPurple,
                        dataSource: data[3],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Other',
                        color: Colors.amber,
                        dataSource: data[4],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      ),
                      ScatterSeries<userData, int>(
                        name: 'Me',
                        color: Colors.green,
                        dataSource: data[5],
                        markerSettings:
                            const MarkerSettings(height: 12, width: 12),
                        enableTooltip: true,
                        xValueMapper: (userData data, _) => data.years,
                        yValueMapper: (userData data, _) => data.salary,
                      )
                    ],
                  ),
                );
              }
            },
          );
        }
      default:
        {
          return const Text("ERROR");
        }
    }
  }
}
