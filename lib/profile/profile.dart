import 'package:flutter/material.dart';
import '../salary_page/getData.dart';
import 'editprofile.dart';
import 'settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global/globalStyle.dart';

class ProfilePage extends StatefulWidget {
  final String current;

  ProfilePage({ 
    required this.current,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? email;

  String? location;

  String? jobTitle;

  String? salary;

  String? race;

  String? companyId;

  Future<void> setCompanyID() async {
    try {
      companyId = await getCompanyID(widget.current);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    CollectionReference companyCollection =
        FirebaseFirestore.instance.collection('company');
    return FutureBuilder<List<DocumentSnapshot>>(
      future: Future.wait([
        userCollection.doc(widget.current).get(),
        setCompanyID().then((value) => companyCollection.doc(companyId).get())
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
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    '${company['city']}, ${company['state']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: ElevatedButton(
                      style: componentStyle.elevatedStyle(),
                      child: const Text('Edit Profile'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                      current: widget.current,
                                      compID: companyId!,
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
