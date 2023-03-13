import 'package:flutter/material.dart';
import 'package:real_worth/registration/jobForm.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class JobInfoPage extends StatefulWidget {

  final String gender;
  final String education;
  final String race;
  final String email;
  final String password;

  const JobInfoPage ({
    super.key,
    required this.gender,
    required this.education,
    required this.race,
    required this.email,
    required this.password,
    });

  @override
  State<JobInfoPage> createState() => _JobInfoPageState();
}

class _JobInfoPageState extends State<JobInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final companyNameController = TextEditingController();
  final companyIDController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final salaryController = TextEditingController();

  String? _companyID;
  String? _companyName;
  String? _city;
  String? _state;
  String? _companyAddr;
  String? _salary;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //shrinkWrap: true,
                children: [
                  
                  //title
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
                    ],),
                  ),
                  
                  const SizedBox(height: 50),
            
                  //company name
                  MyTextField(
                    controller: companyNameController,
                    hintText:'Company Name', 
                    obscureText: false,
                    validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the company name';
                       }
                        return null;
                      },
                    onSaved: (value) {
                      _companyName = value!.trim();
                    },
                  ),
            
                  const SizedBox(height: 40),
            
                  //address
                  MyTextField(
                    controller: companyIDController,
                    hintText:'Company ID', 
                    validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the Company ID';
                        }
                        return null;
                      },
                    onSaved: (value) { 
                      _companyID = value!.trim();
                    }
                    ),
                  
                  const SizedBox(height: 40),
            
                  MyTextField(
                    controller: cityController,
                    hintText: 'City', 
                    validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter city';
                       }
                        return null;
                      },
                    onSaved: (value) {
                      _city = value!.trim();
                    }
                  ),
            
                  const SizedBox(height: 40),
            
                  MyTextField(
                    controller: stateController, 
                    hintText: 'State', 
                    obscureText: false,
                    validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the state';
                       }
                        return null;
                      },
                    onSaved: (value) {
                      _state = value!.trim();
                    },
                  ),

                  MyTextField(
                    controller: salaryController, 
                    hintText: 'Salary', 
                    obscureText: false,
                    validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter salary';
                       }
                        return null;
                      },
                    onSaved: (value) {
                      _salary = value!.trim();
                    },
                  ),

                  MyButton(
                    buttonText: 'Next',
                    onTap: () async {
                      _companyAddr = '${cityController.text.trim()}, ${stateController.text.trim()}';
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobPage(
                              companyName: _companyName!,
                              companyID: _companyID!,
                              companyAddr: _companyAddr!,
                              gender: widget.gender,
                              education: widget.education,
                              race: widget.race,
                              email: widget.email,
                              password: widget.password
                           ),
                          ),
                        );
                      }
                    }
                  ),
            
                ]
              ),
            ),
          ), 
        ),
      ),
    );
    
  }
}