import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobContainer extends StatelessWidget {
  final String position;
  final String years;
  final int salary;

  JobContainer({
    Key? key,
    required this.position,
    required this.years,
    required this.salary,
  }) : super(key: key);

  final currencyFormat = NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.8),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              const Text(
                "Years worked: ",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(
                years,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              const Text("Salary: ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              Text(currencyFormat.format(salary),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
