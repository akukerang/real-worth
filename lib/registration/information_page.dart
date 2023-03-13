import "package:flutter/material.dart";
import "../components/my_button.dart";
import "../components/my_dropdown.dart";
import "job_info_page.dart";

class InformationPage extends StatefulWidget {
  final String email;
  final String password;
  const InformationPage({
    super.key,
    required this.email,
    required this.password
    });
  
  @override
  State<InformationPage> createState() => _InformationPageState();

}

class _InformationPageState extends State<InformationPage> {
  final _formKey = GlobalKey<FormState>();
  
  String? _gender;
  String? _education;
  String? _race;

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
            
                  //your Information title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                      Text(
                        'Your Information',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 32,
                        ),
                      ),
                    ],),
                  ),
                  
                  const SizedBox(height: 50),
                    
                  //race
                  MyDropdown(
                    menuItems: const [
                    'White', 
                    'Black',  
                    'Asian', 
                    'Latino',
                    'Other' 
                    ], 
                    value: _race,
                    hint: 'Select a Race',
                    validatorReturn: 'Please select a race',
                    personInfo: _race
                    ),
                    
                   const SizedBox(height: 40),
                   
                  //gender
                  MyDropdown(
                    menuItems: const [
                      'Male', 
                      'Female',
                      'Other'], 
                    value: _gender,
                    hint: 'Select Gender',
                    validatorReturn: 'Please select a gender',
                    personInfo: _gender
                    ),
                  
                  const SizedBox(height: 40),
                    
                  //education
                  MyDropdown(
                    menuItems: const [
                      'None',
                      'High School',
                      'Associates',
                      'Bachelors',
                      'Masters',
                      'PHD'],
                    value: _education,
                    hint: 'Select Education Level',
                    validatorReturn: 'Please select a education level',
                    personInfo: _education
              ),
            
               const SizedBox(height: 60),

              MyButton(
                    buttonText: 'Next',
                    onTap: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobInfoPage(
                        gender: _gender!,
                        education: _education!,
                        race: _race!,
                        email: widget.email,
                        password: widget.password
                      ),
                    ),
                  );
                }
              },
            ),
            ]),
          ),
        ),
      )
    )
  );
}
}