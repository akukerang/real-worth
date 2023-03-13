import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'salary_page/salary.dart';
import 'salary_page/getData.dart';
import 'profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

int _selectedIndex = 0;
int _categoryIndex = 0;
final String current =
    FirebaseAuth.instance.currentUser!.uid; //Gets current users ID

class HomePageState extends State<HomePage> {
  late String companyID;

  @override
  void initState() {
    super.initState();
    getCompanyID(current).then((value) {
      setState(() {
        companyID =
            value; // set the value of companyID once getCompanyID has completed
        _widgetOptions[0] = SalaryPage(
          category: _categoryOptions[_categoryIndex],
          current: current,
          company: companyID,
        );
        _widgetOptions[1] =
            ProfilePage(current: current, currCompID: companyID);
      });
    });
  }

  void _updateCategory() {
    setState(() {
      if (_categoryIndex == 2) {
        _categoryIndex = -1;
      }
      _categoryIndex++;
      _widgetOptions[0] = SalaryPage(
        category: _categoryOptions[_categoryIndex],
        current: current,
        company: companyID,
      );
    });
  }

  static final List<String> _categoryOptions = ["gender", "education", "race"];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    const Placeholder(),
    const Placeholder(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      signUserOut();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _updateCategory,
              child: const Icon(Icons.sort),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Sign Out',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
