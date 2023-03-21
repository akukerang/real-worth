import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_worth/registration/registerCompany.dart';

class EditCompany extends StatefulWidget {
  final String current;
  const EditCompany({super.key, required this.current});

  @override
  _EditCompanyState createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _companyList = [];
  DocumentSnapshot? _selectedCompany;
  DocumentSnapshot? _currentUser;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchCompanies);
    _currentUserData();
  }

  void _searchCompanies() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _companyList = [];
      });
      return;
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('company')
        .where('name', isGreaterThanOrEqualTo: _searchController.text)
        .where('name', isLessThanOrEqualTo: _searchController.text + '\uf8ff')
        .get();

    setState(() {
      _companyList = querySnapshot.docs;
    });
  }

  void _currentUserData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.current)
        .get();

    setState(
      () {
        _currentUser = documentSnapshot;
      },
    );
  }

  void _selectCompany(DocumentSnapshot company) {
    setState(() {
      _selectedCompany = company;
    });
  }

  void _submitSelection() {
    if (_selectedCompany != null) {
      FirebaseFirestore.instance.collection('users').doc(widget.current).set({
        'education': _currentUser!['education'],
        'gender': _currentUser!['gender'],
        'job': {
          'company_id': _selectedCompany!.id,
          'company_name': _selectedCompany!['name'],
          'job_title': _currentUser!['job']['job_title'],
          'salary': _currentUser!['job']['salary'],
          'years': _currentUser!['job']['years'],
        },
        'race': _currentUser!['race'],
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Company Changed"),
                content:
                    const Text("Your company has been successfully changed"),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent[400]),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Close"))
                ],
              ));
    }
    _currentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[400],
        title: const Text('Company List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search companies...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _companyList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot company = _companyList[index];
                return GestureDetector(
                  onTap: () => _selectCompany(company),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: _selectedCompany == company
                          ? Colors.blue[100]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company['name'],
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Location: ${company['city']}, ${company['state']}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_selectedCompany != null)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent[400]),
                    onPressed: _submitSelection,
                    child: const Text('Select Company'),
                  ),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent[400],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterCompany(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
