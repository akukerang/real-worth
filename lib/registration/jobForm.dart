import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_worth/login_forms/AuthCheck.dart';
import '../login_forms/login_page1.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobPage extends StatefulWidget {
  final String email;
  final String password;
  final String gender;
  final String education;
  final String race;
  final String companyID;
  final String companyName;
  final String companyAddr;

  const JobPage({
    super.key,
    required this.email,
    required this.password,
    required this.gender,
    required this.education,
    required this.race,
    required this.companyName,
    required this.companyAddr,
    required this.companyID,
  });

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  final _formKey = GlobalKey<FormState>();
  final _jobNameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _yearsController = TextEditingController();
  String? _jobName;
  String? _salary;
  String? _years;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your Job Info'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextFormField(
              controller: _jobNameController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'Job Name',
                hintText: 'Enter your job name',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your job name';
                }
                return null;
              },
              onSaved: (value) {
                _jobName = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _salaryController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'Salary',
                hintText: 'Enter your salary',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your salary';
                }
                return null;
              },
              onSaved: (value) {
                _salary = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _yearsController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'Years',
                hintText: 'Enter your years worked there',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your years worked';
                }
                return null;
              },
              onSaved: (value) {
                _years = value;
              },
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  final UserCredential userCredential = await FirebaseAuth
                      .instance
                      .createUserWithEmailAndPassword(
                          email: widget.email, password: widget.password);
                  final String UID = userCredential.user!.uid;
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(UID)
                      .set({
                        'education': widget.education,
                        'gender': widget.gender,
                        'job': {
                          'company_id': widget.companyID,
                          'company_name': widget.companyName,
                          'job_title': _jobName!,
                          'salary': _salary!,
                          'years': _years!,
                        },
                        'race': widget.race,
                      })
                      .then((value) => print('ADDED'))
                      .catchError((error) => print('error $error'));
                  FirebaseFirestore.instance
                      .collection('users')
                      .add({
                        'education': widget.education,
                        'gender': widget.gender,
                        'job': {
                          'company_id': widget.companyID,
                          'company_name': widget.companyName,
                          'job_title': _jobName!,
                          'salary': _salary!,
                          'years': _years!,
                        },
                        'race': widget.race,
                      })
                      .then((value) => print('test'))
                      .catchError((error) => print('error $error'));
                  // Navigator.pop(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => LoginPage(),
                  //   ),
                  // );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
