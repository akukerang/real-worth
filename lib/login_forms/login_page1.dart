import 'package:flutter/material.dart';
import 'package:real_worth/registration/create_account.dart';
import '../components/my_button.dart';
import '../components/rect_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  //text editing controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  String? email;
  String? password;
  bool loginFail = false;
  //sign user in
  void signUserIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            });

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
      } on FirebaseAuthException catch (e) {
        setState(() {
          loginFail = true;
        });
        print('test $e');
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                //shrinkWrap: true,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 32,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    labelText: 'Enter Username',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      email = newValue;
                    },
                    errorText:
                        loginFail ? 'Wrong email or Wrong password' : null,
                  ),

                  const SizedBox(height: 10),

                  //password TextField
                  MyTextField(
                    controller: passwordController,
                    obscureText: true,
                    hintText: 'Enter Password',
                    labelText: 'Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      password = newValue;
                    },
                    errorText:
                        loginFail ? 'Wrong email or Wrong password' : null,
                  ),

                  const SizedBox(height: 10),

                  // forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  //sign in button
                  MyButton(onTap: signUserIn, label: "Sign In"),

                  const SizedBox(height: 40),

                  //or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                              Divider(thickness: 1.0, color: Colors.grey[400]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child:
                              Divider(thickness: 1.0, color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  //google or email
                  const RectTile(
                    imagePath: 'lib/images/google.png',
                    imgDis: 'Continue with Google',
                  ),

                  const SizedBox(height: 50),

                  //or continue with

                  //not a memeber? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccount(),
                            ),
                          );
                        },
                        child: const Text(
                          'Create an account',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
