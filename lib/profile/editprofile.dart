import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../global/globalStyle.dart';

import '../components/my_button.dart';

class EditProfilePage extends StatefulWidget {
  final String current;
  final String compName;
  final String compID;
  const EditProfilePage(
      {super.key,
      required this.current,
      required this.compName,
      required this.compID});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _jobTitle;
  String? _salary;
  String? _education;
  String? _years;
  String? _race;
  String? _gender;
  final List<String> _raceOptions = [
    "White",
    "Black",
    "Asian",
    "Latino",
    "Other"
  ];
  final List<String> _educationOptions = [
    "None",
    "High School",
    "Associates",
    "Bachelors",
    "Masters",
    "PHD"
  ];

  final List<String> _genderOptions = ["Male", "Female", "Other"];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.current)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> currentUser =
                snapshot.data!.data() as Map<String, dynamic>;

            _jobTitle = currentUser['job']['job_title'];
            _salary = currentUser['job']['salary'].toString();
            _education = currentUser['education'];
            _years = currentUser['job']['years'].toString();
            _race = currentUser['race'];
            _gender = currentUser['gender'];
            return Scaffold(
              appBar: AppBar(
                title: const Text("Edit Profile"),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16.0),
                        const Text(
                          "Job Title",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: _jobTitle,
                          decoration: componentStyle.textFieldStyle(),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter a job title";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _jobTitle = value!.trim();
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          "Salary",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: componentStyle.textFieldStyle(),
                          initialValue: _salary,
                          onSaved: (value) {
                            setState(() {
                              _salary = value!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your salary";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          "Years Worked",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: _years,
                          decoration: componentStyle.textFieldStyle(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the number of years worked";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _years = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          "Race",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButtonFormField(
                            value: _race,
                            decoration: componentStyle.dropdownStyle(),
                            items: _raceOptions.map((race) {
                              return DropdownMenuItem(
                                value: race,
                                child: Text(race),
                              );
                            }).toList(),
                            onSaved: (value) {
                              setState(() {
                                _race = value as String?;
                              });
                            },
                            onChanged: (value) {}),
                        const SizedBox(height: 16.0),
                        const Text(
                          "Gender",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButtonFormField(
                            decoration: componentStyle.dropdownStyle(),
                            value: _gender,
                            items: _genderOptions.map((gender) {
                              return DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            onSaved: (value) {
                              setState(() {
                                _gender = value as String?;
                              });
                            },
                            onChanged: (value) {}),
                        const SizedBox(height: 16.0),
                        const Text(
                          "Education Level",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButtonFormField(
                          decoration: componentStyle.dropdownStyle(),
                          value: _education,
                          items: _educationOptions.map((education) {
                            return DropdownMenuItem(
                              value: education,
                              child: Text(education),
                            );
                          }).toList(),
                          onSaved: (value) {
                            setState(() {
                              _education = value as String?;
                            });
                          },
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 32.0),
                        MyButton(
                          label: "Save Changes",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.current)
                                  .set({
                                'education': _education,
                                'gender': _gender,
                                'job': {
                                  'company_id': widget.compID,
                                  'company_name': widget.compName,
                                  'job_title': _jobTitle!,
                                  'salary': int.parse(_salary!),
                                  'years': int.parse(_years!),
                                },
                                'race': _race,
                              });
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Profile Changed"),
                                        content: const Text(
                                            "Your profile has been successfully edited"),
                                        actions: [
                                          ElevatedButton(
                                              style: componentStyle
                                                  .elevatedStyle(),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Close"))
                                        ],
                                      ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
