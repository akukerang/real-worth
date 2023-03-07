import 'package:flutter/material.dart';
import 'JobContainer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'Scatter.dart';

class SalaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: SizedBox(height: 250.0, child: Scatterplot())),
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
                margin: EdgeInsets.all(24),
                height: 150,
                child: const JobContainer(
                  company: "Google",
                  salary: "\$120000",
                  location: "Atlanta, GA",
                  position: "Software Engineer",
                )),
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
