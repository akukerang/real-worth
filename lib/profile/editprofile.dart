import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_worth/components/my_textfield.dart';
import '../components/label.dart';
import '../components/my_dropdown.dart';
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

                        const Label(label: "Job Title"),

                        MyTextField(
                          initialValue: _jobTitle,
                          hintText: "Job Title",
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

                        const Label(label: "Salary"),
                        
                        MyTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: "Salary",
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

                        const Label(label: "Years Worked"),

                        MyTextField(
                          initialValue: _years,
                          hintText: "Years worked",
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

                        const Label(label:"Race"),
                          
                        MyDropdown(
                            menuItems: const [
                              'White',
                              'Black',
                              'Asian',
                              'Latino',
                              'Other'
                            ],
                            value: _race,
                            hint: 'Select a Race',
                            onSaved: (value) {
                              setState(() {
                                _race = value.toString();
                              });
                            },
                            onChanged: (value) {},
                            validator: (value) {}
                        ),

                        
                        const Label(label: "Gender"),
                        
                        MyDropdown(
                            menuItems: const ['Male', 'Female', 'Other'],
                            value: _gender,
                            hint: 'Select Gender',
                            onSaved: (value) {
                              setState(() {
                                _gender = value.toString();
                              });
                            },
                            onChanged: (value) {},
                            validator: (value) {}
                        ),
                        
                        const Label(label: "Education Level"),
                
                        MyDropdown(
                          menuItems: const [
                            'None',
                            'High School',
                            'Associates',
                            'Bachelors',
                            'Masters',
                            'PHD'
                          ],
                          value: _education,
                          hint: 'Select Education Level',
                          onSaved: (value) {
                            setState(() {
                              _education = value.toString();
                            });
                          },
                          onChanged: (value) {},
                          validator: (value) {},
                        ),

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
