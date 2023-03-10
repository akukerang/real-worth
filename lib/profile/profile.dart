import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF4839CD),
      )),
      home: ProfilePage(
        fullName: 'Tristan Baldeo',
        email: 'tdotbaldeo@gmail.com',
        city: 'Lake Worth',
        state: 'FL',
        jobTitle: 'Software Engineer',
        company: 'Walmart',
        salary: '100,000',
        race: 'Asian',
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String fullName;
  final String email;
  final String city;
  final String state;
  final String jobTitle;
  final String company;
  final String salary;
  final String race;

  ProfilePage({
    required this.fullName,
    required this.email,
    required this.city,
    required this.state,
    required this.jobTitle,
    required this.company,
    required this.salary,
    required this.race,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              fullName,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.0),
            Text(
              'Email',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              email,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 32.0),
            Text(
              'Location',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              '$city, $state',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 32.0),
            Text(
              'Job',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              jobTitle,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Company',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              company,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Salary',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              salary,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Race',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              race,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                child: Text('Edit Profile'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
