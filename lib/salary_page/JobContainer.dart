import 'package:flutter/material.dart';

class JobContainer extends StatelessWidget {
  final String company;
  final String position;
  final String location;
  final String salary;

  const JobContainer({
    Key? key,
    required this.company,
    required this.position,
    required this.location,
    required this.salary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.8),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            company,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            position,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 8.0),
              Text(location),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            salary,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
