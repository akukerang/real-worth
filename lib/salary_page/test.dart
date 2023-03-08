import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class userData {
  userData(this.years, this.salary);
  final int years;
  final int salary;
}

class Test extends StatelessWidget {
  CollectionReference db = FirebaseFirestore.instance.collection('users');

  Future<List<userData>> getData() async {
    QuerySnapshot snap = await db.where('gender', isEqualTo: 'male').get();
    final List<userData> allData = snap.docs
        .map((doc) => userData(doc['job']['salary'], doc['job']['years']))
        .toList();
    print('test');
    for (var userData in allData) {
      print('${userData.years}, ${userData.salary}');
    }
    return allData;
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Container(color: Colors.black);
  }
}
