import 'package:flutter/material.dart';
import 'JobContainer.dart';
import 'Scatter.dart';
import 'getData.dart';

class SalaryPage extends StatefulWidget {
  final String current;
  final String company;
  final String category;
  const SalaryPage(
      {super.key,
      required this.current,
      required this.company,
      required this.category});

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(
                  top: 25.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: getJobInfo(widget.current)),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                  height: 250.0,
                  child: Scatterplot(
                    category: widget.category,
                    current: widget.current,
                    company: widget.company,
                  ))),
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
              margin: const EdgeInsets.all(24),
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
    );
  }
}
