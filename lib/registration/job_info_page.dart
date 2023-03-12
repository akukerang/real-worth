// import 'package:flutter/material.dart';
// import '../components/my_textfield.dart';

// class JobInfoPage extends StatelessWidget {
  
//   JobInfoPage({super.key});

//   final companyNameController = TextEditingController();
//   final addressController = TextEditingController();
//   final stateController = TextEditingController();
//   final cityController = TextEditingController();
//   final salaryController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold (
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
              
//               //title
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Row(
//                   children: [
//                   Text(
//                     'Job Information',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                       fontSize: 32,
//                     ),
//                   ),
//                 ],),
//               ),
              
//               const SizedBox(height: 50),

//               //company name
//               MyTextField(
//                 controller: companyNameController,
//                 hintText:'Company Name', 
//                 obscureText: false),
              
//               const SizedBox(height: 40),

//               //address
//               MyTextField(
//                 controller: companyNameController,
//                 hintText:'Street Address', 
//                 obscureText: false),
              
//               const SizedBox(height: 40),

//               MyTextField(
//                 controller: stateController, 
//                 hintText: 'State', 
//                 obscureText: false),
              
//               const SizedBox(height: 40),

//               MyTextField(
//                 controller: cityController, 
//                 hintText: 'City', 
//                 obscureText: false)
//             ]
//           ), 
//         ),
//       ),
//     );
    
//   }
// }