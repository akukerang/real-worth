import 'package:flutter/material.dart';
import 'package:real_worth/components/my_textfield.dart';
import 'package:real_worth/global/globalStyle.dart';
import 'package:real_worth/registration/information_page.dart';
import '../components/my_button.dart';
import '../salary_page/getData.dart';
import '../components/label.dart';

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
  String? _confirm;

  late bool emailExist;
  bool weakPassword = false;
  bool validEmail = true;
  bool matching = true;
  //check later
  bool passwordsMatch(String value) {
    if (value == passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //const SizedBox(height: 60),

            //title
            Text(
              'Sign up!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 32,
              ),
            ),

            const SizedBox(height: 20),

            Label(label: "Email"),
            //email
            MyTextField(
              controller: emailController,
              hintText: "Choose an email",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Please enter a value';
                } else if (!validEmail) {
                  return 'Please enter a valid email';
                } else if (emailExist) {
                  return 'This account already exists';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!.trim();
              },
            ),

            Label(label: "Password"),

            //password and confirm password
            MyTextField(
                controller: passwordController,
                hintText: "Choose a password",
                obscureText: true,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter a value';
                  } else if (weakPassword) {
                    return 'Please choose a stronger password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!.trim();
                }),

            Label(label: "Confirm Password"),

            MyTextField(
              hintText: "Confirm Password",
              controller: confirmPasswordController,
              obscureText: true,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Please enter a value';
                } else if (!matching) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onSaved: (value) {},
            ),

            const SizedBox(height: 25),

            //create account button
            MyButton(
              label: 'Create Account',
              onTap: () async {
                if (emailController.text.trim().isNotEmpty) {
                  await checkEmailExist(emailController.text.trim())
                      .then((value) {
                    emailExist = value;
                  }).onError((error, stackTrace) {
                    print("test ${error!}");
                  });
                  validEmail = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailController.text.trim());
                }
                if (passwordController.text.trim().length < 6) {
                  weakPassword = true;
                } else {
                  weakPassword = false;
                }
                matching =
                    passwordsMatch(confirmPasswordController.text.trim());

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
          ]),
        ),
      ),
    ))));
  }
}
