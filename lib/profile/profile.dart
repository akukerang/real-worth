import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'settings.dart';
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
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SettingsPage(current: widget.current)));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {});
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Gender',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    '${user['gender']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Education',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    '${user['education']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Race',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    '${user['race']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Job',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    '${user['job']['job_title']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Salary',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    '${user['job']['salary']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Company',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    '${company['name']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Location',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    '${company['address']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: ElevatedButton(
                      child: const Text('Edit Profile'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                      current: widget.current,
                                      compID: widget.currCompID,
                                      compName: company['name'],
                                    ))); //this should pass current data
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
