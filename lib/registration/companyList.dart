import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_worth/registration/jobForm.dart';
import 'package:real_worth/registration/registerCompany.dart';

class CompanyList extends StatefulWidget {
  final String email;
  final String password;
  final String gender;
  final String education;
  final String race;

  const CompanyList({
    Key? key,
    required this.email,
    required this.password,
    required this.gender,
    required this.education,
    required this.race,
  }) : super(key: key);

  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _companyList = [];
  DocumentSnapshot? _selectedCompany;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchCompanies);
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

  void _selectCompany(DocumentSnapshot company) {
    setState(() {
      _selectedCompany = company;
    });
  }

  void _submitSelection() {
    if (_selectedCompany != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JobPage(
            email: widget.email,
            password: widget.password,
            gender: widget.gender,
            education: widget.education,
            race: widget.race,
            companyID: _selectedCompany!.id,
            companyName: _selectedCompany!['name'],
            companyAddr: _selectedCompany!['address'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          'Location: ${company['address']}',
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
                    onPressed: _submitSelection,
                    child: const Text('Select Company'),
                  ),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
