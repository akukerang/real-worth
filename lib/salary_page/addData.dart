import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.add({
    'race': "test",
    'gender': "test",
    'education': "test",
    'job': {
      'company_id': "test",
      'company_name': "test",
      'job_title': "test",
      'salary': 12,
      'years': 727,
    }
  });
}
