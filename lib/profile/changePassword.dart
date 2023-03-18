import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_worth/components/label.dart';
import 'package:real_worth/components/my_button.dart';
import 'package:real_worth/components/my_textfield.dart';
import '../global/globalStyle.dart';

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
                const Label(label: "Current Password"),
                MyTextField(
                  obscureText: true,
                  controller: _currentPasswordController,
                  hintText: "Enter your current password",
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
                
                const Label(label: "New Password"),
                
                MyTextField(
                  obscureText: true,
                  controller: _newPasswordController,
                  onSaved: (value) {
                    setState(() {
                      _newPassword = value!.trim();
                    });
                  },
                  hintText: "Enter a new password",
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter a value";
                    }
                    if (checkPasswordStrength(value.trim())) {
                      return "Please enter a stronger password";
                    }
                  },
                ),
                
                const Label(label: "Confirm Password"),
                
                MyTextField(
                  controller: _newPassword2Controller,
                  hintText: "Enter the new password again",
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
                
                MyButton(
                  label: "Save Changes",
                  onTap: () async {
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
                                        style: componentStyle.elevatedStyle(),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Close"))
                                  ],
                                ));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
