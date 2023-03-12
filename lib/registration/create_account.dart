import 'package:flutter/material.dart';
import 'package:real_worth/login_forms/login_page1.dart';
import 'package:real_worth/registration/information_page.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../salary_page/getData.dart';
class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? _email;
  String? _password;
  String? _gender;
  String? _education;
  String? _race;

  late bool emailExist;
  bool weakPassword = false;

  //check later
  bool passwordsMatch(String value) {
    if(value == _password) {
      return true;
    } else {
      return false;
    }
  }

  // void createAccount() async {
  // emailExist = await checkEmailExist(emailController.text);
  // if (passwordController.text.length < 6) {
  //   weakPassword = true;
  // } else {
  //   weakPassword = false;
  // }
  // if (_formKey.currentState!.validate()) {
  //   _formKey.currentState!.save();

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => (
  //         email: _email!,
  //         password: _password!,
  //     ),
  //     ),
  //   );
  // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  const SizedBox(height: 60),
            
                  //title
                  Text(
                    'Sign up!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 32,
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  
                  //email
                  MyTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  hintText: 'Enter Email',
                  validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your email';
                  } else if (emailExist) {
                    return 'This account already exists';
                  }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!.trim();
                  },
                ),
            
            
                  const SizedBox(height: 10),
            
                  //password and confirm password
                  MyTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                   } else if (weakPassword) {
                      return 'Please choose a stronger password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  }
                  ),
            
                  const SizedBox(height: 10),
            
                  MyTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Enter Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm password';
                   } else if (!passwordsMatch(value)) {
                      _password = null;
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                  ),
                  
                  const SizedBox(height: 25),  
                  
                  //create account button
                  MyButton(
                    buttonText: 'Create Account',
                    onPressed: () async {
                emailExist = await checkEmailExist(emailController.text);
                if (passwordController.text.length < 6) {
                  weakPassword = true;
                } else {
                  weakPassword = false;
                }
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformationPage(
                        email: _email!,
                        password: _password!,
                      ),
                    ),
                  );
                }
              },

                  ),
                  
                  const SizedBox(height: 50),
            
                   
                //sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ]
                  )
                ]
              ),
            ),
          )
        )
      )
    );
  }
}