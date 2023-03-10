import 'package:flutter/material.dart';
import '../salary_page/getData.dart';
import 'companyList.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _email;
  String? _password;
  String? _gender;
  String? _education;
  String? _race;

  late bool emailExist;
  bool weakPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your Info'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'Email',
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Please enter your email';
                } else if (emailExist) {
                  return 'This account already exists';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!.trim();
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'Password',
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                } else if (weakPassword) {
                  return 'Please choose a stronger password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              value: _gender,
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              hint: const Text('Select Gender'),
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
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              value: _education,
              items: const [
                DropdownMenuItem(value: 'None', child: Text('None')),
                DropdownMenuItem(
                    value: 'High School', child: Text('High School')),
                DropdownMenuItem(
                    value: 'Associates', child: Text('Associates')),
                DropdownMenuItem(value: 'Bachelors', child: Text('Bachelors')),
                DropdownMenuItem(value: 'Masters', child: Text('Masters')),
                DropdownMenuItem(value: 'PHD', child: Text('PHD')),
              ],
              hint: const Text('Select Education Level'),
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
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              value: _race,
              items: const [
                DropdownMenuItem(value: 'White', child: Text('White')),
                DropdownMenuItem(value: 'Black', child: Text('Black')),
                DropdownMenuItem(value: 'Asian', child: Text('Asian')),
                DropdownMenuItem(value: 'Latino', child: Text('Latino')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              hint: const Text('Select a Race'),
              onChanged: (value) {
                setState(() {
                  _race = value.toString();
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a race';
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () async {
                emailExist = await checkEmailExist(_emailController.text);
                if (_passwordController.text.length < 6) {
                  weakPassword = true;
                } else {
                  weakPassword = false;
                }
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompanyList(
                        email: _email!,
                        password: _password!,
                        gender: _gender!,
                        education: _education!,
                        race: _race!,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
