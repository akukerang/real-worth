import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser(
    String race,
    String gender,
    String education,
    String company_id,
    String company_name,
    String job_title,
    int salary,
    int years) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.add({
    'race': race,
    'gender': gender,
    'education': education,
    'job': {
      'company_id': company_id,
      'company_name': company_name,
      'job_title': job_title,
      'salary': salary,
      'years': years
    }
  });
}
