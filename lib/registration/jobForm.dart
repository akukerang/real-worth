import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_worth/login_forms/AuthCheck.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobPage extends StatefulWidget {
  final String email;
  final String password;
  final String gender;
  final String education;
  final String race;
  final String companyID;
  final String companyName;
  final String companyCity;
  final String companyState;

  const JobPage({
    super.key,
    required this.email,
    required this.password,
    required this.gender,
    required this.education,
    required this.race,
    required this.companyName,
    required this.companyCity,
    required this.companyState,
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
                if (value!.trim().isEmpty) {
                  return 'Please enter your job name';
                }
                return null;
              },
              onSaved: (value) {
                _jobName = value!.trim();
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _salaryController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
                  FirebaseFirestore.instance.collection('users').doc(UID).set({
                    'education': widget.education,
                    'gender': widget.gender,
                    'job': {
                      'company_id': widget.companyID,
                      'company_name': widget.companyName,
                      'job_title': _jobName!,
                      'salary': int.parse(_salary!),
                      'years': int.parse(_years!),
                    },
                    'race': widget.race,
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthCheck(),
                      ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
