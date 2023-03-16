import "package:flutter/material.dart";
import "package:real_worth/registration/companyList.dart";
import "../components/my_button.dart";
import "../components/my_dropdown.dart";
import "../components/label.dart";

class InformationPage extends StatefulWidget {
  final String email;
  final String password;
  const InformationPage(
      {super.key, required this.email, required this.password});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final _formKey = GlobalKey<FormState>();

  String? _gender;
  String? _education;
  String? _race;

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
                    //your Information title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Your Information',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 32,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),
                    const Label(label: "Race"),
                    //race
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
                        onChanged: (value) {
                          setState(() {
                            _race = value.toString();
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a race';
                          }
                          // return null;
                        }),

                    const Label(label: "Gender"),

                    //gender
                    MyDropdown(
                        menuItems: const ['Male', 'Female', 'Other'],
                        value: _gender,
                        hint: 'Select Gender',
                        onChanged: (value) {
                          setState(() {
                            _gender = value.toString();
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a gender';
                          }
                          return null;
                        }),

                    const Label(label: "Education"),

                    //education
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
                      onChanged: (value) {
                        setState(() {
                          _education = value.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a education level';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 60),

                    MyButton(
                      label: 'Next',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompanyList(
                                  gender: _gender!,
                                  education: _education!,
                                  race: _race!,
                                  email: widget.email,
                                  password: widget.password),
                            ),
                          );
                        }
                      },
                    ),
                  ]),
            ),
          ),
        )));
  }
}
