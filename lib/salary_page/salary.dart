import 'package:flutter/material.dart';
import 'JobContainer.dart';
import 'Scatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'getData.dart';
import 'addData.dart';

class SalaryPage extends StatelessWidget {
  String current =
      FirebaseAuth.instance.currentUser!.uid; //Gets current users ID

  @override
  Widget build(BuildContext context) {
    // addUser("white", "male", "none", "ha1kPTDW8RMwXf95JmRt", "Google",
    //     "Software Engineer", 70000, 10);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(
                    top: 25.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: getJobInfo(current)),
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
