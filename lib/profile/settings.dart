import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('General'),
            subtitle: Text('Change your account settings'),
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
