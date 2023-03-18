import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_worth/components/my_button.dart';
import 'package:real_worth/login_forms/AuthCheck.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/my_textfield.dart';
import '../components/label.dart';

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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Job Information',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  
                  const Label(label: "Job Title"),
                  MyTextField(
                    controller: _jobNameController,
                    hintText: 'Enter your job title',
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
                  
                  const Label(label: "Salary"),
                  
                  MyTextField(
                    keyboardType: TextInputType.number,
                    controller: _salaryController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    hintText: 'Enter your salary',
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
                  
                  const Label(label: "Years worked"),
                  
                  MyTextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _yearsController,
                    hintText: 'Enter your years worked there',
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
                  
                  MyButton(
                    label: 'Next',
                    onTap: () async {
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
          ),
        ),
      ),
    );
  }
}
