import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/userData.dart';

Future<List<userData>> getSalaryData(
    String companyId, String parameter, dynamic equalTo) async {
  CollectionReference db = FirebaseFirestore.instance.collection('users');
  QuerySnapshot snap = await db
      .where("job.company_id", isEqualTo: companyId)
      .where(parameter, isEqualTo: equalTo)
      .get();
  final List<userData> allData = snap.docs
      .map((doc) => userData(doc['job']['years'], doc['job']['salary']))
      .toList();
  return allData;
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
    return FutureBuilder<List<List<userData>>>(
      future: Future.wait([
        getSalaryData("ha1kPTDW8RMwXf95JmRt", "gender", "male"),
        getSalaryData("ha1kPTDW8RMwXf95JmRt", "gender", "female"),
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
              primaryXAxis: NumericAxis(minimum: 1, maximum: 15),
              primaryYAxis: NumericAxis(
                minimum: 10000,
                maximum: 200000,
                labelFormat: '\${value}',
              ),
              zoomPanBehavior: _zoomPanBehavior,
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                ScatterSeries<userData, int>(
                  name: 'Male',
                  dataSource: data[0],
                  markerSettings: MarkerSettings(height: 10, width: 10),
                  enableTooltip: true,
                  xValueMapper: (userData data, _) => data.years,
                  yValueMapper: (userData data, _) => data.salary,
                ),
                ScatterSeries<userData, int>(
                  name: 'Female',
                  dataSource: data[1],
                  markerSettings: MarkerSettings(height: 12, width: 12),
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
}
