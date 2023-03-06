import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

final data = [
  ScatterSpot(4, 40000),
  ScatterSpot(5, 50000),
  ScatterSpot(1, 50000),
  ScatterSpot(3, 30000),
  ScatterSpot(1, 10000),
  ScatterSpot(2, 50000),
  ScatterSpot(9, 20000),
];

final chart = ScatterChart(
  ScatterChartData(
    backgroundColor: Colors.white,
    scatterSpots: data,
    minX: 0,
    maxX: 10,
    minY: 0,
    maxY: 100000,
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        axisNameWidget: Text(
          "Salary",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 18,
          ),
        ),
        axisNameSize: 30,
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      bottomTitles: AxisTitles(
        axisNameWidget: Text(
          "Years Worked",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 18,
          ),
        ),
        axisNameSize: 24,
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 24,
        ),
      ),
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 45,
      )),
      topTitles: AxisTitles(
          axisNameSize: 30,
          sideTitles: SideTitles(
            showTitles: false,
          )),
    ),
  ),
);

class SalaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SF Pro Rounded',
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                      text: "JOB_NAME ",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  TextSpan(text: "Salaries at\n"),
                  TextSpan(
                      text: "COMPANY_NAME",
                      style: TextStyle(fontWeight: FontWeight.w400))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(height: 250.0, child: chart),
            ),
            const Text(
              "Similar Salary in the Area",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SF Pro Rounded',
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              height: 175,
            ),
            const Text(
              "Tips for Asking for a Raise",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SF Pro Rounded',
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
