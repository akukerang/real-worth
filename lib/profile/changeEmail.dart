import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_worth/components/my_button.dart';
import '../global/globalStyle.dart';

class changeEmail extends StatefulWidget {
  const changeEmail({Key? key}) : super(key: key);

  @override
  _changeEmailState createState() => _changeEmailState();
}

class _changeEmailState extends State<changeEmail> {
  final _newEmailController = TextEditingController();
  final _newEmail2Controller = TextEditingController();
  final _currentPasswordController = TextEditingController();

  String? _currentPassword;

  final _formKey = GlobalKey<FormState>();
  User? current = FirebaseAuth.instance.currentUser;
  String? _newEmail;
  bool _correctPassword = true;
  bool _validEmail = true;

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
        title: const Text("Change Email"),
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
                  "Current Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  obscureText: true,
                  controller: _currentPasswordController,
                  decoration: componentStyle.textFieldStyle(),
                  onSaved: (value) {
                    setState(() {
                      _currentPassword = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter a value";
                    }
                    if (!_correctPassword) {
                      return "Wrong Password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Current New Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _newEmailController,
                  decoration: componentStyle.textFieldStyle(),
                  onSaved: (value) {
                    setState(() {
                      _newEmail = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter a value";
                    }
                    if (!_validEmail) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Confirm Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _newEmail2Controller,
                  decoration: componentStyle.textFieldStyle(),
                  onSaved: (value) {
                    setState(() {
                      _newEmail = value!.trim();
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter a value";
                    }
                    if (_newEmailController.text.trim() !=
                        _newEmail2Controller.text.trim()) {
                      return "Email does not match";
                    }
                  },
                ),
                const SizedBox(height: 32.0),
                MyButton(
                  label: "Save Changes",
                  onTap: () async {
                    _correctPassword = await checkPassword(
                        _currentPasswordController.text.trim());
                    _validEmail = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_newEmailController.text.trim());
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (_correctPassword && _validEmail) {
                        current
                            ?.updateEmail(_newEmail!)
                            .catchError((onError) => print(onError));

                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Email Changed"),
                                  content: const Text(
                                      "Your email has been successfully changed"),
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
