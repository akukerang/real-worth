import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../salary_page/getData.dart';

class RegisterCompany extends StatefulWidget {
  const RegisterCompany({Key? key}) : super(key: key);
  @override
  State<RegisterCompany> createState() => _RegisterCompanyState();
}

class _RegisterCompanyState extends State<RegisterCompany> {
  final _formKey = GlobalKey<FormState>();
  final _compNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipcodeController = TextEditingController();

  String? _compName;
  String? _compAddr;
  String? _street;
  String? _city;
  String? _state;
  String? _zipcode;
  late bool exists;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Company'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextFormField(
              controller: _compNameController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'Company Name',
                hintText: 'Enter the company name',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Please enter the company name';
                } else if (exists) {
                  return 'This company already exists';
                }
                return null;
              },
              onSaved: (value) {
                _compName = value!.trim();
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _streetController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'Street',
                hintText: 'Enter the street',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Please enter the street';
                } else if (exists) {
                  return 'This company already exists';
                }
                return null;
              },
              onSaved: (value) {
                _street = value!.trim();
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _cityController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'City',
                hintText: 'Enter the city',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Please enter the city';
                } else if (exists) {
                  return 'This company already exists';
                }
                return null;
              },
              onSaved: (value) {
                _city = value!.trim();
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _stateController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                labelText: 'State',
                hintText: 'Enter the states abbreviation',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Please enter the state';
                }
                if (value.length != 2) {
                  return "Please enter the abbreivation";
                } else if (exists) {
                  return 'This company already exists';
                }
                return null;
              },
              onSaved: (value) {
                _state = value!.trim();
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _zipcodeController,
              keyboardType: TextInputType.number,
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
                labelText: 'Zipcode',
                hintText: 'Enter the zipcode',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the zipcode';
                }
                if (value.length != 5) {
                  return 'Please enter a valid zipcode';
                } else if (exists) {
                  return 'This company already exists';
                }
                return null;
              },
              onSaved: (value) {
                _zipcode = value;
              },
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              child: const Text('Add Company'),
              onPressed: () async {
                _compAddr =
                    '${_streetController.text.trim()}, ${_cityController.text.trim()}, ${_stateController.text.trim()} ${_zipcodeController.text}';
                exists = await checkCompanyExist(
                    _compNameController.text, _compAddr!);
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  FirebaseFirestore.instance.collection('company').add({
                    'name': _compName,
                    'address': _compAddr,
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
