import 'package:flutter/material.dart';

import 'changeCompany.dart';

class SettingsPage extends StatelessWidget {
  final String current;
  const SettingsPage({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Company'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditCompany(
                            current: current,
                          )));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              // Add Change Password
            },
          ),
          ListTile(
            title: Text('Change Email'),
            onTap: () {
              // Add Change Email
            },
          ),
          Divider(),
          ListTile(
            title: Text('Help'),
            subtitle: Text('Need help? Contact us'),
          ),
          Divider(),
          ListTile(
            title: Text('Contact Us'),
            onTap: () {
              // Add later
            },
          ),
          ListTile(
            title: Text('Report a Bug'),
            onTap: () {
              // Add later
            },
          ),
          ListTile(
            title: Text('Request a Feature'),
            onTap: () {
              // Add later
            },
          ),
          Divider(),
          ListTile(
            title: Text('Notifications'),
            subtitle: Text('Control notification settings'),
          ),
          SwitchListTile(
            title: Text('Push Notifications'),
            onChanged: (value) {
              // Idk how you'd make this work but make it happen
            },
            value: true,
          ),
          Divider(),
          ListTile(
            title: Text('Delete Account'),
            onTap: () {
              // Add Delete Account
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              // Add Sign Out
            },
          ),
        ],
      ),
    );
  }
}
