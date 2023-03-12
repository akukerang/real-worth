import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPassword2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? current = FirebaseAuth.instance.currentUser;
  String? _currentPassword;
  String? _newPassword;
  String? _newPasswordVerified;
  bool _correctPassword = true;

  bool checkPasswordStrength(String password) {
    if (password.length < 6) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkPassword(String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
          email: current!.email!, password: password);
      await current?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Password"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  "Enter current password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _currentPasswordController,
                  decoration: InputDecoration(
                      errorText: _correctPassword ? null : "Wrong Password"),
                  onSaved: (value) {
                    setState(() {
                      _currentPassword = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter a value";
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Enter new password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _newPasswordController,
                  onSaved: (value) {
                    setState(() {
                      _newPassword = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter a value";
                    }
                    if (checkPasswordStrength(value.trim())) {
                      return "Please enter a stronger password";
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Enter new password again",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextFormField(
                  controller: _newPassword2Controller,
                  obscureText: true,
                  onSaved: (value) {
                    setState(() {
                      _newPasswordVerified = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter a value";
                    }
                    if (_newPasswordController.text.trim() !=
                        _newPassword2Controller.text.trim()) {
                      return "Please enter the same password";
                    }
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    _correctPassword = await checkPassword(
                        _currentPasswordController.text.trim());
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (_correctPassword) {
                        await current?.updatePassword(_newPassword!);
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Password Changed"),
                                  content: const Text(
                                      "Your password has been successfully changed"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Close"))
                                  ],
                                ));
                      }
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
