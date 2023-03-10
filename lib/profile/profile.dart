import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String current;
  final String currCompID;
  ProfilePage({
    required this.current,
    required this.currCompID,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? email;

  String? location;

  String? jobTitle;

  String? company;

  String? salary;

  String? race;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference company =
        FirebaseFirestore.instance.collection('company');
    return FutureBuilder<List<DocumentSnapshot>>(
      future: Future.wait([
        users.doc(widget.current).get(),
        company.doc(widget.currCompID).get()
      ]),
      builder: (BuildContext context,
          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> user =
              snapshot.data![0].data() as Map<String, dynamic>;
          Map<String, dynamic> company =
              snapshot.data![1].data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Your Profile'),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Gender',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 8.0),
                  Text(
                    '${user['gender']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Education',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 8.0),
                  Text(
                    '${user['education']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Race',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 8.0),
                  Text(
                    '${user['race']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Location',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 8.0),
                  Text(
                    '${company['address']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Job',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 8.0),
                  Text(
                    '${user['job']['job_title']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Company',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 8.0),
                  Text(
                    '${company['name']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Salary',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 8.0),
                  Text(
                    '${user['job']['salary']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 24.0),
                  Center(
                    child: ElevatedButton(
                      child: Text('Edit Profile'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilePage())); //this should pass current data
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
