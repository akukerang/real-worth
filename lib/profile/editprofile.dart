import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _fullName = "Tristan Baldeo";
  String _email = "tdotbaldeo@gmail.com";
  String _city = "Lake Worth";
  String _state = "FL";
  String _jobTitle = "Homeless";
  String _company = "Nowhere";
  String _salary = "100,000";
  String? _race;
  List<String> _raceOptions = [
    "American Indian or Alaskan Native",
    "Asian",
    "Black or African American",
    "Native Hawaiian or other Pacific Islander",
    "White"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              Text(
                "Full Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              TextFormField(
                initialValue: _fullName,
                onChanged: (value) {
                  setState(() {
                    _fullName = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                _email,
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              Divider(),
              SizedBox(height: 16.0),
              Text(
                "City",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              TextFormField(
                initialValue: _city,
                onChanged: (value) {
                  setState(() {
                    _city = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                "State",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              TextFormField(
                initialValue: _state,
                onChanged: (value) {
                  setState(() {
                    _state = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                "Job Title",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              TextFormField(
                initialValue: _jobTitle,
                onChanged: (value) {
                  setState(() {
                    _jobTitle = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                "Company",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              TextFormField(
                initialValue: _company,
                onChanged: (value) {
                  setState(() {
                    _company = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                "Salary",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              TextFormField(
                initialValue: _salary,
                onChanged: (value) {
                  setState(() {
                    _salary = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                "Race",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              DropdownButtonFormField(
                value: _race,
                items: _raceOptions.map((race) {
                  return DropdownMenuItem(
                    value: race,
                    child: Text(race),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _race = value as String?;
                  });
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // THIS DOESNT WORK BUT SHOULD TAKE YOU BACK TO PROFILE
                },
                child: Text("Save Options"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
