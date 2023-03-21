import 'package:flutter/material.dart';
import 'package:real_worth/profile/changeEmail.dart';

import 'changeCompany.dart';
import 'changePassword.dart';

class SettingsPage extends StatelessWidget {
  final String current;
  const SettingsPage({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[400],
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Change Company'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditCompany(
                            current: current,
                          )));
            },
          ),
          const Divider(thickness: 1.0),
          ListTile(
            title: const Text('Change Password'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const changePassword()));
            },
          ),
          const Divider(thickness: 1.0),
          ListTile(
            title: const Text('Change Email'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const changeEmail()));
            },
          ),
          const Divider(thickness: 1.0),
        ],
      ),
    );
  }
}
