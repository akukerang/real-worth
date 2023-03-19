import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getJobInfo extends StatelessWidget {
  final String UID;
  getJobInfo(this.UID);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(UID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'SF Pro Rounded',
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
              children: [
                TextSpan(
                    text: "${data['job']['job_title']} ",
                    style: const TextStyle(fontWeight: FontWeight.w400)),
                const TextSpan(text: "Salaries at\n"),
                TextSpan(
                    text: "${data['job']['company_name']}",
                    style: const TextStyle(fontWeight: FontWeight.w400))
              ],
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}

Future<String> getCompanyID(String docID) async {
  final snap =
      await FirebaseFirestore.instance.collection('users').doc(docID).get();
  return snap.get('job.company_id');
}

Future<String> getJobName(String docID) async {
  final snap =
      await FirebaseFirestore.instance.collection('users').doc(docID).get();
  return snap.get('job.job_title');
}

Future<bool> checkEmailExist(String email) async {
  List<String> temp =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  if (temp.isEmpty) {
    return false;
  } else {
    return true;
  }
}

Future<bool> checkCompanyExist(String name, String city, String state) async {
  CollectionReference companies =
      FirebaseFirestore.instance.collection('company');
  QuerySnapshot snap = await companies
      .where('name', isEqualTo: name)
      .where('city', isEqualTo: city)
      .where('state', isEqualTo: state)
      .get();
  return snap.docs.isNotEmpty; //if isn't empty, company already exists.
}
