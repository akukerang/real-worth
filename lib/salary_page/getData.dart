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
